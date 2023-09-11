import 'package:flutter/material.dart';
import 'package:jp_director/models/testimonio.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../providers/export_all_providers.dart';
import '../botones/custom_button.dart';
import '../labels/dashboard_label.dart';
import '../labels/inputs_decorations.dart';

class NewTestimonioDialog extends StatefulWidget {
  final String cursoID;
  final Testimonio? testimonio;
  const NewTestimonioDialog({super.key, this.testimonio, required this.cursoID});

  @override
  State<NewTestimonioDialog> createState() => _NewTestimonioDialogState();
}

class _NewTestimonioDialogState extends State<NewTestimonioDialog> {
  late String id;
  late String nombre;
  late String img;
  late String testimonio;
  late String curso;

  @override
  void initState() {
    super.initState();
    id = widget.testimonio?.id ?? '';
    nombre = widget.testimonio?.nombre ?? '';
    img = widget.testimonio?.img ?? '';
    testimonio = widget.testimonio?.testimonio ?? '';
    curso = widget.testimonio?.cursoId ?? widget.cursoID;
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
          height: 500,
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
                        label: 'Name',
                        icon: Icons.title_outlined,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 500, minWidth: 315),
                    child: TextFormField(
                      cursorColor: azulText,
                      
                      style: DashboardLabel.paragraph.copyWith(color: Colors.white.withOpacity(0.3)),
                      initialValue: img,
                      onChanged: (value) => img = value,
                      decoration: InputDecor.formFieldInputDecoration(
                        label: 'Avatar Image',
                        icon: Icons.person_pin,
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
                      initialValue: testimonio,
                      onChanged: (value) => testimonio = value,
                      decoration: InputDecor.formFieldInputDecoration(
                        label: 'Testimonio',
                        icon: Icons.comment,
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
                            await Provider.of<AllCursosProvider>(context, listen: false)
                                .createTestimonio( context: context, nombre: nombre, img: img, testimonio: testimonio, curso: curso);
                          } else {
                            await Provider.of<AllCursosProvider>(context, listen: false)
                                .updateTestimonio(context: context, nombre: nombre, id: id, img: img, testimonio: testimonio, curso: curso);
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

BoxDecoration buildBoxDecoration() => const BoxDecoration(
    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    color: bgColor,
    boxShadow: [BoxShadow(color: Colors.black)]);
