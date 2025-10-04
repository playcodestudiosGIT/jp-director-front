import 'package:flutter/material.dart';
import 'package:jp_director/constant.dart';
import 'package:jp_director/providers/all_blogs_provider.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';
import 'package:provider/provider.dart';

import '../../../datatables/blogs_datasource.dart';
import '../../shared/labels/title_label.dart';
import '../../shared/modals/blogs_modal.dart';

class BlogsAdminView extends StatefulWidget {
  const BlogsAdminView({super.key});

  @override
  State<BlogsAdminView> createState() => _BlogsAdminViewState();
}

class _BlogsAdminViewState extends State<BlogsAdminView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    // Usar Future.delayed para evitar setState durante build
    Future.delayed(Duration.zero, () {
      if (mounted) {
        _refreshBlogs();
      }
    });
  }
  
  // Método para recargar blogs de manera explícita
  Future<void> _refreshBlogs() async {
    try {
      await Provider.of<AllBlogsProvider>(context, listen: false).getAllBlogs();
      if (mounted) {
        setState(() {
          // Forzar rebuild
        });
      }
    } catch (e) {
      print('Error al recargar blogs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final allBlogsProvider = Provider.of<AllBlogsProvider>(context);
    final blogs = allBlogsProvider.allBlogs;
    final isLoading = allBlogsProvider.isLoading;
    final size = MediaQuery.of(context).size;
    
    return Container(
      padding: (size.width < 715)
          ? const EdgeInsets.only(top: 15, left: 15 / 2, right: 15 / 2)
          : const EdgeInsets.only(top: 15, left: 15 / 2, right: 15 / 2),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const SizedBox(height: 80),
          Padding(
            padding: const EdgeInsets.only(left: 0.0),
            child: TitleLabel(
              texto: 'Administración de Blogs', // Idealmente, esto vendría del appLocal
            ),
          ),
          isLoading 
            ? Center(
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    CircularProgressIndicator(color: azulText),
                    const SizedBox(height: 20),
                    Text('Cargando blogs...', style: DashboardLabel.paragraph),
                  ],
                ),
              )
            : Theme(
            data: ThemeData.dark().copyWith(cardColor: bgColor),
            child: PaginatedDataTable(
              // Usar una key que dependa del estado de los blogs para forzar la reconstrucción
              key: ValueKey('blogs-table-${blogs.length}-${DateTime.now().millisecondsSinceEpoch}'),
              columns: [
                DataColumn(
                  label: Text('Imagen', style: DashboardLabel.h4.copyWith(color: blancoText.withOpacity(0.5))),
                ),
                DataColumn(
                  label: Text('Título (ES)', style: DashboardLabel.h4.copyWith(color: blancoText.withOpacity(0.5))),
                ),
                DataColumn(
                  label: Text('Título (EN)', style: DashboardLabel.h4.copyWith(color: blancoText.withOpacity(0.5))),
                ),
                DataColumn(
                  label: Text('Fecha de publicación', style: DashboardLabel.h4.copyWith(color: blancoText.withOpacity(0.5))),
                ),
                DataColumn(
                  label: Text('Publicado', style: DashboardLabel.h4.copyWith(color: blancoText.withOpacity(0.5))),
                ),
                DataColumn(
                  label: Text('Acciones', style: DashboardLabel.h4.copyWith(color: blancoText.withOpacity(0.5))),
                ),
              ],
              source: BlogsDTS(context, blogs.length),
              header: Text(
                'Lista de Blogs',
                style: DashboardLabel.h3,
                maxLines: 2,
              ),
              rowsPerPage: _rowsPerPage,
              onRowsPerPageChanged: (value) {
                setState(() {
                  _rowsPerPage = value ?? 10;
                });
              },
              actions: [
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(azulText)),
                  onPressed: () async {
                    final allBlogsProvider = Provider.of<AllBlogsProvider>(context, listen: false);
                    allBlogsProvider.cleanBlogModal(); // Limpiar el formulario para crear un nuevo blog
                    await showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      isScrollControlled: true, // Para que el modal pueda ocupar más espacio
                      builder: (context) => const BlogsModal(id: ''),
                    );
                    
                    // Recargar blogs después de cerrar el modal
                    _refreshBlogs();
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.post_add,
                        color: bgColor,
                        size: 18,
                      ),
                      SizedBox(width: 5),
                      Text('Nuevo Blog', style: TextStyle(color: bgColor)),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}