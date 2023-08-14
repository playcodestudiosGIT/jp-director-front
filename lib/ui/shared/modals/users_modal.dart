import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/constant.dart';
import 'package:jpdirector_frontend/providers/all_cursos_provider.dart';
import 'package:jpdirector_frontend/providers/auth_provider.dart';
import 'package:jpdirector_frontend/providers/users_provider.dart';
import 'package:jpdirector_frontend/services/notificacion_service.dart';
import 'package:jpdirector_frontend/ui/shared/botones/custom_button.dart';
import 'package:jpdirector_frontend/ui/shared/labels/dashboard_label.dart';
import 'package:provider/provider.dart';

import '../../../models/curso.dart';
import '../../../models/usuario_model.dart';

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
    final usersProvider = Provider.of<UsersProvider>(context);
    final size = MediaQuery.of(context).size;
    final allCursosProvider = Provider.of<AllCursosProvider>(context, listen: false);
    final destruct = cursos.map((e) => allCursosProvider.obtenerCurso(e));
    return Container(
      height: 600,
      width: 355, // expande
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
                  (id != null) ? 'Editar: ${widget.user?.nombre}' : 'Nuevo Usuario',
                  style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () => Navigator.pop(context, false),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 25,
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
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 15 / 2,
                runSpacing: 15 / 2,
                children: [
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      style: GoogleFonts.roboto(color: Colors.white),
                      initialValue: widget.user?.nombre ?? '',
                      onChanged: (value) => nombre = value,
                      decoration: buildInputDecoration(label: 'Nombre de usuario', icon: Icons.perm_identity_sharp),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      style: GoogleFonts.roboto(color: Colors.white),
                      initialValue: widget.user?.apellido ?? '',
                      onChanged: (value) => apellido = value,
                      decoration: buildInputDecoration(label: 'Apellido de usuario', icon: Icons.supervised_user_circle_outlined),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      style: GoogleFonts.roboto(color: Colors.white),
                      initialValue: widget.user?.correo ?? '',
                      onChanged: (value) {
                        correo = value;
                      },
                      decoration: buildInputDecoration(label: 'Correo de usuario', icon: Icons.email_outlined),
                    ),
                  ),
                  if (id != null) ...[
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        style: GoogleFonts.roboto(color: Colors.white),
                        initialValue: widget.user?.telf ?? '',
                        onChanged: (value) => telf = value,
                        decoration: buildInputDecoration(label: 'Teléfono de usuario', icon: Icons.phone),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        style: GoogleFonts.roboto(color: Colors.white),
                        initialValue: widget.user?.me ?? 'Sobre mi',
                        onChanged: (value) => me = value,
                        decoration: buildInputDecoration(label: 'Sobre mi', icon: Icons.phone),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        style: GoogleFonts.roboto(color: Colors.white),
                        initialValue: widget.user?.instagram ?? 'Instagram',
                        onChanged: (value) => instagram = value,
                        decoration: buildInputDecoration(label: 'Instagram', icon: FontAwesomeIcons.instagram),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        style: GoogleFonts.roboto(color: Colors.white),
                        initialValue: widget.user?.facebook ?? 'Facebook',
                        onChanged: (value) => facebook = value,
                        decoration: buildInputDecoration(label: 'Facebook', icon: FontAwesomeIcons.facebook),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        style: GoogleFonts.roboto(color: Colors.white),
                        initialValue: widget.user?.tiktok ?? 'Tiktok',
                        onChanged: (value) => tiktok = value,
                        decoration: buildInputDecoration(label: 'Tiktok', icon: FontAwesomeIcons.tiktok),
                      ),
                    ),
                  ]
                ],
              ),
            ),
            const SizedBox(
              height: 15 / 2,
            ),
            Padding(
              padding: (size.width > 580) ? const EdgeInsets.only(left: 35) : const EdgeInsets.only(left: 0),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 15 / 2,
                runSpacing: 15 / 2,
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          style: GoogleFonts.roboto(color: Colors.white),
                          onChanged: (value) => clave = value,
                          decoration: buildInputDecoration(label: 'Contraseña', icon: Icons.password),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: azulText.withOpacity(0.3))),
                          width: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 55.0),
                                child: Text('Rol', style: GoogleFonts.roboto(color: Colors.white, fontSize: 12)),
                              ),
                              const SizedBox(height: 8),
                              DropdownButton(
                                isDense: true,
                                style: GoogleFonts.roboto(color: Colors.white),
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
                                          'USUARIO',
                                          style: GoogleFonts.roboto(color: Colors.white),
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
                                          'ADMIN',
                                          style: GoogleFonts.roboto(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )),
                      const SizedBox(width: 10),
                      SizedBox(
                          width: 200,
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
                                    'ESTADO: ',
                                    style: DashboardLabel.paragraph,
                                  ),
                                  if (estado)
                                    Text('ACTIVO', style: DashboardLabel.paragraph.copyWith(color: Colors.green, fontWeight: FontWeight.bold)),
                                  if (!estado)
                                    Text('PENDIENTE', style: DashboardLabel.paragraph.copyWith(color: Colors.red, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          )),
                    ],
                  ),
                  const SizedBox(height: 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(maxWidth: 355),
                        child: Column(
                          children: [
                            if (id != null)
                              Row(
                                children: [
                                  const SizedBox(width: 15),
                                  Text(
                                    'CURSOS',
                                    style: GoogleFonts.roboto(color: Colors.white),
                                  ),
                                  const SizedBox(width: 15),
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
                                        children: [
                                          const Icon(Icons.add_box_outlined, color: azulText),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Añadir Curso',
                                            style: GoogleFonts.roboto(color: Colors.white.withOpacity(0.3), fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            const SizedBox(height: 15),
                            ...destruct
                                .map((e) => SquareModulo(
                                      userId: widget.user!.uid,
                                      curso: e,
                                    ))
                                .toList()
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
                          width: 100,
                          onPress: () async {
                            if (id == null) {
                              // Crear
                              await Provider.of<UsersProvider>(context, listen: false).createUser(nombre, apellido, correo, clave, rol, estado);
                              NotifServ.showSnackbarError('Usuario Creado con exito', Colors.green);
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
                              NotifServ.showSnackbarError('Usuario actualizado con exito', Colors.green);
                            }

                            if (context.mounted) {
                              Navigator.pop(context, true);
                            }
                          },
                          text: (widget.user != null) ? 'Actualizar' : 'Crear',
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
                          text: 'Cancelar',
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
                'Lista de cursos'.toUpperCase(),
                style: DashboardLabel.h3,
              ),
              const SizedBox(height: 30),
              DropdownButton(
                  value: allCursosProvider.cursoSelected,
                  hint: Text(
                    'Seleccione un curso',
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
                    text: 'Agregar',
                    onPress: () {
                      if (!authProvider.user!.cursos.contains(cursoId)) {
                        allCursosProvider.addCursoToUser(context: context, userId: widget.userId);
                      } else {
                        NotifServ.showSnackbarError('Curso repetido', Colors.red);
                      }
                      Navigator.pop(context, true);
                    },
                    width: 90,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 8),
                  CustomButton(
                    text: 'Cancelar',
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

class SquareModulo extends StatefulWidget {
  final Curso? curso;
  final String userId;
  const SquareModulo({
    super.key,
    this.curso,
    required this.userId,
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
      height: 60,
      // color: Colors.white.withOpacity(0.2),
      child: Row(children: [
        Icon(Icons.menu_book_outlined, color: Colors.white.withOpacity(0.3)),
        const SizedBox(width: 10),
        Text(
          widget.curso!.nombre,
          style: GoogleFonts.roboto(color: Colors.white.withOpacity(0.3)),
        ),
        const Spacer(),
        IconButton(
            onPressed: () async {
              final isOk = await showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text('Eliminar Modulo'),
                        content: Text('Estas seguro de eliminar el curso ${widget.curso!.nombre}'),
                        actions: [
                          CustomButton(
                            text: 'Eliminar',
                            onPress: () async {
                              await Provider.of<AllCursosProvider>(context, listen: false)
                                  .deleteCursoToUser(userId: widget.userId, cursoId: widget.curso!.id);
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
              if (isOk) {
                if (context.mounted) Navigator.pop(context, true);
              }
            },
            icon: const Center(
              child: Icon(
                Icons.delete,
                color: Colors.red,
                size: 20,
              ),
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
