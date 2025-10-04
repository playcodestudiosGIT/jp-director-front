import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import '../../models/blog.dart';
import '../../providers/auth_provider.dart';
import '../../services/navigator_service.dart';

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
    
    // Debug: Mostrar información de los blogs relacionados
    print('Mostrando ${blogs.length} blogs relacionados');
    for (var blog in blogs) {
      print('Blog relacionado: ${blog.id} - ${blog.getTitulo(idioma)}');
    }
    
    return Container(
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
                  final date = '${blog.fechaPublicacion.day}/${blog.fechaPublicacion.month}/${blog.fechaPublicacion.year}';
                  final title = blog.getTitulo(idioma);
                  final description = blog.getContenido(idioma);
                  final cleanDescription = description.length > 100 ? '${description.substring(0, 100)}...' : description;
                  final imagen = blog.imagen;
                  
                  return SizedBox(
                    width: cardWidth > 280 ? 280 : cardWidth,
                    child: _BlogCard(
                      date: date,
                      title: title,
                      description: cleanDescription,
                      articleId: blog.id,
                      imagen: imagen,
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

// Widget de tarjeta de blog implementado como en home_views/blog_view.dart
class _BlogCard extends StatelessWidget {
  final String date;
  final String title;
  final String description;
  final String articleId;
  final String imagen;

  const _BlogCard({
    required this.date,
    required this.title,
    required this.description,
    required this.articleId,
    required this.imagen,
  });

  @override
  Widget build(BuildContext context) {
    // Evitamos cambios de estado durante la construcción usando un Builder separado
    return Builder(
      builder: (innerContext) => Container(
        width: 280,
        height: 350,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen del artículo o placeholder si no hay imagen
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: imagen.isNotEmpty
                ? Image.network(
                    imagen,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.image,
                        color: Colors.grey,
                        size: 60,
                      );
                    },
                  )
                : const Icon(
                    Icons.image,
                    color: Colors.grey,
                    size: 60,
                  ),
            ),
          ),
          
          const SizedBox(height: 15),
          
          // Fecha
          Text(
            date,
            style: TextStyle(
              color: blancoText.withOpacity(0.6),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Título
          Text(
            title,
            style: const TextStyle(
              color: blancoText,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          
          const SizedBox(height: 8),
          
          // Descripción
          Expanded(
            child: Text(
              description,
              style: TextStyle(
                color: blancoText.withOpacity(0.7),
                fontSize: 12,
                height: 1.4,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          
          const SizedBox(height: 15),
          
          // Enlace discreto para leer más
          GestureDetector(
            onTap: () {
              NavigatorService.navigateTo('/blog/$articleId');
            },
            child: Row(
              children: [
                Text(
                  'Leer Más',
                  style: const TextStyle(
                    color: azulText,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: azulText,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 10,
                  color: azulText,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }
}