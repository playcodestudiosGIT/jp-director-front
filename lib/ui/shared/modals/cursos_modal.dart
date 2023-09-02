import 'package:flutter/material.dart';
import 'package:jp_director/constant.dart';
import 'package:jp_director/providers/all_cursos_provider.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';
import 'package:jp_director/ui/shared/labels/inputs_decorations.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../models/curso.dart';
import '../botones/custom_button.dart';
import 'new_module_dialog.dart';

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
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: buildBoxDecoration(),
      child: ListView(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                      size: 16,
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
              child: Column( children: [
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
                Wrap(
                  children: [
                    Container(
                      constraints: const BoxConstraints(maxWidth: 250, minWidth: 150),
                      child: TextFormField(
                        cursorColor: azulText,
                        style: DashboardLabel.paragraph.copyWith(color: Colors.white.withOpacity(0.3)),
                        initialValue: (curso.id == '') ? '' : curso.precio,
                        onChanged: (value) => allCursosProvider.precioCursoModal = value,
                        decoration: InputDecor.formFieldInputDecoration(label: appLocal.precioDelCurso, icon: Icons.price_change),
                      ),
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 250, minWidth: 150),
                      child: TextFormField(
                        cursorColor: azulText,
                        style: DashboardLabel.paragraph.copyWith(color: Colors.white.withOpacity(0.3)),
                        initialValue: (curso.id == '') ? '' : curso.totalEstudiantes,
                        onChanged: (value) => allCursosProvider.estudiantesCursoModal = value,
                        decoration: InputDecor.formFieldInputDecoration(label: 'Students', icon: Icons.group),
                      ),
                    ),
                  ],
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
                            if (publicado)
                              Text(appLocal.si, style: DashboardLabel.paragraph.copyWith(color: Colors.green, fontWeight: FontWeight.bold)),
                            if (!publicado) Text('NO', style: DashboardLabel.paragraph.copyWith(color: Colors.red, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    )),
              ]),
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


