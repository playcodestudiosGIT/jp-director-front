import 'package:flutter/material.dart';
import 'package:jp_director/router/router.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../models/blog.dart';
import '../../../providers/all_blogs_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../services/navigator_service.dart';
import '../../shared/widgets/top_area_back.dart';
import '../../widgets/articulos_relacionados.dart';

class BlogArticlePage extends StatefulWidget {
  final String articleId;

  const BlogArticlePage({
    super.key,
    required this.articleId,
  });

  @override
  State<BlogArticlePage> createState() => _BlogArticlePageState();
}

// FunciÃ³n global para el ancho responsivo - 768px es el punto de quiebre para pantallas pequeÃ±as
double wSize(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final isSmallScreen = size.width < 768;
  return isSmallScreen ? size.width * 0.9 : size.width * 0.7;
}

// FunciÃ³n global para determinar si la pantalla es pequeÃ±a
bool isSmallScreen(BuildContext context) {
  return MediaQuery.of(context).size.width < 768;
}

class _BlogArticlePageState extends State<BlogArticlePage> {
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    // Diferimos la carga hasta después del primer build para evitar problemas
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _loadArticle();
      }
    });
  }
  
  // No es necesario sobreescribir dispose() para este caso

  _loadArticle() async {
    // Evitar operaciones si el widget ya no está montado
    if (!mounted) return;
    
    try {
      // Actualizar estado a carga
      setState(() {
        isLoading = true;
        hasError = false;
      });
      
      final blogProvider = Provider.of<AllBlogsProvider>(context, listen: false);
      
      // Delay mínimo para evitar problemas de renderizado
      await Future.delayed(const Duration(milliseconds: 100));
      
      // Solo continuar si el widget sigue montado
      if (!mounted) return;
      
      // Cargar el blog
      await blogProvider.getBlogById(widget.articleId);
      
      // Actualizar estado solo si el widget sigue montado
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error al cargar blog: $e');
      
      // Actualizar estado solo si el widget sigue montado
      if (mounted) {
        setState(() {
          isLoading = false;
          hasError = true;
        });
      }
    }
  }

  @override


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FocusScope(
        // Evitar problemas con el foco que causan errores de layout
        canRequestFocus: !isLoading,
        child: Stack(
          children: [
            Container(color: bgColor),
            if (isLoading)
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: azulText),
                    SizedBox(height: 15),
                    Text(
                      "Cargando blog...", // Texto fijo para evitar problemas con las traducciones
                      style: TextStyle(color: blancoText),
                    ),
                  ],
                ),
              )
            else
              const Padding(
                padding: EdgeInsets.only(top: 80.0), // Espacio para el botón de regreso
                child: _BlogArticleBody(),
              ),
            Positioned(
              top: 20,
              left: 20,
              child: SizedBox(
                width: 200, // Ancho más pequeño para evitar problemas
                child: TopAreaBack(
                  onPress: () {
                    NavigatorService.navigateTo(Flurorouter.blogRoute);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BlogArticleBody extends StatelessWidget {
  const _BlogArticleBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return _buildContent(context, constraints);
      }
    );
  }
  
  Widget _buildContent(BuildContext context, BoxConstraints constraints) {
    final blogProvider = Provider.of<AllBlogsProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    
    // Verificar si blogView es válido (no es el dummy)
    if (blogProvider.blogView.id == blogDummy.id) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: azulText),
            const SizedBox(height: 20),
            Text(
              'Cargando artículo...',
              style: TextStyle(color: blancoText, fontSize: 18),
            ),
          ],
        ),
      );
    }
    
    final blog = blogProvider.blogView; // Ya verificamos que es válido
    final size = MediaQuery.of(context).size;
    final bool smallScreen = isSmallScreen(context);

    // Obtener idioma actual desde el AuthProvider
    final currentLocale = authProvider.locale.languageCode;

    return Container(
      width: double.infinity,
      height: size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Espaciado para el botÃ³n de back
            const SizedBox(height: 80),

            // Contenido principal
            Container(
              constraints: const BoxConstraints(maxWidth: 800),
              padding: EdgeInsets.symmetric(
                horizontal: smallScreen ? 20 : 20,
                vertical: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TÃ­tulo del artÃ­culo
                  Text(
                    blog.getTitulo(currentLocale),
                    style: TextStyle(
                      color: blancoText,
                      fontSize: smallScreen ? 28 : 36,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Fecha de publicaciÃ³n
                  Text(
                    _formatDate(blog.fechaPublicacion),
                    style: TextStyle(
                      color: blancoText.withOpacity(0.6),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Imagen del artÃ­culo
                  if (blog.img.isNotEmpty)
                    Container(
                      width: double.infinity,
                      height: smallScreen ? 200 : 400,
                      margin: const EdgeInsets.only(bottom: 40),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      child: blog.img.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                blog.img,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.image,
                                    color: Colors.grey,
                                    size: 60,
                                  );
                                },
                              ),
                            )
                          : const Icon(
                              Icons.image,
                              color: Colors.grey,
                              size: 60,
                            ),
                    ),

                  // Contenido del artÃ­culo
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // PÃ¡rrafos del contenido
                        ...(blog.getContenido(currentLocale).isNotEmpty
                            ? blog.getContenido(currentLocale).split('\n\n')
                            : ['No hay contenido disponible'])
                            .map((paragraph) {
                          if (paragraph.trim().isEmpty)
                            return const SizedBox.shrink();

                          // Detectar si es un subtÃ­tulo (empieza con ## o similar)
                          if (paragraph.startsWith('##')) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 24),
                              child: Text(
                                paragraph.replaceFirst('##', '').trim(),
                                style: TextStyle(
                                  color: blancoText,
                                  fontSize: isSmallScreen(context) ? 22 : 28,
                                  fontWeight: FontWeight.bold,
                                  height: 1.3,
                                ),
                              ),
                            );
                          }

                          // PÃ¡rrafo normal
                          return Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              paragraph.trim(),
                              style: TextStyle(
                                color: blancoText.withOpacity(0.85),
                                fontSize: isSmallScreen(context) ? 16 : 18,
                                height: 1.6,
                                letterSpacing: 0.3,
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),

                  const SizedBox(height: 60),

                  // Artículos relacionados - Manejo seguro para prevenir errores de renderizado
                  if (context.mounted) 
                    Container(
                      constraints: const BoxConstraints(minHeight: 100),
                      // Verificamos si el widget está montado antes de renderizar
                      child: StatefulBuilder(
                        builder: (BuildContext ctx, StateSetter setState) {
                          return ArticulosRelacionados(
                            blogs: blog.relacionados,
                            key: ValueKey('articulos_relacionados_${blog.id}'), // Usar key para mejorar identificación
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'enero',
      'febrero',
      'marzo',
      'abril',
      'mayo',
      'junio',
      'julio',
      'agosto',
      'septiembre',
      'octubre',
      'noviembre',
      'diciembre'
    ];

    return '${date.day.toString().padLeft(2, '0')} de ${months[date.month - 1]} ${date.year}';
  }
}

// La sección RelatedArticlesSection fue reemplazada por el componente ArticulosRelacionados

// La clase _RelatedArticleCard fue reemplazada por componentes en ArticulosRelacionados
