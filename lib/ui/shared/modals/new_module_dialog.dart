import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../models/modulo.dart';
import '../../../providers/export_all_providers.dart';
import '../botones/custom_button.dart';
import '../labels/dashboard_label.dart';
import '../labels/inputs_decorations.dart';



class NewModuleDialog extends StatefulWidget {
  final String cursoID;
  final Modulo? modulo;
  const NewModuleDialog({super.key, this.modulo, required this.cursoID});

  @override
  State<NewModuleDialog> createState() => _NewModuleDialogState();
}

class _NewModuleDialogState extends State<NewModuleDialog> {
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
    curso = widget.modulo?.curso ?? widget.cursoID;
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
                              context: context,
                              nombre: nombre,
                              video: video,
                              descripcion: descripcion,
                              idDriveFolder: idDriveFolder,
                              curso: curso,
                              idDriveZip: idDriveZip,
                            );
                          } else {
                            await Provider.of<AllCursosProvider>(context, listen: false).updateModulo(
                              context: context,
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
BoxDecoration buildBoxDecoration() => const BoxDecoration(
    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    color: bgColor,
    boxShadow: [BoxShadow(color: Colors.black)]);