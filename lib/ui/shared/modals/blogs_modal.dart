import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:jp_director/api/jp_api.dart';
import 'package:jp_director/constant.dart';
import 'package:jp_director/models/blog.dart';
import 'package:jp_director/providers/all_blogs_provider.dart';
import 'package:jp_director/services/notificacion_service.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';
import 'package:provider/provider.dart';

import '../botones/custom_button.dart';

class BlogsModal extends StatefulWidget {
  final String id;
  const BlogsModal({Key? key, required this.id}) : super(key: key);

  @override
  State<BlogsModal> createState() => _BlogsModalState();
}

class _BlogsModalState extends State<BlogsModal> {
  final _formKey = GlobalKey<FormState>();
  late bool _estado;
  late DateTime _fechaPublicacion;
  final TextEditingController _fechaController = TextEditingController();
  
  // Para manejar blogs relacionados
  bool _cargandoBlogs = false;
  List<Blog> _blogsDisponibles = [];
  List<String> _idsRelacionados = [];
  
  // Estado para controlar cargando en operaciones CRUD
  bool _isSubmitting = false;
  String? _errorMsg;
  
  @override
  void initState() {
    super.initState();
    final allBlogsProvider = Provider.of<AllBlogsProvider>(context, listen: false);
    
    try {
      if (widget.id.isNotEmpty) {
        // Estamos editando un blog existente
        _estado = allBlogsProvider.publicadoBlogModal;
        _fechaPublicacion = allBlogsProvider.fechaPublicacionBlogModal;
        
        // Cargar blogs relacionados si estamos editando
        _cargarBlogsRelacionados();
        
        // Cargar IDs de blogs relacionados actuales
        for (var blog in allBlogsProvider.blogModal.relacionados) {
          if (blog.id.isNotEmpty) {
            _idsRelacionados.add(blog.id);
          }
        }
        
        // Verificamos que los datos estén cargados correctamente
        if (allBlogsProvider.tituloEsBlogModal.isEmpty && 
            allBlogsProvider.blogModal.tituloEs.isNotEmpty) {
          // Actualizamos los campos si están vacíos pero el blog tiene datos
          allBlogsProvider.tituloEsBlogModal = allBlogsProvider.blogModal.tituloEs;
          allBlogsProvider.tituloEnBlogModal = allBlogsProvider.blogModal.tituloEn;
          allBlogsProvider.contenidoEsBlogModal = allBlogsProvider.blogModal.contenidoEs;
          allBlogsProvider.contenidoEnBlogModal = allBlogsProvider.blogModal.contenidoEn;
          allBlogsProvider.imagenBlogModal = allBlogsProvider.blogModal.img;
        }
      } else {
        // Estamos creando un blog nuevo
        _estado = true;
        _fechaPublicacion = DateTime.now();
      }
      
      _fechaController.text = DateFormat('dd/MM/yyyy').format(_fechaPublicacion);
    } catch (e) {
      print('Error en initState de BlogsModal: $e');
      _estado = true;
      _fechaPublicacion = DateTime.now();
      _fechaController.text = DateFormat('dd/MM/yyyy').format(_fechaPublicacion);
      _errorMsg = 'Error al inicializar el formulario: $e';
    }
  }
  
  // Seleccionar y subir imagen para el blog
  Future<void> _pickAndUploadImage(BuildContext context, String id) async {
    if (id.isEmpty) {
      NotifServ.showSnackbarError('Primero debes guardar el blog antes de subir una imagen', Colors.orange);
      return;
    }
    
    try {
      // Abrir el selector de archivos
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      
      if (result != null) {
        // Verificar el tipo de archivo
        final file = result.files.first;
        
        // Validar tamaño y tipo
        if (file.size > 3000000) {
          NotifServ.showSnackbarError('La imagen debe pesar menos de 3MB', Colors.red);
          return;
        }
        
        // Subir la imagen
        setState(() => _isSubmitting = true);
        
        try {
          final resp = await JpApi.editBlogImage(id, file.bytes!);
          
          // Actualizar la URL en el provider
          if (resp != null && resp is String) {
            final allBlogsProvider = Provider.of<AllBlogsProvider>(context, listen: false);
            allBlogsProvider.imagenBlogModal = resp;
            
            // Actualizamos el estado para forzar la reconstrucción del widget
            setState(() {});
            
            NotifServ.showSnackbarError('Imagen actualizada correctamente', Colors.green);
          } else {
            NotifServ.showSnackbarError('Error al procesar la respuesta del servidor', Colors.red);
          }
        } catch (e) {
          NotifServ.showSnackbarError('Error al subir la imagen: $e', Colors.red);
        } finally {
          if (mounted) setState(() => _isSubmitting = false);
        }
      }
    } catch (e) {
      NotifServ.showSnackbarError('Error al seleccionar la imagen: $e', Colors.red);
    }
  }

  // Cargar blogs disponibles para relacionar
  Future<void> _cargarBlogsDisponibles() async {
    if (widget.id.isEmpty) return; // Solo si estamos editando un blog existente
    
    if (!mounted) return;
    setState(() {
      _cargandoBlogs = true;
      _errorMsg = null;
    });
    
    try {
      final allBlogsProvider = Provider.of<AllBlogsProvider>(context, listen: false);
      // Usamos la versión silenciosa para evitar notifyListeners() durante la construcción
      final blogs = await allBlogsProvider.getBlogsDisponiblesParaRelacionarSN(widget.id);
      
      if (!mounted) return;
      setState(() {
        _blogsDisponibles = blogs;
        _cargandoBlogs = false;
      });
      
      // Mostrar diálogo para seleccionar blogs relacionados
      await _mostrarDialogoSeleccionBlogs();
    } catch (e) {
      print('Error al cargar blogs disponibles: $e');
      if (mounted) {
        setState(() {
          _cargandoBlogs = false;
          _errorMsg = 'Error al cargar artículos disponibles: $e';
        });
      }
    }
  }

  @override
  void dispose() {
    _fechaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allBlogsProvider = Provider.of<AllBlogsProvider>(context);
    final size = MediaQuery.of(context).size;
    
    return Container(
      height: size.height * 0.85, // Más alto para acomodar el contenido
      decoration: _buildBoxDecoration(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título del modal
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.id.isEmpty ? 'Nuevo Artículo' : 'Editar Artículo',
                    style: DashboardLabel.h3.copyWith(color: blancoText),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: blancoText),
                    onPressed: _isSubmitting 
                      ? null // Deshabilitamos el botón si hay una operación en curso
                      : () {
                        // Limpiar el formulario antes de cerrar
                        Provider.of<AllBlogsProvider>(context, listen: false).cleanBlogModal();
                        Navigator.pop(context);
                      },
                  )
                ],
              ),
              
              // Mostrar mensaje de error si existe
              if (_errorMsg != null)
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _errorMsg!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            _errorMsg = null;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                
              const SizedBox(height: 20),
              
              // Encabezado de títulos
              Row(
                children: [
                  const Icon(Icons.title, color: azulText),
                  const SizedBox(width: 8),
                  Text(
                    'Títulos del Artículo', 
                    style: DashboardLabel.paragraph.copyWith(
                      color: blancoText,
                      fontWeight: FontWeight.bold
                    )
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Contenedor para títulos
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: azulText.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título en Español
                    Row(
                      children: [
                        const Icon(Icons.language, color: azulText, size: 16),
                        const SizedBox(width: 5),
                        Text(
                          'Español (ES)', 
                          style: TextStyle(
                            color: blancoText, 
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      initialValue: allBlogsProvider.tituloEsBlogModal,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.withOpacity(0.1),
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: azulText.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: azulText),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: azulText.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: 'Título en Español',
                        hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                        prefixIcon: Icon(Icons.text_fields, color: azulText.withOpacity(0.6)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                      onChanged: (value) {
                        // Sanitizamos el valor para evitar problemas de codificación
                        try {
                          allBlogsProvider.tituloEsBlogModal = value;
                        } catch (e) {
                          print('Error al establecer título ES: $e');
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El título en español es obligatorio';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Título en Inglés
                    Row(
                      children: [
                        const Icon(Icons.language, color: azulText, size: 16),
                        const SizedBox(width: 5),
                        Text(
                          'Inglés (EN)', 
                          style: TextStyle(
                            color: blancoText, 
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      initialValue: allBlogsProvider.tituloEnBlogModal,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.withOpacity(0.1),
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: azulText.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: azulText),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: azulText.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: 'Título en Inglés',
                        hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                        prefixIcon: Icon(Icons.text_fields, color: azulText.withOpacity(0.6)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                      onChanged: (value) {
                        // Sanitizamos el valor para evitar problemas de codificación
                        try {
                          allBlogsProvider.tituloEnBlogModal = value;
                        } catch (e) {
                          print('Error al establecer título EN: $e');
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El título en inglés es obligatorio';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Encabezado de contenido
              Row(
                children: [
                  const Icon(Icons.description, color: azulText),
                  const SizedBox(width: 8),
                  Text(
                    'Contenido del Artículo', 
                    style: DashboardLabel.paragraph.copyWith(
                      color: blancoText,
                      fontWeight: FontWeight.bold
                    )
                  ),
                ],
              ),
              const SizedBox(height: 10),
              
              // Contenedor para contenidos
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: azulText.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Contenido en Español
                    Row(
                      children: [
                        const Icon(Icons.language, color: azulText, size: 16),
                        const SizedBox(width: 5),
                        Text(
                          'Español (ES)', 
                          style: TextStyle(
                            color: blancoText, 
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      initialValue: allBlogsProvider.contenidoEsBlogModal,
                      maxLines: 8,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: azulText),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: 'Escribe el contenido del artículo en español...',
                        hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.1),
                      ),
                      onChanged: (value) {
                        try {
                          // Manejamos posibles errores de codificación
                          allBlogsProvider.contenidoEsBlogModal = value;
                        } catch (e) {
                          print('Error al establecer contenido ES: $e');
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El contenido en español es obligatorio';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Contenido en Inglés
                    Row(
                      children: [
                        const Icon(Icons.language, color: azulText, size: 16),
                        const SizedBox(width: 5),
                        Text(
                          'Inglés (EN)', 
                          style: TextStyle(
                            color: blancoText, 
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      initialValue: allBlogsProvider.contenidoEnBlogModal,
                      maxLines: 8,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: azulText),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: 'Escribe el contenido del artículo en inglés...',
                        hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.1),
                      ),
                      onChanged: (value) {
                        try {
                          // Manejamos posibles errores de codificación
                          allBlogsProvider.contenidoEnBlogModal = value;
                        } catch (e) {
                          print('Error al establecer contenido EN: $e');
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El contenido en inglés es obligatorio';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Encabezado de configuración
              Row(
                children: [
                  const Icon(Icons.settings, color: azulText),
                  const SizedBox(width: 8),
                  Text(
                    'Configuración del Artículo', 
                    style: DashboardLabel.paragraph.copyWith(
                      color: blancoText,
                      fontWeight: FontWeight.bold
                    )
                  ),
                ],
              ),
              const SizedBox(height: 10),
              
              // Contenedor para configuración
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: azulText.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // URL de la imagen
                    Row(
                      children: [
                        const Icon(Icons.image, color: azulText, size: 16),
                        const SizedBox(width: 5),
                        Text(
                          'Imagen Principal', 
                          style: TextStyle(
                            color: blancoText, 
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const Spacer(),
                        if (allBlogsProvider.imagenBlogModal.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierColor: Colors.black.withOpacity(0.85), // Oscurecemos más el fondo
                                builder: (context) => Dialog(
                                  backgroundColor: bgColor,
                                  elevation: 12,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(color: azulText.withOpacity(0.3), width: 1),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.network(
                                        allBlogsProvider.imagenBlogModal,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (context, child, loadingProgress) {
                                          if (loadingProgress == null) return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress.expectedTotalBytes != null
                                                  ? loadingProgress.cumulativeBytesLoaded /
                                                      loadingProgress.expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Cerrar'),
                                        onPressed: () => Navigator.of(context).pop(),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: const Row(
                              children: [
                                 Icon(Icons.visibility, size: 16, color: Colors.blue),
                                 SizedBox(width: 4),
                                 Text('Ver imagen', style: TextStyle(color: Colors.blue, fontSize: 12)),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            // Asegurarse de usar el valor actual del provider, no el inicial
                            key: ValueKey(allBlogsProvider.imagenBlogModal), // Forzar reconstrucción cuando cambia
                            initialValue: allBlogsProvider.imagenBlogModal,
                            decoration: InputDecoration(
                              fillColor: Colors.grey.withOpacity(0.1),
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: azulText.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: azulText),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: azulText.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              hintText: 'URL de la imagen del artículo',
                              hintStyle: TextStyle(color: Colors.grey.withOpacity(0.25)),
                              prefixIcon: Icon(Icons.link, color: azulText.withOpacity(0.6)),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            ),
                            onChanged: (value) => allBlogsProvider.imagenBlogModal = value,
                            enabled: false
                          ),
                        ),
                        const SizedBox(width: 10),
                        _isSubmitting 
                          ? const SizedBox(
                              height: 36,
                              width: 36,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  strokeWidth: 2, 
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black)
                                ),
                              ),
                            )
                          : ElevatedButton.icon(
                              icon: const Icon(Icons.upload_file, size: 18, color: Colors.black,),
                              label: const Text('Subir', style: TextStyle(fontSize: 12, color: Colors.black)),
                              onPressed: () => _pickAndUploadImage(context, widget.id),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: azulText,
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              ),
                            ),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Fecha y estado en la misma fila
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Fecha de publicación
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.calendar_today, color: azulText, size: 16),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Fecha de Publicación', 
                                    style: TextStyle(
                                      color: blancoText, 
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              InkWell(
                                onTap: _isSubmitting ? null : () => _selectDate(context),
                                child: IgnorePointer(
                                  child: TextFormField(
                                    controller: _fechaController,
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey.withOpacity(0.1),
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: azulText.withOpacity(0.3)),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: azulText),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: azulText.withOpacity(0.3)),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      hintText: 'Seleccionar fecha',
                                      hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                                      prefixIcon: Icon(Icons.event, color: azulText.withOpacity(0.6)),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                    ),
                                    readOnly: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(width: 15),
                        
                        // Estado (activo/inactivo)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    _estado ? Icons.visibility : Icons.visibility_off,
                                    color: _estado ? Colors.green : Colors.red,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    'Estado de Publicación', 
                                    style: TextStyle(
                                      color: blancoText, 
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.all(10),
                                height: 48,
                                decoration: BoxDecoration(
                                  color: _estado ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: _estado ? Colors.green.withOpacity(0.3) : Colors.red.withOpacity(0.3),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _estado ? 'Publicado' : 'No Publicado',
                                      style: TextStyle(
                                        color: _estado ? Colors.green : Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Switch(
                                      value: _estado,
                                      onChanged: _isSubmitting 
                                          ? null 
                                          : (value) {
                                              print('Switch de estado cambiado: $value');
                                              setState(() {
                                                _estado = value;
                                                allBlogsProvider.publicadoBlogModal = value;
                                              });
                                            },
                                      activeColor: Colors.green,
                                      activeTrackColor: Colors.green.withOpacity(0.5),
                                      inactiveThumbColor: Colors.red,
                                      inactiveTrackColor: Colors.red.withOpacity(0.5),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Blogs relacionados
              if (widget.id.isNotEmpty) // Solo mostrar para edición, no para creación
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: azulText.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: azulText.withOpacity(0.2)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.link, color: azulText, size: 18),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Artículos Relacionados', 
                                    style: DashboardLabel.paragraph.copyWith(
                                      color: blancoText,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton.icon(
                                onPressed: _isSubmitting ? null : _cargarBlogsDisponibles,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: azulText,
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                icon: const Icon(Icons.edit, size: 16),
                                label: const Text('Gestionar'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          if (_cargandoBlogs)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ),
                          if (!_cargandoBlogs && _idsRelacionados.isEmpty)
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'No hay artículos relacionados asignados',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          if (!_cargandoBlogs && _idsRelacionados.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.article,
                                        color: azulText.withOpacity(0.7),
                                        size: 16,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        '${_idsRelacionados.length} artículo${_idsRelacionados.length != 1 ? 's' : ''} relacionado${_idsRelacionados.length != 1 ? 's' : ''}',
                                        style: DashboardLabel.mini.copyWith(
                                          color: blancoText, 
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    'Los cambios se guardarán al actualizar el artículo',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              
              const SizedBox(height: 20),
              
              // Botones de acción
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    text: 'Cancelar',
                    onPress: _isSubmitting 
                      ? null // Deshabilitado durante envío
                      : () {
                          // Limpiar el formulario antes de cerrar
                          Provider.of<AllBlogsProvider>(context, listen: false).cleanBlogModal();
                          Navigator.pop(context);
                        },
                    color: Colors.grey,
                    width: 120,
                  ),
                  const SizedBox(width: 20),
                  _isSubmitting
                      ? const SizedBox(
                          width: 120,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: azulText,
                              strokeWidth: 2,
                            ),
                          ),
                        )
                      : CustomButton(
                          text: widget.id.isEmpty ? 'Crear' : 'Actualizar',
                          width: 120,
                          onPress: () async {
                            // Prevenir múltiples clicks
                            if (_isSubmitting) return;
                            
                            if (_formKey.currentState!.validate()) {
                              try {
                                setState(() {
                                  _isSubmitting = true;
                                  _errorMsg = null;
                                });
                                
                                bool result = false;
                                
                                if (widget.id.isEmpty) {
                                  // Crear nuevo blog
                                  result = await allBlogsProvider.createBlog();
                                } else {
                                  // Actualizar blog existente
                                  print('Enviando ID para actualizar: ${widget.id}');
                                  print('Estado actual: ${allBlogsProvider.publicadoBlogModal}');
                                  result = await allBlogsProvider.updateBlog(widget.id);
                                  
                                  // Si la actualización fue exitosa, actualizamos los blogs relacionados
                                  if (result && _idsRelacionados.isNotEmpty) {
                                    await _actualizarBlogsRelacionados();
                                  }
                                }
                                
                                if (result) {
                                  if (context.mounted) {
                                    Navigator.pop(context, result);
                                  }
                                } else {
                                  setState(() {
                                    _errorMsg = 'No se pudo ${widget.id.isEmpty ? "crear" : "actualizar"} el artículo';
                                    _isSubmitting = false;
                                  });
                                }
                              } catch (e) {
                                print('Error catastrófico en modal de blogs: $e');
                                setState(() {
                                  _errorMsg = 'Error: $e';
                                  _isSubmitting = false;
                                });
                              }
                            }
                          },
                          color: azulText,
                        ),
                ],
              ),
              const SizedBox(height: 40)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    try {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _fechaPublicacion,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                primary: azulText,
                onPrimary: blancoText,
                surface: bgColor,
                onSurface: blancoText,
              ),
              dialogBackgroundColor: bgColor,
              // Mejorar los botones
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: azulText,
                  foregroundColor: Colors.white,
                ),
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: azulText,
                ),
              ),
            ),
            child: child!,
          );
        },
      );
      
      if (picked != null && picked != _fechaPublicacion) {
        setState(() {
          _fechaPublicacion = picked;
          _fechaController.text = DateFormat('dd/MM/yyyy').format(_fechaPublicacion);
          Provider.of<AllBlogsProvider>(context, listen: false)
              .fechaPublicacionBlogModal = _fechaPublicacion;
        });
      }
    } catch (e) {
      print('Error al seleccionar fecha: $e');
      setState(() {
        _errorMsg = 'Error al seleccionar fecha: $e';
      });
    }
  }
  
  // Método para cargar los blogs relacionados del blog que se está editando
  Future<void> _cargarBlogsRelacionados() async {
    if (widget.id.isEmpty) return;
    if (!mounted) return;
    setState(() {
      _cargandoBlogs = true;
      _errorMsg = null;
    });
    
    try {
      final blogsProvider = Provider.of<AllBlogsProvider>(context, listen: false);
      // Usamos la versión silenciosa para evitar notifyListeners() durante la construcción
      final relacionados = await blogsProvider.getBlogsRelacionadosSN(widget.id);
      
      if (!mounted) return;
      setState(() {
        // Filtrar posibles IDs vacíos o nulos
        _idsRelacionados = relacionados
            .where((blog) => blog.id.isNotEmpty)
            .map((blog) => blog.id)
            .toList();
      });
      
      // Cargar también los blogs disponibles para que estén listos cuando se abra el diálogo
      _blogsDisponibles = await blogsProvider.getBlogsDisponiblesParaRelacionarSN(widget.id);
    } catch (e) {
      print('Error al cargar blogs relacionados: $e');
      if (mounted) {
        setState(() {
          _errorMsg = 'Error al cargar artículos relacionados: $e';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _cargandoBlogs = false;
        });
      }
    }
  }
  
  // Diálogo para seleccionar blogs relacionados
  Future<void> _mostrarDialogoSeleccionBlogs() async {
    // Lista temporal de IDs para trabajar dentro del diálogo
    List<String> tempSelectedIds = List.from(_idsRelacionados);
    String? searchQuery = '';
    
    final result = await showDialog<List<String>>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.85), // Oscurecemos más el fondo detrás del modal
      barrierDismissible: true, // Permitir cerrar el modal al hacer clic fuera de él
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            // Filtrar blogs según búsqueda
            List<Blog> filteredBlogs = _blogsDisponibles;
            if (searchQuery != null && searchQuery!.isNotEmpty) {
              filteredBlogs = _blogsDisponibles.where((blog) {
                return blog.tituloEs.toLowerCase().contains(searchQuery!.toLowerCase()) ||
                       blog.tituloEn.toLowerCase().contains(searchQuery!.toLowerCase());
              }).toList();
            }
            
            return Dialog(
              backgroundColor: bgColor,
              elevation: 12, // Aumentamos la elevación para un efecto de profundidad
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: azulText.withOpacity(0.3), width: 1), // Borde sutil
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                width: 600, // Mayor ancho para mejor experiencia
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título del diálogo
                    Row(
                      children: [
                        const Icon(Icons.link, color: azulText),
                        const SizedBox(width: 10),
                        Text(
                          'Seleccionar Artículos Relacionados',
                          style: DashboardLabel.h3.copyWith(color: blancoText),
                        ),
                      ],
                    ),
                    const Divider(color: azulText),
                    
                    // Campo de búsqueda
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextField(
                        onChanged: (value) {
                          setDialogState(() {
                            searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Buscar artículo...',
                          prefixIcon: const Icon(Icons.search, color: azulText),
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    
                    // Mostrar seleccionados
                    if (tempSelectedIds.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: azulText.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle, color: azulText, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              '${tempSelectedIds.length} artículo${tempSelectedIds.length != 1 ? 's' : ''} seleccionado${tempSelectedIds.length != 1 ? 's' : ''}',
                              style: const TextStyle(color: blancoText),
                            ),
                            const Spacer(),
                            TextButton.icon(
                              icon: const Icon(Icons.delete_sweep, color: Colors.red, size: 16),
                              label: const Text('Limpiar selección', style: TextStyle(color: Colors.red)),
                              onPressed: () {
                                setDialogState(() {
                                  // Aseguramos que la lista temporal se limpia correctamente
                                  tempSelectedIds = [];
                                });
                                print('Lista de IDs relacionados limpiada, longitud ahora: ${tempSelectedIds.length}');
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    
                    // Lista de blogs disponibles
                    const SizedBox(height: 10),
                    Flexible(
                            child: Container(
                              constraints: BoxConstraints(
                                maxHeight: MediaQuery.of(context).size.height * 0.5,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.withOpacity(0.2)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: filteredBlogs.isEmpty
                                  ? const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Text(
                                          'No se encontraron artículos disponibles',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                    )
                                  : ListView.separated(
                                      shrinkWrap: true,
                                      itemCount: filteredBlogs.length,
                                      separatorBuilder: (context, index) => const Divider(height: 1),
                                      itemBuilder: (context, index) {
                                        final blog = filteredBlogs[index];
                                        final isSelected = tempSelectedIds.contains(blog.id);
                                        
                                        return CheckboxListTile(
                                          title: Text(
                                            blog.tituloEs,
                                            style: DashboardLabel.paragraph.copyWith(
                                              color: blancoText,
                                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                            ),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Publicado: ${DateFormat('dd/MM/yyyy').format(blog.fechaPublicacion)}',
                                                style: DashboardLabel.mini.copyWith(
                                                  color: blancoText.withOpacity(0.7),
                                                ),
                                              ),
                                              if (blog.tituloEn.isNotEmpty)
                                                Text(
                                                  'EN: ${blog.tituloEn}',
                                                  style: DashboardLabel.mini.copyWith(
                                                    color: Colors.grey,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                            ],
                                          ),
                                          value: isSelected,
                                          activeColor: azulText,
                                          secondary: Icon(
                                            isSelected ? Icons.link : Icons.link_off,
                                            color: isSelected ? azulText : Colors.grey.withOpacity(0.5),
                                          ),
                                          onChanged: (bool? selected) {
                                            print('Cambiando estado de selección para blog ${blog.id}: ${selected}');
                                            print('Estado actual de tempSelectedIds antes: $tempSelectedIds');
                                            
                                            // Crear una nueva lista para asegurar que se detecta el cambio de estado
                                            List<String> newList = List<String>.from(tempSelectedIds);
                                            
                                            if (selected == true) {
                                              if (!newList.contains(blog.id)) {
                                                newList.add(blog.id);
                                                print('Añadido ID ${blog.id} a la lista');
                                              }
                                            } else {
                                              if (newList.contains(blog.id)) {
                                                newList.remove(blog.id);
                                                print('Eliminado ID ${blog.id} de la lista');
                                              }
                                            }
                                            
                                            setDialogState(() {
                                              tempSelectedIds = newList;
                                            });
                                            
                                            print('Estado actual de tempSelectedIds después: $tempSelectedIds');
                                          },
                                        );
                                      },
                                    ),
                            ),
                          ),
                    const SizedBox(height: 20),
                    
                    // Botones de acción
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          ),
                          child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.save),
                          label: const Text('Guardar Selección'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: azulText,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            // Validar que tengamos una lista válida antes de cerrar
                            final List<String> finalList = tempSelectedIds
                                .where((id) => id.isNotEmpty)
                                .toList();
                            
                            print('Guardando selección: $finalList (${finalList.length} artículos relacionados)');
                            Navigator.of(context).pop(finalList);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        );
      },
    );
    
    if (result != null) {
      print('Recibido resultado del diálogo: $result (${result.length} artículos)');
      setState(() {
        _idsRelacionados = List<String>.from(result);
      });
      
      // Mostrar una notificación si se seleccionaron blogs
      if (_idsRelacionados.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${_idsRelacionados.length} artículo${_idsRelacionados.length != 1 ? 's' : ''} relacionado${_idsRelacionados.length != 1 ? 's' : ''} seleccionado${_idsRelacionados.length != 1 ? 's' : ''}',
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }
  
  // Método para actualizar los blogs relacionados
  Future<bool> _actualizarBlogsRelacionados() async {
    if (widget.id.isEmpty) return false;
    if (!mounted) return false;
    try {
      setState(() {
        _errorMsg = null;
      });
      
      final blogsProvider = Provider.of<AllBlogsProvider>(context, listen: false);
      final result = await blogsProvider.actualizarBlogsRelacionados(widget.id, _idsRelacionados);
      
      if (!result && mounted) {
        setState(() {
          _errorMsg = 'No se pudieron actualizar los artículos relacionados';
        });
      }
      
      return result;
    } catch (e) {
      print('Error al actualizar blogs relacionados: $e');
      if (mounted) {
        setState(() {
          _errorMsg = 'Error al actualizar artículos relacionados: $e';
        });
      }
      return false;
    }
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: bgColor,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 5,
        )
      ],
    );
  }
  
  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      fillColor: Colors.grey.withOpacity(0.1),
      filled: true,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: azulText.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: azulText),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: azulText.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(8),
      ),
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey),
      hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
      prefixIcon: Icon(icon, color: azulText.withOpacity(0.6)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }
}