import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jp_director/constant.dart';
import 'package:jp_director/models/blog.dart';
import 'package:jp_director/providers/all_blogs_provider.dart';
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
        // Cargar blogs disponibles para relacionar si estamos editando
        _cargarBlogsDisponibles();
        
        // Cargar IDs de blogs relacionados actuales
        for (var blog in allBlogsProvider.blogModal.relacionados) {
          _idsRelacionados.add(blog.id);
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
    }
  }
  
  // Cargar blogs disponibles para relacionar
  Future<void> _cargarBlogsDisponibles() async {
    if (widget.id.isEmpty) return; // Solo si estamos editando un blog existente
    
    if (!mounted) return;
    setState(() {
      _cargandoBlogs = true;
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
      setState(() {
        _cargandoBlogs = false;
      });
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
                    widget.id.isEmpty ? 'Nuevo Blog' : 'Editar Blog',
                    style: DashboardLabel.h3.copyWith(color: blancoText),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: blancoText),
                    onPressed: () {
                      // Limpiar el formulario antes de cerrar
                      Provider.of<AllBlogsProvider>(context, listen: false).cleanBlogModal();
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Título en Español
              TextFormField(
                initialValue: allBlogsProvider.tituloEsBlogModal,
                decoration: _buildInputDecoration('Título en Español', Icons.title),
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
              TextFormField(
                initialValue: allBlogsProvider.tituloEnBlogModal,
                decoration: _buildInputDecoration('Título en Inglés', Icons.title),
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
              
              const SizedBox(height: 20),
              
              // Contenido en Español
              Text('Contenido en Español', style: DashboardLabel.paragraph.copyWith(color: blancoText)),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: allBlogsProvider.contenidoEsBlogModal,
                maxLines: 8,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Escribe el contenido del blog en español...',
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
              Text('Contenido en Inglés', style: DashboardLabel.paragraph.copyWith(color: blancoText)),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: allBlogsProvider.contenidoEnBlogModal,
                maxLines: 8,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Escribe el contenido del blog en inglés...',
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
              
              const SizedBox(height: 20),
              
              // URL de la imagen
              TextFormField(
                initialValue: allBlogsProvider.imagenBlogModal,
                decoration: _buildInputDecoration('URL de la imagen', Icons.image),
                onChanged: (value) => allBlogsProvider.imagenBlogModal = value,
              ),
              
              const SizedBox(height: 20),
              
              // Fecha de publicación
              InkWell(
                onTap: () => _selectDate(context),
                child: IgnorePointer(
                  child: TextFormField(
                    controller: _fechaController,
                    decoration: _buildInputDecoration('Fecha de publicación', Icons.calendar_today),
                    readOnly: true,
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Publicado (activo/inactivo)
              Row(
                children: [
                  Text('Publicado:', style: DashboardLabel.paragraph.copyWith(color: blancoText)),
                  const SizedBox(width: 10),
                  Switch(
                    value: _estado,
                    onChanged: (value) {
                      print('Switch de estado cambiado: $value');
                      setState(() {
                        _estado = value;
                        allBlogsProvider.publicadoBlogModal = value;
                        print('Estado actualizado en provider: ${allBlogsProvider.publicadoBlogModal}');
                      });
                    },
                    activeColor: Colors.green,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    _estado ? 'Activo' : 'Inactivo',
                    style: TextStyle(color: _estado ? Colors.green : Colors.red),
                  )
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Blogs relacionados
              if (widget.id.isNotEmpty) // Solo mostrar para edición, no para creación
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Blogs Relacionados', style: DashboardLabel.paragraph.copyWith(color: blancoText)),
                        TextButton(
                          onPressed: _cargarBlogsDisponibles,
                          child: Text(
                            'Gestionar',
                            style: TextStyle(color: azulText),
                          ),
                        ),
                      ],
                    ),
                    if (_cargandoBlogs)
                      const Center(child: CircularProgressIndicator()),
                    if (_idsRelacionados.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: azulText.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${_idsRelacionados.length} blog${_idsRelacionados.length != 1 ? 's' : ''} relacionado${_idsRelacionados.length != 1 ? 's' : ''}',
                              style: DashboardLabel.mini.copyWith(color: blancoText),
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
                    onPress: () {
                      // Limpiar el formulario antes de cerrar
                      Provider.of<AllBlogsProvider>(context, listen: false).cleanBlogModal();
                      Navigator.pop(context);
                    },
                    color: Colors.grey,
                    width: 120,
                  ),
                  const SizedBox(width: 20),
                  CustomButton(
                    text: widget.id.isEmpty ? 'Crear' : 'Actualizar',
                    width: 120,
                    onPress: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          if (widget.id.isEmpty) {
                            // Crear nuevo blog
                            await allBlogsProvider.createBlog();
                          } else {
                            // Actualizar blog existente
                            print('Enviando ID para actualizar: ${widget.id}');
                            print('Estado actual: ${allBlogsProvider.publicadoBlogModal}');
                            final result = await allBlogsProvider.updateBlog(widget.id);
                            
                            // Si la actualización fue exitosa, actualizamos los blogs relacionados
                            if (result && _idsRelacionados.isNotEmpty) {
                              await _actualizarBlogsRelacionados();
                            }
                            
                            print('Resultado de la actualización: $result');
                          }
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        } catch (e) {
                          print('Error catastrófico en modal de blogs: $e');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
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
  }
  
  // Método para cargar los blogs relacionados del blog que se está editando
  Future<void> _cargarBlogsRelacionados() async {
    if (widget.id.isEmpty) return;
    if (!mounted) return;
    setState(() {
      _cargandoBlogs = true;
    });
    
    try {
      final blogsProvider = Provider.of<AllBlogsProvider>(context, listen: false);
      // Usamos la versión silenciosa para evitar notifyListeners() durante la construcción
      final relacionados = await blogsProvider.getBlogsRelacionadosSN(widget.id);
      
      if (!mounted) return;
      setState(() {
        _idsRelacionados = relacionados.map((blog) => blog.id).toList();
      });
    } catch (e) {
      print('Error al cargar blogs relacionados: $e');
    } finally {
      setState(() {
        _cargandoBlogs = false;
      });
    }
  }
  
  // Diálogo para seleccionar blogs relacionados
  Future<void> _mostrarDialogoSeleccionBlogs() async {
    final result = await showDialog<List<String>>(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: const EdgeInsets.all(20),
            width: 500,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Seleccionar Blogs Relacionados',
                    style: DashboardLabel.h3.copyWith(color: blancoText),
                  ),
                  const Divider(color: azulText),
                  const SizedBox(height: 10),
                  Flexible(
                    child: Container(
                      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.5),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _blogsDisponibles.length,
                        itemBuilder: (context, index) {
                          final blog = _blogsDisponibles[index];
                          final isSelected = _idsRelacionados.contains(blog.id);
                          
                          return CheckboxListTile(
                            title: Text(
                              blog.tituloEs,
                              style: DashboardLabel.paragraph.copyWith(color: blancoText),
                            ),
                            subtitle: Text(
                              DateFormat('dd/MM/yyyy').format(blog.fechaPublicacion),
                              style: DashboardLabel.mini.copyWith(color: blancoText.withOpacity(0.7)),
                            ),
                            value: isSelected,
                            activeColor: azulText,
                            onChanged: (bool? selected) {
                              setState(() {
                                if (selected == true) {
                                  if (!_idsRelacionados.contains(blog.id)) {
                                    _idsRelacionados.add(blog.id);
                                  }
                                } else {
                                  _idsRelacionados.remove(blog.id);
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Cancelar', style: TextStyle(color: blancoText)),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: azulText,
                          foregroundColor: bgColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(_idsRelacionados);
                        },
                        child: const Text('Guardar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    
    if (result != null) {
      setState(() {
        _idsRelacionados = result;
      });
    }
  }
  
  // Método para actualizar los blogs relacionados
  Future<void> _actualizarBlogsRelacionados() async {
    if (widget.id.isEmpty) return;
    if (!mounted) return;
    try {
      final blogsProvider = Provider.of<AllBlogsProvider>(context, listen: false);
      await blogsProvider.actualizarBlogsRelacionados(widget.id, _idsRelacionados);
    } catch (e) {
      print('Error al actualizar blogs relacionados: $e');
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
      fillColor: blancoText.withOpacity(0.03),
      filled: true,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: azulText),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: azulText),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: azulText.withOpacity(0.3)),
      ),
      labelText: label,
      labelStyle: DashboardLabel.paragraph,
      prefixIcon: Icon(icon, color: azulText.withOpacity(0.3)),
    );
  }
}