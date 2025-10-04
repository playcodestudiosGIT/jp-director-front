import 'package:flutter/material.dart';
import 'package:jp_director/providers/all_blogs_provider.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import '../models/blog.dart';
import '../services/notificacion_service.dart';
import '../ui/shared/botones/custom_button.dart';
import '../ui/shared/modals/blogs_modal.dart';

class BlogsDTS extends DataTableSource {
  final BuildContext context;
  final int length;

  BlogsDTS(this.context, this.length);

  @override
  DataRow getRow(int index) {
    List<Blog> blogs = Provider.of<AllBlogsProvider>(context).allBlogs;
    final blog = blogs[index];
    
    // Formatear fecha para mostrar
    final fechaPublicacion = blog.fechaPublicacion;
    final fechaFormateada = '${fechaPublicacion.day}/${fechaPublicacion.month}/${fechaPublicacion.year}';

    return DataRow(cells: [
      // Columna de imagen
      DataCell(Center(
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: blog.imagen.isNotEmpty
              ? Image.network(
                  blog.imagen,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image, size: 50, color: Colors.grey);
                  },
                )
              : const Icon(Icons.image, size: 50, color: Colors.grey),
        ),
      )),
      
      // Columna de título en español
      DataCell(Text(
        blog.tituloEs,
        style: DashboardLabel.paragraph.copyWith(color: blancoText),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      )),
      
      // Columna de título en inglés
      DataCell(Text(
        blog.tituloEn,
        style: DashboardLabel.paragraph.copyWith(color: blancoText),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      )),
      
      // Columna de fecha de publicación
      DataCell(Text(
        fechaFormateada,
        style: DashboardLabel.paragraph.copyWith(color: blancoText),
      )),
      
      // Columna de publicado
      DataCell(Row(
        children: [
          Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: blog.publicado ? Colors.green : Colors.red,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            blog.publicado ? 'Publicado' : 'No Publicado',
            style: DashboardLabel.paragraph.copyWith(color: blancoText),
          ),
        ],
      )),
      
      // Columna de acciones
      DataCell(Row(
        children: [
          // Botón editar
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () {
              // Usamos Future.delayed para evitar problemas de setState durante build
              Future.delayed(Duration.zero, () async {
                final allBlogsProvider = Provider.of<AllBlogsProvider>(context, listen: false);
                
                // Mostrar indicador de carga
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const AlertDialog(
                    backgroundColor: bgColor,
                    content: SizedBox(
                      height: 100,
                      child: Center(child: CircularProgressIndicator(color: azulText)),
                    ),
                  ),
                );
                
                try {
                  // Cargar los datos del blog
                  await allBlogsProvider.getBlogModal(blog.id);
                  
                  // Cerrar indicador de carga
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                  
                  // Mostrar modal
                  if (context.mounted) {
                    await showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => BlogsModal(id: blog.id),
                    );
                    
                    // Recargar después de cerrar el modal
                    if (context.mounted) {
                      await Provider.of<AllBlogsProvider>(context, listen: false).getAllBlogs();
                      notifyListeners();
                    }
                  }
                } catch (e) {
                  // Cerrar indicador de carga en caso de error
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                  NotifServ.showSnackbarError('Error al cargar blog: $e', Colors.red);
                }
              });
            },
          ),
          
          // Botón eliminar
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              _showDeleteConfirmationDialog(context, blog);
            },
          ),
          
          // Botón ver
          IconButton(
            icon: const Icon(Icons.visibility, color: Colors.green),
            onPressed: () {
              // Navegar a la vista del blog
              Navigator.pushNamed(context, '/blog/${blog.id}');
            },
          ),
        ],
      )),
    ]);
  }

  void _showDeleteConfirmationDialog(BuildContext context, Blog blog) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: bgColor,
          title: Text(
            '¿Eliminar blog?',
            style: DashboardLabel.h3.copyWith(color: blancoText),
          ),
          content: Text(
            '¿Estás seguro de que deseas eliminar el blog "${blog.tituloEs}"? Esta acción no se puede deshacer.',
            style: DashboardLabel.paragraph.copyWith(color: blancoText),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar', style: TextStyle(color: blancoText)),
            ),
            CustomButton(
              text: 'Eliminar',
              onPress: () async {
                Navigator.pop(context);
                
                print('Iniciando eliminación del blog ID: ${blog.id}');
                final provider = Provider.of<AllBlogsProvider>(context, listen: false);
                
                final success = await provider.deleteBlog(blog.id);
                
                if (success) {
                  NotifServ.showSnackbarError('Blog eliminado con éxito', Colors.green);
                  // Recargar después de eliminar - esto ya se hace en el método deleteBlog
                  // pero lo mantenemos como precaución adicional
                  await provider.getAllBlogs();
                  notifyListeners();
                } else {
                  print('Falló la eliminación del blog ID: ${blog.id}');
                }
              },
              color: Colors.red,
              width: 120,
            ),
          ],
        );
      },
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => length;

  @override
  int get selectedRowCount => 0;
}