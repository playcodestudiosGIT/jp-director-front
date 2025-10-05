import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import '../../models/blog.dart';
import '../../providers/auth_provider.dart';
import '../../services/navigator_service.dart';
import 'blog_card.dart';

class ArticulosRelacionados extends StatelessWidget {
  final List<Blog> blogs;
  
  const ArticulosRelacionados({
    super.key,
    required this.blogs,
  });

  @override
  Widget build(BuildContext context) {
    // Para futuras traducciones, usamos listen: false para evitar reconstrucciones
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final idioma = authProvider.locale.languageCode;
    
    // Verificar si hay blogs relacionados para mostrar
    if (blogs.isEmpty) {
      print('No hay blogs relacionados para mostrar');
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(color: Colors.grey.shade600, thickness: 1),
            const SizedBox(height: 20),
            Text(
              'Artículos Relacionados',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: blancoText,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Text(
                  'No hay artículos relacionados disponibles',
                  style: TextStyle(
                    fontSize: 16,
                    color: blancoText.withOpacity(0.7),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    
                  // Debug detallado: Mostrar información de los blogs relacionados con todas las propiedades
    print('Mostrando ${blogs.length} blogs relacionados');
    for (var blog in blogs) {
      print('Blog relacionado ID: ${blog.id}');
      print('- Título ES: "${blog.tituloEs}"');
      print('- Título EN: "${blog.tituloEn}"');
      print('- Imagen: "${blog.img}"');
      print('- Fecha publicación: ${blog.fechaPublicacion}');
      print('- Publicado: ${blog.publicado}');
      print('- Contenido ES (primeros 20 chars): "${blog.contenidoEs.length > 20 ? blog.contenidoEs.substring(0, 20) + '...' : blog.contenidoEs}"');
      print('- Contenido EN (primeros 20 chars): "${blog.contenidoEn.length > 20 ? blog.contenidoEn.substring(0, 20) + '...' : blog.contenidoEn}"');
    }    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: Colors.grey.shade600, thickness: 1),
          const SizedBox(height: 20),
          Text(
            'Artículos Relacionados',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: blancoText,
            ),
          ),
          const SizedBox(height: 20),
          // Usamos un Builder para crear un nuevo contexto y evitar problemas de rebuild
          Builder(
            builder: (builderContext) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  final cardWidth = constraints.maxWidth > 800 ? 250.0 : constraints.maxWidth * 0.8;
                  
                  // Protección adicional contra errores de layout
                  if (constraints.maxWidth == 0) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: const Center(
                        child: CircularProgressIndicator(color: azulText),
                      ),
                    );
                  }
                  
                  return Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.start,
                children: this.blogs.map((blog) {
                  // Formato de fechas
                  final date = '${blog.fechaPublicacion.day}/${blog.fechaPublicacion.month}/${blog.fechaPublicacion.year}';
                  
                  // Manejo seguro de título
                  final title = blog.getTitulo(idioma).isNotEmpty 
                      ? blog.getTitulo(idioma)
                      : 'Título no disponible';
                  
                  // Manejo seguro de descripción según el idioma
                  final String contenido = idioma == 'es' ? blog.contenidoEs : blog.contenidoEn;
                  final cleanDescription = contenido.isNotEmpty
                      ? (contenido.length > 100 ? '${contenido.substring(0, 100)}...' : contenido)
                      : 'Leer este artículo relacionado';
                  
                  // Imagen del blog
                  final imagen = blog.img;
                  
                  return SizedBox(
                    width: cardWidth > 280 ? 280 : cardWidth,
                    child: BlogCard(
                      date: date,
                      title: title,
                      description: cleanDescription,
                      articleId: blog.id,
                      imagen: imagen,
                      width: cardWidth > 280 ? 280 : cardWidth,
                    ),
                  );
                }).toList(),
              );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}