import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constant.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/all_blogs_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../widgets/blog_card.dart';

class BlogView extends StatefulWidget {
  const BlogView({super.key});

  @override
  State<BlogView> createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView> {
  Future<dynamic>? _blogsFuture;

  @override
  void initState() {
    super.initState();
    // Cargar blogs de forma segura durante el initState
    _blogsFuture = Provider.of<AllBlogsProvider>(context, listen: false).getPublishedBlogsSN();
  }
  
  void _retryLoadingBlogs() {
    setState(() {
      _blogsFuture = Provider.of<AllBlogsProvider>(context, listen: false).getPublishedBlogsSN();
    });
  }

  @override
  void dispose() {
    _blogsFuture = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 768;
    final authProvider = Provider.of<AuthProvider>(context);

    return Container(
      width: double.infinity,
      height: size.height,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 80),
        child: Column(
          children: [
            // TÃ­tulo principal
            Text(
              AppLocalizations.of(context)?.blog ?? 'Blog',
              style: TextStyle(
                color: blancoText,
                fontSize: isSmallScreen ? 32 : 48,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 20),
            
            // DescripciÃ³n
            SizedBox(
              width: isSmallScreen ? size.width * 0.9 : 600,
              child: Text(
                AppLocalizations.of(context)?.publishedBlogs ?? 'Blogs Publicados',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: blancoText.withOpacity(0.7),
                  fontSize: isSmallScreen ? 14 : 16,
                  height: 1.5,
                ),
              ),
            ),
            
            const SizedBox(height: 60),
            
            // Grid de artÃ­culos del blog
            Expanded(
              child: FutureBuilder(
                future: _blogsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(color: azulText),
                          const SizedBox(height: 15),
                          Text(
                            AppLocalizations.of(context)?.loadingBlogs ?? 'Cargando blogs...',
                            style: TextStyle(color: blancoText),
                          ),
                        ],
                      ),
                    );
                  }
                  
                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)?.blogError ?? 'Error al cargar blogs',
                            style: TextStyle(color: blancoText),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _retryLoadingBlogs,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: azulText,
                              foregroundColor: Colors.white,
                            ),
                            child: Text(AppLocalizations.of(context)?.readMore ?? 'Leer Más'),
                          ),
                        ],
                      ),
                    );
                  }
                  
                  // Obtenemos los blogs del snapshot
                  final List<dynamic> blogs = snapshot.data as List<dynamic>;
                  if (blogs.isEmpty) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context)?.noBlogsFound ?? 'No se encontraron blogs',
                        style: TextStyle(color: blancoText),
                      ),
                    );
                  }
                  
                  final currentLocale = authProvider.locale.languageCode;
                  
                  return SingleChildScrollView(
                    child: Wrap(
                      spacing: 30,
                      runSpacing: 40,
                      alignment: WrapAlignment.center,
                      children: blogs.map((blog) { // Eliminamos el .take(6) para mostrar todos los blogs
                        return BlogCard(
                          date: _formatDate(blog.fechaPublicacion),
                          title: blog.getTitulo(currentLocale),
                          description: _getShortDescription(blog.getContenido(currentLocale)),
                          articleId: blog.id,
                          imagen: blog.img,
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final currentLocale = authProvider.locale.languageCode;
    
    final monthsEs = [
      'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
      'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'
    ];
    
    final monthsEn = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    
    if (currentLocale == 'es') {
      return '${date.day.toString().padLeft(2, '0')} de ${monthsEs[date.month - 1]} ${date.year}';
    } else {
      return '${monthsEn[date.month - 1]} ${date.day.toString().padLeft(2, '0')}, ${date.year}';
    }
  }

  String _getShortDescription(String content) {
    // Remover markdown y limitar caracteres
    final cleanContent = content.replaceAll(RegExp(r'[#*_]'), '');
    return cleanContent.length > 150 
        ? '${cleanContent.substring(0, 150)}...'
        : cleanContent;
  }
}

// La clase _BlogCard se ha eliminado y reemplazado por el componente reutilizable
// BlogCard ubicado en lib/ui/widgets/blog_card.dart


