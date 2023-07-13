import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/constant.dart';
import 'package:jpdirector_frontend/models/modulo.dart';
import 'package:jpdirector_frontend/providers/all_cursos_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/curso.dart';
import '../botones/custom_button.dart';

class CursosModal extends StatefulWidget {
  final String uid;
  const CursosModal({Key? key, required this.uid}) : super(key: key);

  @override
  State<CursosModal> createState() => _CursosModalState();
}

class _CursosModalState extends State<CursosModal> {


  @override
  Widget build(BuildContext context) {
    final allCursosProvider = Provider.of<AllCursosProvider>(context);
    final Curso curso = (widget.uid == '') ? allCursosProvider.curso : allCursosProvider.cursoModal;
    List<Modulo> modulos = curso.modulos.where((m) => m.estado).toList();
    final size = MediaQuery.of(context).size;

    return Container(
      padding: (size.width < 500) ? const EdgeInsets.only(left: 40, top: 15, right: 15, bottom: 15) : const EdgeInsets.all(15),
      decoration: buildBoxDecoration(),
      child: ListView(children: [
        Column(
          children: [
            Row(
              children: [
                if (size.width < 715)
                  const SizedBox(
                    width: 40,
                  ),
                Text(
                  (curso.id != '') ? 'Editar: ${curso.nombre}' : 'Nuevo Curso',
                  style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ))
              ],
            ),
            Divider(
              color: bgColor.withOpacity(0.3),
            ),
            const SizedBox(
              height: 15 / 2,
            ),
            Padding(
              padding: (size.width > 580) ? const EdgeInsets.only(left: 25) : const EdgeInsets.only(left: 0),
              child: Wrap(alignment: WrapAlignment.center, spacing: 15 / 2, runSpacing: 15 / 2, children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 380, minWidth: 380),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => (value!.isNotEmpty) ? null : 'Titulo del curso',
                    initialValue: (curso.id == '') ? '' : curso.nombre,
                    onChanged: (value) => setState(() {
                      allCursosProvider.nombreCursoModal = value;
                    }),
                    style: GoogleFonts.roboto(color: Colors.white.withOpacity(0.3), fontSize: 14),
                    decoration: buildInputDecoration(icon: Icons.title_outlined, label: 'Nombre del curso'),
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 380, minWidth: 380),
                  child: TextFormField(
                    style: GoogleFonts.roboto(color: Colors.white.withOpacity(0.3), fontSize: 14),
                    initialValue: (curso.id == '') ? '' : curso.subtitle,
                    onChanged: (value) => setState(() {
                      allCursosProvider.subtitleCursoModal = value;
                    }),
                    decoration: buildInputDecoration(label: 'Subtitulo del curso', icon: Icons.subtitles_outlined),
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 380, minWidth: 380),
                  child: TextFormField(
                    style: GoogleFonts.roboto(color: Colors.white.withOpacity(0.3), fontSize: 14),
                    initialValue: (curso.id == '') ? '' : curso.img,
                    onChanged: (value) => setState(() {
                      allCursosProvider.imgCursoModal = value;
                    }),
                    decoration: buildInputDecoration(label: 'Imagen del curso', icon: Icons.image_outlined),
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 380, minWidth: 380),
                  child: TextFormField(
                    style: GoogleFonts.roboto(color: Colors.white.withOpacity(0.3), fontSize: 14),
                    initialValue: (curso.id == '') ? '' : curso.descripcion,
                    maxLines: 5,
                    onChanged: (value) => setState(() => allCursosProvider.descripcionCursoModal = value),
                    decoration: buildInputDecoration(label: 'Descripción del curso', icon: Icons.description_outlined),
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 380, minWidth: 380),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => (value!.isNotEmpty) ? null : 'duración es obligatoria',
                    initialValue: (curso.duracion == '0') ? '0 min' : curso.duracion,
                    onChanged: (value) => setState(() {
                      allCursosProvider.duracionCursoModal = value;
                    }),
                    style: GoogleFonts.roboto(color: Colors.white.withOpacity(0.3), fontSize: 14),
                    decoration: buildInputDecoration(icon: Icons.timer_outlined, label: 'Duración'),
                  ),
                ),
              ]),
            ),
            if (widget.uid != '')
              Column(
                children: [
                  const SizedBox(height: 15),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Row(
                      children: [
                        Text('Modulos del curso', style: GoogleFonts.roboto(color: Colors.white.withOpacity(0.3), fontSize: 14)),
                        const Spacer(),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () async {
                              final created = await showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) => Dialog(
                                        cursoID: widget.uid,
                                      ));

                              if (created) {
                                setState(() {
                                  allCursosProvider.getCursoModal(widget.uid);
                                });
                              }
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Agregar Modulo',
                                  style: GoogleFonts.roboto(color: Colors.white.withOpacity(0.3), fontSize: 14),
                                ),
                                const SizedBox(width: 10),
                                const Icon(
                                  Icons.add_to_photos_sharp,
                                  color: azulText,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    children: [
                      if (modulos.isEmpty)
                        Row(children: [
                          Text(
                            'Sin modulos, Agregue un nuevo modulo',
                            style: GoogleFonts.roboto(color: Colors.white.withOpacity(0.3), fontSize: 14),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(),
                          )
                        ]),
                      if (modulos.isNotEmpty) ...modulos.map((modulo) => SquareModulo(modulo: modulo)).toList()
                    ],
                  )
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child: CustomButton(
                    width: 80,
                    onPress: () async {
                      if (widget.uid == '') {
                        // Crear
                        await allCursosProvider.createCurso();

                      } else {
                        // Actualizar

                        await allCursosProvider.updateCurso(
                          uid: widget.uid,
                          
                        );
                      }

                      if (context.mounted) {
                        Navigator.pop(context, true);
                      }
                    },
                    text: (widget.uid != '') ? 'Actualizar' : 'Crear',
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child: CustomButton(
                    width: 80,
                    color: Colors.red.withOpacity(0.5),
                    onPress: () {
                      Navigator.pop(context, false);
                    },
                    text: 'Cancelar',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ]),
    );
  }
}

class SquareModulo extends StatefulWidget {
  final String? cursoID;
  final Modulo? modulo;
  const SquareModulo({
    super.key,
    this.modulo,
    this.cursoID,
  });

  @override
  State<SquareModulo> createState() => _SquareModuloState();
}

class _SquareModuloState extends State<SquareModulo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      constraints: const BoxConstraints(maxWidth: 420),
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      height: 40,
      // color: Colors.white.withOpacity(0.2),
      child: Row(children: [
        Icon(Icons.view_module, color: Colors.white.withOpacity(0.3)),
        const SizedBox(width: 10),
        Text(
          widget.modulo!.nombre,
          style: GoogleFonts.roboto(color: Colors.white.withOpacity(0.3)),
        ),
        const Spacer(),
        IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => Dialog(
                        cursoID: widget.cursoID ?? '',
                        modulo: widget.modulo,
                      ));
            },
            icon: const Icon(
              Icons.edit,
              color: azulText,
            )),
        IconButton(
            onPressed: () async {
              await showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text('Eliminar Modulo'),
                        content: Text('Estas seguro de eliminar el modulo ${widget.modulo!.nombre}'),
                        actions: [
                          CustomButton(
                            text: 'Eliminar',
                            onPress: () async {
                              await Provider.of<AllCursosProvider>(context, listen: false).deleteModulo(widget.modulo!.id);
                              if (context.mounted) {
                                Navigator.pop(context, true);
                              }
                            },
                            width: 100,
                            color: Colors.red.withOpacity(0.3),
                          ),
                          CustomButton(
                            text: 'Cancelar',
                            onPress: () {
                              Navigator.pop(context, false);
                            },
                            width: 100,
                          )
                        ],
                      ));
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ))
      ]),
    );
  }
}

InputDecoration buildInputDecoration({required String label, required IconData icon, IconData? suffIcon, Function? onPrs}) => InputDecoration(
    fillColor: blancoText.withOpacity(0.03),
    filled: true,
    border: const OutlineInputBorder(
      borderSide: BorderSide(color: azulText),
    ),
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: azulText.withOpacity(0.3))),
    labelText: label,
    labelStyle: GoogleFonts.roboto(color: blancoText, fontSize: 14),
    prefixIcon: Icon(icon, color: azulText.withOpacity(0.3)),
    suffixIconColor: azulText.withOpacity(0.3));

BoxDecoration buildBoxDecoration() => const BoxDecoration(
    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    color: bgColor,
    boxShadow: [BoxShadow(color: Colors.black)]);

class Dialog extends StatefulWidget {
  final String cursoID;
  final Modulo? modulo;
  const Dialog({super.key, this.modulo, required this.cursoID});

  @override
  State<Dialog> createState() => _DialogState();
}

class _DialogState extends State<Dialog> {
  late String nombre;
  late String descripcion;
  late String video;
  late String curso;
  late String descarga;
  late String id;

  @override
  void initState() {
    super.initState();

    nombre = widget.modulo?.nombre ?? '';
    descripcion = widget.modulo?.descripcion ?? '';
    video = widget.modulo?.video ?? '';
    curso = widget.modulo?.curso ?? '';
    descarga = widget.modulo?.descarga ?? '';
    id = widget.modulo?.id ?? '';
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AllCursosProvider>(context, listen: false).getAllCursos();
    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        'Editar modulo',
        style: GoogleFonts.roboto(color: Colors.white),
      ),
      content: SingleChildScrollView(
        child: Container(
          decoration: buildBoxDecoration(),
          width: 300,
          height: 340,
          child: Column(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                child: Column(children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 380, minWidth: 380),
                    child: TextFormField(
                      style: GoogleFonts.roboto(color: Colors.white.withOpacity(0.3), fontSize: 12),
                      initialValue: nombre,
                      onChanged: (value) => nombre = value,
                      decoration: buildInputDecoration(
                        label: 'Nombre del Modulo',
                        icon: Icons.title_outlined,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 380, minWidth: 380),
                    child: TextFormField(
                      maxLines: 3,
                      style: GoogleFonts.roboto(color: Colors.white.withOpacity(0.3), fontSize: 12),
                      initialValue: descripcion,
                      onChanged: (value) => descripcion = value,
                      decoration: buildInputDecoration(
                        label: 'Descripcion del Modulo',
                        icon: Icons.description_outlined,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 380, minWidth: 380),
                    child: TextFormField(
                      style: GoogleFonts.roboto(color: Colors.white.withOpacity(0.3), fontSize: 12),
                      initialValue: video,
                      onChanged: (value) => video = value,
                      decoration: buildInputDecoration(
                        label: 'Url video del Modulo',
                        icon: Icons.ondemand_video_outlined,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 380, minWidth: 380),
                    child: TextFormField(
                      style: GoogleFonts.roboto(color: Colors.white.withOpacity(0.3), fontSize: 12),
                      initialValue: descarga,
                      onChanged: (value) => descarga = value,
                      decoration: buildInputDecoration(
                        label: 'Url de Material de descarga',
                        icon: Icons.download_outlined,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        text: (id == '') ? 'Crear' : 'Actualizar',
                        onPress: () async {
                          //TODO: CreR
                          if (id == '') {
                            await Provider.of<AllCursosProvider>(context, listen: false)
                                .createModulo(nombre: nombre, video: video, descripcion: descripcion, descarga: descarga, curso: widget.cursoID);
                          } else {
                            // Actualizar
                          }
                          if (context.mounted) {
                            Navigator.pop(context, true);
                          }
                        },
                        width: 100,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 15),
                      CustomButton(
                        text: 'Cancelar',
                        onPress: () {
                          Navigator.pop(context, false);
                        },
                        width: 100,
                        color: Colors.red.withOpacity(0.3),
                      ),
                    ],
                  )
                ]),
              )),
            ],
          ),
        ),
      ),
    );
  }
}