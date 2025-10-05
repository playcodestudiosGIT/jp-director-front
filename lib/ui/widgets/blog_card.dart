import 'package:flutter/material.dart';

import '../../constant.dart';
import '../../services/navigator_service.dart';

/// Widget reutilizable para mostrar una tarjeta de blog.
/// 
/// Este widget unifica la funcionalidad de _BlogCard que antes existía por separado
/// en articulos_relacionados.dart y blog_view.dart.
class BlogCard extends StatelessWidget {
  final String date;
  final String title;
  final String description;
  final String articleId;
  final String imagen;
  final double width;
  final double height;

  const BlogCard({
    Key? key,
    required this.date,
    required this.title,
    required this.description,
    required this.articleId,
    this.imagen = '',
    this.width = 280,
    this.height = 350,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Evitamos cambios de estado durante la construcción usando un Builder separado
    return Builder(
      builder: (innerContext) => Container(
        constraints: BoxConstraints(minHeight: 200),
        width: width,
        height: height,
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
                  color: const Color.fromRGBO(158, 158, 158, 0.3), // Reemplazado el withOpacity
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
              style: const TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.6), // Reemplazado el blancoText.withOpacity
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
                style: const TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.7), // Reemplazado el blancoText.withOpacity
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
              child: const Row(
                children: [
                  Text(
                    'Leer Más',
                    style: TextStyle(
                      color: azulText,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationColor: azulText,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
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