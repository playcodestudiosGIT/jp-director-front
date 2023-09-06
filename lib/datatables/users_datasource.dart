import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jp_director/api/jp_api.dart';
import 'package:jp_director/constant.dart';
import 'package:jp_director/providers/all_cursos_provider.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';
import 'package:jp_director/ui/views/system/email_modal.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';
import '../models/curso.dart';
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
    final appLocal = AppLocalizations.of(context);
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
            if (user.rol == 'ADMIN_ROLE')
              const Positioned(
                  top: 0,
                  right: 0,
                  child: Icon(
                    Icons.star,
                    color: Colors.amberAccent,
                  )),
            const Positioned(
                bottom: 0,
                right: 0,
                child: Icon(
                  Icons.edit_outlined,
                  size: 18,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: 1, height: 150, color: blancoText.withOpacity(0.1)),
              const SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 200),
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 18,
                        color: blancoText.withOpacity(0.5),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${user.nombre} ${user.apellido}',
                        style: DashboardLabel.paragraph.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.email_outlined,
                        size: 18,
                        color: blancoText.withOpacity(0.5),
                      ),
                      const SizedBox(width: 8),
                      Text(user.correo, style: DashboardLabel.paragraph),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.phone_outlined,
                        size: 18,
                        color: blancoText.withOpacity(0.5),
                      ),
                      const SizedBox(width: 8),
                      Text(user.telf, style: DashboardLabel.paragraph),
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
                            ? Text(appLocal.activo, style: DashboardLabel.paragraph)
                            : Text(
                                appLocal.pendiente,
                                style: DashboardLabel.paragraph,
                              ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 15),
              Container(width: 1, height: 150, color: blancoText.withOpacity(0.1)),
              const SizedBox(width: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(appLocal.sobreMi, style: DashboardLabel.h4.copyWith(color: blancoText.withOpacity(.5))),
                  const SizedBox(height: 8),
                  SizedBox(
                      width: 200,
                      child: Text(
                        user.me,
                        style: DashboardLabel.paragraph,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                      )),
                ],
              ),
              const SizedBox(width: 15),
              Container(width: 1, height: 150, color: blancoText.withOpacity(0.1)),
              const SizedBox(width: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.instagram,
                        color: blancoText.withOpacity(0.5),
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(user.instagram, style: DashboardLabel.paragraph),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.facebook,
                        color: blancoText.withOpacity(0.5),
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(user.facebook, style: DashboardLabel.paragraph),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.tiktok,
                        color: blancoText.withOpacity(0.5),
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(user.tiktok, style: DashboardLabel.paragraph),
                    ],
                  )
                ],
              ),
              const SizedBox(width: 15),
              Container(width: 1, height: 150, color: blancoText.withOpacity(0.1)),
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
              final Curso curso = allCursosProvider.obtenerCurso(e);
              if (curso.img == "") return Container();
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    if (curso.img == "") const Image(image: NetworkImage(noimage), width: 25),
                    if (curso.img != "") Image(image: NetworkImage(curso.img), width: 25),
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
              splashRadius: 18,
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
                size: 18,
                color: azulText,
              )),
          IconButton(
              splashRadius: 18,
              onPressed: () async {
                final dialog = AlertDialog(
                  backgroundColor: bgColor,
                  content: EmailModalContent(
                    usuario: user,
                  ),
                );

                await showDialog(context: context, builder: (context) => dialog);
              },
              icon: const Icon(
                Icons.email_outlined,
                size: 18,
                color: blancoText,
              )),
          IconButton(
              splashRadius: 18,
              onPressed: () {
                final dialog = AlertDialog(
                  title: Text(appLocal.seguroBorrar),
                  content: Text('${appLocal.seguroBorrarUsuario} "${user.nombre}"'),
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
                            NotifServ.showSnackbarError('${appLocal.usuario} "${user.nombre}" ${appLocal.eliminado}', Colors.green);
                          } else {
                            if (context.mounted) Navigator.of(context).pop();
                            NotifServ.showSnackbarError(appLocal.errorEliminadoUsuario, Colors.red);
                          }
                        },
                        child: Text(appLocal.siBorrar))
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
                size: 18,
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
    final appLocal = AppLocalizations.of(context);
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;

      if (file.extension!.toLowerCase() != 'jpg' && file.extension!.toLowerCase() != 'jpeg' && file.extension!.toLowerCase() != 'png') {
        alertaDeDialogo(title: appLocal.extensionInvalida, dubtitle: appLocal.laExtensionDebe, textButton: 'OK');
      }
      if (file.size > 1000000) {
        alertaDeDialogo(title: appLocal.tamanoInvalido, dubtitle: appLocal.debePesarMenos, textButton: 'OK');
      }

      await JpApi.editUserImg('/uploads/usuarios/$id', file.bytes!);

      if (context.mounted) Provider.of<UsersProvider>(context, listen: false).getPaginatedUsers();

      notifyListeners();
      NotifServ.showSnackbarError(appLocal.imgCambiadaNtf, Colors.green);
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
