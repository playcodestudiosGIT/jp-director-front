import 'package:flutter/material.dart';
import 'package:jp_director/constant.dart';
import 'package:jp_director/models/modulo.dart';
import 'package:jp_director/providers/all_cursos_provider.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';
import 'package:jp_director/ui/shared/labels/inputs_decorations.dart';
import 'package:jp_director/ui/shared/widgets/progress_ind.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../models/curso.dart';
import '../botones/custom_button.dart';

class CursosModal extends StatefulWidget {
  final String uid;
  const CursosModal({Key? key, required this.uid}) : super(key: key);

  @override
  State<CursosModal> createState() => _CursosModalState();
}

class _CursosModalState extends State<CursosModal> {
  late bool publicado;

  @override
  void initState() {
    final allCursosProvider = Provider.of<AllCursosProvider>(context, listen: false);
    final Curso curso = (widget.uid == '') ? allCursosProvider.curso : allCursosProvider.cursoModal;
    publicado = curso.publicado;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final allCursosProvider = Provider.of<AllCursosProvider>(context);
    final Curso curso = (widget.uid == '') ? allCursosProvider.curso : allCursosProvider.cursoModal;

    List<Modulo> modulos = curso.modulos.where((m) => m.estado).toList();
    final size = MediaQuery.of(context).size;

    return Container(
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
                Text((curso.id != '') ? '${appLocal.editar2puntos} ${curso.nombre}' : appLocal.nuevoCurso, style: DashboardLabel.h4),
                const Spacer(),
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
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
                  constraints: const BoxConstraints(maxWidth: 500, minWidth: 315),
                  child: TextFormField(
                    cursorColor: azulText,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => (value!.isNotEmpty) ? null : appLocal.imagenDelCurso,
                    initialValue: (curso.id == '') ? '' : curso.nombre,
                    onChanged: (value) => allCursosProvider.nombreCursoModal = value,
                    style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.3)),
                    decoration: InputDecor.formFieldInputDecoration(icon: Icons.title_outlined, label: appLocal.nombreDelCurso),
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 500, minWidth: 315),
                  child: TextFormField(
                    cursorColor: azulText,
                    style: DashboardLabel.paragraph.copyWith(color: Colors.white.withOpacity(0.3)),
                    initialValue: (curso.id == '') ? '' : curso.precio,
                    onChanged: (value) => allCursosProvider.precioCursoModal = value,
                    decoration: InputDecor.formFieldInputDecoration(label: appLocal.precioDelCurso, icon: Icons.price_change),
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 500, minWidth: 315),
                  child: TextFormField(
                    cursorColor: azulText,
                    style: DashboardLabel.paragraph.copyWith(color: Colors.white.withOpacity(0.3)),
                    initialValue: (curso.id == '') ? '' : curso.img,
                    onChanged: (value) => allCursosProvider.imgCursoModal = value,
                    decoration: InputDecor.formFieldInputDecoration(label: appLocal.imagenDelCurso, icon: Icons.image_outlined),
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 500, minWidth: 315),
                  child: TextFormField(
                    cursorColor: azulText,
                    style: DashboardLabel.paragraph.copyWith(color: Colors.white.withOpacity(0.3)),
                    initialValue: (curso.id == '') ? '' : curso.urlImgCert,
                    onChanged: (value) => allCursosProvider.urlImgCert = value,
                    decoration: InputDecor.formFieldInputDecoration(label: appLocal.imgCursoCertificado, icon: Icons.image_outlined),
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 500, minWidth: 315),
                  child: TextFormField(
                    cursorColor: azulText,
                    style: DashboardLabel.paragraph.copyWith(color: Colors.white.withOpacity(0.3)),
                    initialValue: (curso.id == '') ? '' : curso.baner,
                    onChanged: (value) => allCursosProvider.banerCursoModal = value,
                    decoration: InputDecor.formFieldInputDecoration(label: appLocal.banerDelCurso, icon: Icons.image_outlined),
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 500, minWidth: 315),
                  child: TextFormField(
                    cursorColor: azulText,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => (value!.isNotEmpty) ? null : appLocal.duracionObligatoria,
                    initialValue: (curso.id == '') ? '0 h' : curso.duracion,
                    onChanged: (value) => allCursosProvider.duracionCursoModal = value,
                    style: DashboardLabel.paragraph.copyWith(color: Colors.white.withOpacity(0.3)),
                    decoration: InputDecor.formFieldInputDecoration(icon: Icons.timer_outlined, label: appLocal.duracionDelCurso),
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 500, minWidth: 315),
                  child: TextFormField(
                    cursorColor: azulText,
                    style: DashboardLabel.paragraph.copyWith(color: Colors.white.withOpacity(0.3)),
                    initialValue: (curso.id == '') ? '' : curso.descripcion,
                    maxLines: 5,
                    onChanged: (value) => allCursosProvider.descripcionCursoModal = value,
                    decoration: InputDecor.formFieldInputDecoration(label: appLocal.descripcionDelCurso, icon: Icons.description_outlined),
                  ),
                ),
                Container(
                    constraints: const BoxConstraints(maxWidth: 400, minWidth: 315),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 50,
                          child: Switch(
                            trackOutlineColor: MaterialStatePropertyAll(azulText.withOpacity(0.3)),
                            activeColor: Colors.green,
                            value: publicado,
                            onChanged: (value) {
                              publicado = !publicado;
                              allCursosProvider.publicadoCursoModal = publicado;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Row(
                          children: [
                            Text(
                              '${appLocal.publicado2puntos}  ',
                              style: DashboardLabel.paragraph,
                            ),
                            if (publicado) Text(appLocal.si, style: DashboardLabel.paragraph.copyWith(color: Colors.green, fontWeight: FontWeight.bold)),
                            if (!publicado) Text('NO', style: DashboardLabel.paragraph.copyWith(color: Colors.red, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    )),
              ]),
            ),
            if (widget.uid != '')
              Column(
                children: [
                  const SizedBox(height: 15),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 500, minWidth: 315),
                    child: Column(
                      children: [
                        Text(appLocal.modulosDelCurso, style: DashboardLabel.h4),
                        const SizedBox(height: 15),
                        Row(
                          children: [
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
                                    allCursosProvider.getCursoModal(widget.uid);
                                  }
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      appLocal.agregarUnModulo,
                                      style: DashboardLabel.mini.copyWith(color: azulText),
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      runAlignment: WrapAlignment.center,
                      children: [
                        if (modulos.isEmpty)
                          Row(children: [
                            Text(
                              appLocal.sinModulos,
                              style: DashboardLabel.mini,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const ProgressInd()
                          ]),
                        if (modulos.isNotEmpty) ...modulos.map((modulo) => SquareModulo(modulo: modulo)).toList()
                      ],
                    ),
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
                    color: Colors.green,
                    width: 100,
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
                    text: (widget.uid != '') ? appLocal.actualizarBtn : appLocal.crearBtn,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child: CustomButton(
                    width: 100,
                    color: Colors.red.withOpacity(0.5),
                    onPress: () {
                      Navigator.pop(context, false);
                    },
                    text: appLocal.cancelarBtn,
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
    final appLocal = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.all(5),
      color: azulText.withOpacity(0.1),
      constraints: const BoxConstraints(maxWidth: 400, minWidth: 315),
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
        Icon(Icons.view_module, color: Colors.white.withOpacity(0.3)),
        const SizedBox(width: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 270,
              child: Row(
                children: [
                  Text(
                    widget.modulo!.nombre,
                    style: DashboardLabel.h4,
                  ),
                  const SizedBox(width: 15),
                  Icon(Icons.videocam_sharp, color: (widget.modulo!.video.isEmpty) ? Colors.red : Colors.green, size: 16),
                  const SizedBox(width: 5),
                  Icon(Icons.folder_copy_sharp, color: (widget.modulo!.idDriveFolder.isEmpty) ? Colors.red : Colors.green, size: 16),
                  const SizedBox(width: 5),
                  Icon(Icons.download_sharp, color: (widget.modulo!.idDriveZip.isEmpty) ? Colors.red : Colors.green, size: 16),
                  const SizedBox(width: 5),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
                width: 270,
                child: Text(
                  widget.modulo!.descripcion,
                  overflow: TextOverflow.fade,
                  style: DashboardLabel.mini.copyWith(color: blancoText.withOpacity(0.5)),
                ))
          ],
        ),
        const Spacer(),
        IconButton(
            onPressed: () async {
              final isok = await showDialog(
                  context: context,
                  builder: (context) => Dialog(
                        cursoID: widget.cursoID ?? '',
                        modulo: widget.modulo,
                      ));
              if (isok && context.mounted) {
                setState(() {});
              }
            },
            icon: const Icon(
              Icons.edit,
              color: azulText,
              size: 16,
            )),
        IconButton(
            onPressed: () async {
              await showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text(appLocal.eliminarModulo),
                        content: Text('${appLocal.seguroEliminarModulo}${widget.modulo!.nombre}'),
                        actions: [
                          CustomButton(
                            text: appLocal.siBorrar,
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
                            text: appLocal.cancelarBtn,
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
              size: 16,
            ))
      ]),
    );
  }
}

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
  late String idDriveFolder;
  late String idDriveZip;
  late String id;

  @override
  void initState() {
    super.initState();

    nombre = widget.modulo?.nombre ?? '';
    descripcion = widget.modulo?.descripcion ?? '';
    video = widget.modulo?.video ?? '';
    curso = widget.modulo?.curso ?? '';
    idDriveFolder = widget.modulo?.idDriveFolder ?? '';
    idDriveZip = widget.modulo?.idDriveZip ?? '';
    id = widget.modulo?.id ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    Provider.of<AllCursosProvider>(context, listen: false).getAllCursos();
    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: (id == '')
          ? Text(appLocal.nuevoModulo, style: DashboardLabel.h4)
          : Text(
              appLocal.editarModulo,
              style: DashboardLabel.h4,
            ),
      content: SingleChildScrollView(
        child: Container(
          decoration: buildBoxDecoration(),
          width: 300,
          height: 400,
          child: Column(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                child: Column(children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 500, minWidth: 315),
                    child: TextFormField(
                      cursorColor: azulText,
                      style: DashboardLabel.paragraph.copyWith(color: Colors.white.withOpacity(0.3)),
                      initialValue: nombre,
                      onChanged: (value) => nombre = value,
                      decoration: InputDecor.formFieldInputDecoration(
                        label: appLocal.nombreDelModulo,
                        icon: Icons.title_outlined,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 500, minWidth: 315),
                    child: TextFormField(
                      cursorColor: azulText,
                      maxLines: 3,
                      style: DashboardLabel.paragraph.copyWith(color: Colors.white.withOpacity(0.3)),
                      initialValue: descripcion,
                      onChanged: (value) => descripcion = value,
                      decoration: InputDecor.formFieldInputDecoration(
                        label: appLocal.descripcionDelModulo,
                        icon: Icons.description_outlined,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 500, minWidth: 315),
                    child: TextFormField(
                      cursorColor: azulText,
                      style: DashboardLabel.paragraph.copyWith(color: Colors.white.withOpacity(0.3)),
                      initialValue: video,
                      onChanged: (value) => video = value,
                      decoration: InputDecor.formFieldInputDecoration(
                        label: appLocal.urlVideoModulo,
                        icon: Icons.ondemand_video_outlined,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 500, minWidth: 315),
                    child: TextFormField(
                      cursorColor: azulText,
                      style: DashboardLabel.paragraph.copyWith(color: Colors.white.withOpacity(0.3)),
                      initialValue: idDriveFolder,
                      onChanged: (value) => idDriveFolder = value,
                      decoration: InputDecor.formFieldInputDecoration(
                        label: appLocal.idCarpertaModulo,
                        icon: Icons.folder_outlined,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 500, minWidth: 315),
                    child: TextFormField(
                      cursorColor: azulText,
                      style: DashboardLabel.paragraph.copyWith(color: Colors.white.withOpacity(0.3)),
                      initialValue: idDriveZip,
                      onChanged: (value) => idDriveZip = value,
                      decoration: InputDecor.formFieldInputDecoration(
                        label: appLocal.idZipModulo,
                        icon: Icons.compress_outlined,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        text: (id == '') ? appLocal.crearBtn : appLocal.actualizarBtn,
                        onPress: () async {
                          if (id == '') {
                            await Provider.of<AllCursosProvider>(context, listen: false).createModulo(
                              nombre: nombre,
                              video: video,
                              descripcion: descripcion,
                              idDriveFolder: idDriveFolder,
                              curso: widget.cursoID,
                              idDriveZip: idDriveZip,
                            );
                          } else {
                            await Provider.of<AllCursosProvider>(context, listen: false).updateModulo(
                              uid: id,
                              nombreModulo: nombre,
                              urlVideo: video,
                              descripcionModulo: descripcion,
                              idDriveFolder: idDriveFolder,
                              idDriveZip: idDriveZip,
                            );
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
                        text: appLocal.cancelarBtn,
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
