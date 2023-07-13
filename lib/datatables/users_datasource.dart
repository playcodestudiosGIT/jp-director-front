import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/api/jp_api.dart';
import 'package:jpdirector_frontend/constant.dart';
import 'package:jpdirector_frontend/providers/all_cursos_provider.dart';
import 'package:jpdirector_frontend/ui/shared/labels/dashboard_label.dart';
import 'package:provider/provider.dart';

import '../models/usuario_model.dart';
import '../providers/users_provider.dart';
import '../services/notificacion_service.dart';
import '../ui/cards/white_card.dart';
import '../ui/shared/modals/users_modal.dart';

class UsersDTS extends DataTableSource {
  List<Usuario> users;
  final BuildContext context;

  UsersDTS(this.users, this.context);

  @override
  DataRow getRow(int index) {
    late final user = users[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: bgColor,
                backgroundImage: (user.img != '') ? NetworkImage(user.img) : const NetworkImage('url'),
              ),
            ),
            if(user.rol == 'ADMIN_ROLE')
            const Positioned(
              top: 0,
              right: 0,
              child: Icon(Icons.star, color: Colors.amberAccent,)),
            const Positioned(
                bottom: 0,
                right: 0,
                child: Icon(
                  Icons.edit_outlined,
                  size: 15,
                  color: bgColor,
                )),
          ],
        ),
        onTap: () => pickImage(context, user.uid.toString()),
      ),
      DataCell(Center(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.person_outline,
                        size: 12,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${user.nombre} ${user.apellido}',
                        style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.email_outlined,
                        size: 12,
                      ),
                      const SizedBox(width: 8),
                      Text(user.correo, style: GoogleFonts.roboto()),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.phone_outlined,
                        size: 12,
                      ),
                      const SizedBox(width: 8),
                      Text(user.telf, style: GoogleFonts.roboto()),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: (user.estado) ? Colors.green : Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: (user.estado)
                            ? Text('ACTIVO', style: DashboardLabel.paragraph)
                            : Text(
                                'PENDIENTE',
                                style: GoogleFonts.roboto(color: Colors.white),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sobre mi', style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  SizedBox(
                      width: 200,
                      child: Text(
                        user.me,
                        style: GoogleFonts.roboto(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                      )),
                ],
              ),
              const SizedBox(width: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(FontAwesomeIcons.instagram),
                      const SizedBox(width: 10),
                      Text(user.instagram, style: GoogleFonts.roboto()),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(FontAwesomeIcons.facebook),
                      const SizedBox(width: 10),
                      Text(user.facebook, style: GoogleFonts.roboto()),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(FontAwesomeIcons.tiktok),
                      const SizedBox(width: 10),
                      Text(user.tiktok, style: GoogleFonts.roboto()),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      )),
      DataCell(Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...user.cursos.map((e) {
              final allCursosProvider = Provider.of<AllCursosProvider>(context, listen: false);
              final curso = allCursosProvider.obtenerCurso(e);
              return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Row(
                          children: [
                            if(curso.img == "")
                            const Image(image: NetworkImage(noimage), width: 25),
                            if (curso.img != "")
                            Image(image: NetworkImage(curso.img), width: 25),
                            const SizedBox(width: 10),
                            Text(curso.nombre),
                          ],
                        ),
                      );
            })
          ],
        ),
      )),
      DataCell(Row(
        children: [
          IconButton(
              onPressed: () async {
                final isAct = await showModalBottomSheet(
                  isDismissible: false,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => UsersModal(user: user),
                );

                if (isAct && context.mounted) {
                  await Provider.of<UsersProvider>(context, listen: false).getPaginatedUsers();
                  
                }
              },
              icon: const Icon(
                Icons.edit_outlined,
                size: 16,
                color: bgColor,
              )),
          IconButton(
              onPressed: () {
                final dialog = AlertDialog(
                  title: const Text('Esta seguro de borrar'),
                  content: Text('Borrar definitivamente el usuario "${user.nombre}"'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('No')),
                    TextButton(
                        onPressed: () async {
                          //BORRAR USUARIO
                          final isDelete = await Provider.of<UsersProvider>(context, listen: false).deleteUser(user.uid.toString());

                          if (isDelete && context.mounted) {
                            Navigator.of(context).pop();
                            NotificationServices.showSnackbarError('Usuario "${user.nombre}" Eliminado', Colors.green);
                          } else {
                            Navigator.of(context).pop();
                            NotificationServices.showSnackbarError('Error Eliminando Usuario', Colors.red);
                          }
                        },
                        child: const Text('Si, Borrar'))
                  ],
                );
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => dialog,
                );
              },
              icon: Icon(
                Icons.delete_outline,
                size: 16,
                color: Colors.red.withOpacity(0.8),
              )),
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => users.length;

  @override
  int get selectedRowCount => 0;

  pickImage(BuildContext context, String id) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;

      if (file.extension!.toLowerCase() != 'jpg' && file.extension!.toLowerCase() != 'jpeg' && file.extension!.toLowerCase() != 'png') {
        alertaDeDialogo(title: 'Extension Invalida', dubtitle: 'La extension debe ser "PNG, JPG ó JPEG"', textButton: 'Entendido');
      }
      if (file.size > 1000000) {
        alertaDeDialogo(title: 'Tamaño invalido', dubtitle: 'La imagen debe pesar menos de 1 MB', textButton: 'Entendido');
      }

      await JpApi.editUserImg('/uploads/usuarios/$id', file.bytes!);

      if (context.mounted) Provider.of<UsersProvider>(context, listen: false).getPaginatedUsers();

      notifyListeners();
      NotificationServices.showSnackbarError('cambiada con exito', Colors.green);
    } else {
      // User canceled the picker
    }
  }

  alertaDeDialogo({required String title, required String dubtitle, required String textButton}) {
    return showDialog(
      context: context,
      builder: (context) => Center(
          child: SizedBox(
              width: 200,
              height: 200,
              child: WhiteCard(
                  // isDrag: false,
                  title: title,
                  child: Center(
                      child: Column(
                    children: [
                      Text(dubtitle),
                      const SizedBox(
                        height: 60,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [ElevatedButton(onPressed: () => Navigator.pop(context), child: Text(textButton))],
                      )
                    ],
                  ))))),
    );
  }
}
