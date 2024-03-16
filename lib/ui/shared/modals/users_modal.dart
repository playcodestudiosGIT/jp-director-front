import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jp_director/constant.dart';
import 'package:jp_director/providers/all_cursos_provider.dart';
import 'package:jp_director/providers/auth_provider.dart';
import 'package:jp_director/providers/users_provider.dart';
import 'package:jp_director/services/notificacion_service.dart';
import 'package:jp_director/ui/shared/botones/custom_button.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../models/curso.dart';
import '../../../models/usuario_model.dart';
import '../labels/inputs_decorations.dart';
import '../widgets/square_curso.dart';

class UsersModal extends StatefulWidget {
  final Usuario? user;

  const UsersModal({Key? key, this.user}) : super(key: key);

  @override
  State<UsersModal> createState() => _UsersModalState();
}

class _UsersModalState extends State<UsersModal> {
  String? nombre;
  late String? apellido;
  late String? correo;
  late String? clave;
  late String? rol;
  late String? telf;
  late String? me;
  late String? instagram;
  late String? facebook;
  late String? tiktok;
  late bool estado;
  List<String> cursos = [];

  String? id;

  @override
  void initState() {
    super.initState();
    id = widget.user?.uid;
    nombre = widget.user?.nombre;
    apellido = widget.user?.apellido;
    correo = widget.user?.correo;
    telf = widget.user?.telf;
    me = widget.user?.me;
    instagram = widget.user?.instagram;
    facebook = widget.user?.facebook;
    tiktok = widget.user?.tiktok;
    clave = '';
    rol = widget.user?.rol ?? 'USER_ROLE';
    estado = widget.user?.estado ?? false;
    if (id != null) {
      cursos = widget.user!.cursos;
    } else {
      cursos = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final usersProvider = Provider.of<UsersProvider>(context);

    final allCursosProvider = Provider.of<AllCursosProvider>(context, listen: false);
    final destruct = cursos.map((e) => allCursosProvider.obtenerCurso(e));
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      height: 600,
      width: 355, // expande
      decoration: buildBoxDecoration(),
      child: ListView(children: [
        Column(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                Text(
                  (id != null) ? '${appLocal.editar2puntos} ${widget.user?.nombre}' : appLocal.nuevoUsuario,
                  style: DashboardLabel.h4,
                ),
                const Spacer(),
                IconButton(
                    onPressed: () => Navigator.pop(context, false),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 18,
                    ))
              ],
            ),
            Divider(
              color: bgColor.withOpacity(0.3),
            ),
            const SizedBox(
              height: 15 / 2,
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 15,
                runSpacing: 15,
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 400, minWidth: 315),
                    child: TextFormField(
                      cursorColor: azulText,
                      style: DashboardLabel.paragraph,
                      initialValue: widget.user?.nombre ?? '',
                      onChanged: (value) => nombre = value,
                      decoration: InputDecor.formFieldInputDecoration(label: appLocal.nombreDeUsuario, icon: Icons.perm_identity_sharp),
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 400, minWidth: 315),
                    child: TextFormField(
                      cursorColor: azulText,
                      style: DashboardLabel.paragraph,
                      initialValue: widget.user?.apellido ?? '',
                      onChanged: (value) => apellido = value,
                      decoration: InputDecor.formFieldInputDecoration(label: appLocal.apellidoDeUsuario, icon: Icons.supervised_user_circle_outlined),
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 400, minWidth: 315),
                    child: TextFormField(
                      cursorColor: azulText,
                      style: DashboardLabel.paragraph,
                      initialValue: widget.user?.correo ?? '',
                      onChanged: (value) {
                        correo = value;
                      },
                      decoration: InputDecor.formFieldInputDecoration(label: appLocal.correoDeUsuario, icon: Icons.email_outlined),
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 400, minWidth: 315),
                    child: TextFormField(
                      cursorColor: azulText,
                      style: DashboardLabel.paragraph,
                      initialValue: '',
                      onChanged: (value) {
                        clave = value;
                      },
                      decoration: InputDecor.formFieldInputDecoration(label: 'Password', icon: Icons.password),
                    ),
                  ),

                  if (id != null) ...[
                    Container(
                      constraints: const BoxConstraints(maxWidth: 400, minWidth: 315),
                      child: TextFormField(
                        cursorColor: azulText,
                        style:DashboardLabel.paragraph,
                        initialValue: widget.user?.telf ?? '',
                        onChanged: (value) => telf = value,
                        decoration: InputDecor.formFieldInputDecoration(label: appLocal.telefonoDeUsuario, icon: Icons.phone),
                      ),
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 400, minWidth: 315),
                      child: TextFormField(
                        cursorColor: azulText,
                        style: DashboardLabel.paragraph,
                        initialValue: widget.user?.me ?? appLocal.sobreMi,
                        onChanged: (value) => me = value,
                        decoration: InputDecor.formFieldInputDecoration(label: appLocal.sobreMi, icon: Icons.phone),
                      ),
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 400, minWidth: 315),
                      child: TextFormField(
                        cursorColor: azulText,
                        style: DashboardLabel.paragraph,
                        initialValue: widget.user?.instagram ?? 'Instagram',
                        onChanged: (value) => instagram = value,
                        decoration: InputDecor.formFieldInputDecoration(label: 'Instagram', icon: FontAwesomeIcons.instagram),
                      ),
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 400, minWidth: 315),
                      child: TextFormField(
                        cursorColor: azulText,
                        style: DashboardLabel.paragraph,
                        initialValue: widget.user?.facebook ?? 'Facebook',
                        onChanged: (value) => facebook = value,
                        decoration: InputDecor.formFieldInputDecoration(label: 'Facebook', icon: FontAwesomeIcons.facebook),
                      ),
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 400, minWidth: 315),
                      child: TextFormField(
                        cursorColor: azulText,
                        style:DashboardLabel.paragraph,
                        initialValue: widget.user?.tiktok ?? 'Tiktok',
                        onChanged: (value) => tiktok = value,
                        decoration: InputDecor.formFieldInputDecoration(label: 'Tiktok', icon: FontAwesomeIcons.tiktok),
                      ),
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 400, minWidth: 315),
                      child: TextFormField(
                        cursorColor: azulText,
                        style: DashboardLabel.paragraph,
                        onChanged: (value) => clave = value,
                        decoration: InputDecor.formFieldInputDecoration(label: appLocal.passDeUsuario, icon: Icons.password),
                      ),
                    ),
                    Container(
                        height: 40,
                        decoration: BoxDecoration(border: Border.all(color: azulText.withOpacity(0.3), strokeAlign: 1)),
                        constraints: const BoxConstraints(maxWidth: 400, minWidth: 315),
                        child: Center(
                          child: DropdownButton(
                            isDense: true,
                            style: DashboardLabel.paragraph,
                            dropdownColor: bgColor,
                            value: rol,
                            underline: Container(),
                            isExpanded: true,
                            onChanged: (value) {
                              rol = value.toString();
                              setState(() {});
                            },
                            items: [
                              DropdownMenuItem(
                                value: 'USER_ROLE',
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Center(
                                    child: Text(
                                      'ROLE: ${appLocal.usuario}',
                                      style: DashboardLabel.paragraph,
                                    ),
                                  ),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'ADMIN_ROLE',
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Center(
                                    child: Text(
                                      'ROLE: ADMIN',
                                      style: DashboardLabel.paragraph,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                  ]
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 15,
                runSpacing: 15,
                children: [
                  const SizedBox(width: 10),
                  Container(
                      constraints: const BoxConstraints(maxWidth: 400, minWidth: 315),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 50,
                            child: Switch(
                              trackOutlineColor: MaterialStatePropertyAll(azulText.withOpacity(0.3)),
                              activeColor: Colors.green,
                              value: estado,
                              onChanged: (value) => setState(() {
                                estado = value;
                              }),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Row(
                            children: [
                              Text(
                                '${appLocal.estado}:  ',
                                style: DashboardLabel.paragraph,
                              ),
                              if (estado)
                                Text(appLocal.activo, style: DashboardLabel.paragraph.copyWith(color: Colors.green, fontWeight: FontWeight.bold)),
                              if (!estado)
                                Text(appLocal.pendiente, style: DashboardLabel.paragraph.copyWith(color: Colors.red, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      )),
                  const SizedBox(height: 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          if (id != null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  appLocal.cursos,
                                  style: DashboardLabel.h3,
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                          if (id != null)
                            Row(
                              children: [
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () async {
                                      AlertDialog dialog = AlertDialog(
                                        elevation: 0,
                                        backgroundColor: Colors.transparent,
                                        content: AddCursoModal(
                                          userId: id!,
                                        ),
                                      );

                                      final isAdd = await showDialog(context: context, builder: (context) => dialog);
                                      if (isAdd) {
                                        setState(() {
                                          Navigator.pop(context, true);
                                          Provider.of<UsersProvider>(context, listen: false).getPaginatedUsers();
                                        });
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.add_box_outlined,
                                          color: azulText,
                                          size: 18,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          appLocal.anadirCurso,
                                          style: DashboardLabel.mini.copyWith(color: azulText),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          const SizedBox(height: 15),
                          ...destruct
                              .map((e) => SquareCurso(
                                    userId: widget.user!.uid,
                                    curso: e,
                                  ))
                              .toList()
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
                          width: 100,
                          onPress: () async {
                            if (id == null) {
                              // Crear
                              await Provider.of<UsersProvider>(context, listen: false).createUser(nombre, apellido, correo, clave, 'USER_ROLE', estado);
                              NotifServ.showSnackbarError(appLocal.usuarioCreado, Colors.green);
                            } else {
                              await usersProvider.updateUser(
                                  uid: id,
                                  pass: clave,
                                  nombre: nombre,
                                  apellido: apellido,
                                  correo: correo,
                                  telf: telf,
                                  me: me,
                                  tiktok: tiktok,
                                  facebook: facebook,
                                  instagram: instagram,
                                  estado: estado,
                                  rol: rol);
                              NotifServ.showSnackbarError(appLocal.usuarioActualizado, Colors.green);
                            }

                            if (context.mounted) {
                              Navigator.pop(context, true);
                            }
                          },
                          text: (widget.user != null) ? appLocal.actualizarBtn : appLocal.crearBtn,
                          color: Colors.green,
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
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 80,
            )
          ],
        ),
      ]),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      color: bgColor,
      boxShadow: [BoxShadow(color: Colors.black)]);
}

// ....................................................................................

class AddCursoModal extends StatefulWidget {
  final String userId;
  const AddCursoModal({super.key, required this.userId});

  @override
  State<AddCursoModal> createState() => _AddCursoModalState();
}

class _AddCursoModalState extends State<AddCursoModal> {
  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final allCursosProvider = Provider.of<AllCursosProvider>(context);
    List<Curso> allCursos = Provider.of<AllCursosProvider>(context).allCursos;
    final authProvider = Provider.of<AuthProvider>(context);
    String cursoId = '';
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        height: 200,
        decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(25)),
        child: Center(
          child: Column(
            children: [
              Text(
                appLocal.listaDeCursos.toUpperCase(),
                style: DashboardLabel.h3,
              ),
              const SizedBox(height: 30),
              DropdownButton(
                  value: allCursosProvider.cursoSelected,
                  hint: Text(
                    appLocal.seleccioneCurso,
                    style: DashboardLabel.h4,
                  ),
                  dropdownColor: bgColor,
                  elevation: 0,
                  style: DashboardLabel.h4,
                  selectedItemBuilder: (BuildContext context) {
                    return allCursos.map<Widget>((Curso item) {
                      return Text(
                        item.nombre,
                        style: DashboardLabel.h4,
                      );
                    }).toList();
                  },
                  items: allCursos.map<DropdownMenuItem<String>>((Curso item) {
                    return DropdownMenuItem<String>(
                      value: item.id,
                      child: Text(
                        item.nombre,
                        style: DashboardLabel.h4,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      cursoId = value.toString();
                      allCursosProvider.cursoSelected = value;
                    });
                  }),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    text: appLocal.agregarBtn,
                    onPress: () {
                      if (!authProvider.user!.cursos.contains(cursoId)) {
                        allCursosProvider.addCursoToUser(context: context, userId: widget.userId);
                      } else {
                        NotifServ.showSnackbarError(appLocal.cursoRepetido, Colors.red);
                      }
                      Navigator.pop(context, true);
                    },
                    width: 90,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 8),
                  CustomButton(
                    text: appLocal.cancelarBtn,
                    onPress: () {
                      Navigator.pop(context, false);
                    },
                    width: 90,
                    color: Colors.red,
                  )
                ],
              )
            ],
          ),
        ));
  }
}

// ..........................................................................................


