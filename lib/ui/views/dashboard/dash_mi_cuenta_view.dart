import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/providers/users_provider.dart';
import 'package:jpdirector_frontend/ui/shared/botones/custom_button.dart';
import 'package:jpdirector_frontend/ui/shared/labels/title_label.dart';

import 'package:provider/provider.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../api/jp_api.dart';
import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../providers/auth_provider.dart';
import '../../../services/notificacion_service.dart';
import '../../cards/white_card.dart';
import '../../shared/labels/dashboard_label.dart';

// ignore: must_be_immutable
class DashMiCuenta extends StatefulWidget {
  
  const DashMiCuenta({super.key});

  @override
  State<DashMiCuenta> createState() => _DashMiCuentaState();
}

class _DashMiCuentaState extends State<DashMiCuenta> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: 'dashFormKey');
  GlobalKey<FormState> formKey1 = GlobalKey<FormState>(debugLabel: 'dashFormKey1');
  String newPass = '';
  String reptNewPass = '';
  late String nombreModal;
  late String apellidoModal;
  late String correoModal ;
  late String telfModal ;
  late String meModal ;
  late String claveModal ;
  late String facebookModal ;
  late String instagramModal ;
  late String tiktokModal ;

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    nombreModal = authProvider.user!.nombre;
    apellidoModal = authProvider.user!.apellido;
    telfModal = authProvider.user!.telf;
    correoModal = authProvider.user!.correo;
    meModal = authProvider.user!.me;
    claveModal = '';
    facebookModal = authProvider.user!.facebook;
    instagramModal = authProvider.user!.instagram;
    tiktokModal = authProvider.user!.tiktok;
  }

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final usersProvider = Provider.of<UsersProvider>(context);

    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        const SizedBox(
          height: 80,
        ),
        TitleLabel(texto: appLocal.miCuentaMenuBtn),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 30,
          runSpacing: 30,
          children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 100,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  authProvider.user!.img,
                  width: 250,
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => pickImage(context, authProvider.user!.uid),
                    child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: const Color(0xff021E36), borderRadius: BorderRadius.circular(14)),
                        width: 57,
                        height: 44,
                        child: const Icon(
                          Icons.flip_camera_ios_outlined,
                          color: azulText,
                          size: 35,
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 250,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text(
                '${authProvider.user!.nombre} ${authProvider.user!.apellido}',
                textAlign: TextAlign.start,
                style: GoogleFonts.roboto(fontSize: 26, fontWeight: FontWeight.w900, color: blancoText),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.email_outlined, color: Colors.white.withOpacity(0.3)),
                  const SizedBox(width: 8),
                  Text(
                    authProvider.user!.correo,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w300, color: blancoText),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.phone_outlined, color: Colors.white.withOpacity(0.3)),
                  const SizedBox(width: 8),
                  Text(
                    authProvider.user!.telf,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w300, color: blancoText),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
        Container(
          constraints: const BoxConstraints(maxWidth: 600, minWidth: 370, minHeight: 130),
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: 150,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(22), color: blancoText.withOpacity(0.1)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appLocal.sobreMi,
                style: const TextStyle(color: blancoText, fontSize: 18),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 15),
              Text(
                authProvider.user!.me,
                maxLines: 5,
                style: const TextStyle(color: blancoText),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Column(
          children: [
            CustomButton(
              text: appLocal.actInfoBtn,
              width: 200,
              onPress: () async {
                final dialog = AlertDialog(
                  backgroundColor: bgColor,
                  actions: [
                    CustomButton(
                      text: appLocal.actualizarBtn,
                      onPress: () async {
                        await usersProvider.updateUser(
                            uid: authProvider.user!.uid,
                            nombre: nombreModal,
                            apellido: apellidoModal,
                            correo: correoModal,
                            me: meModal,
                            telf: telfModal,
                            facebook: facebookModal,
                            instagram: instagramModal,
                            tiktok: tiktokModal,
                            pass: claveModal,
                            );
                        if (context.mounted) {
                          setState(() {
                            Navigator.pop(context, true);
                          });
                        }
                      },
                      width: 100,
                      color: Colors.green,
                    ),
                    CustomButton(
                      text: appLocal.cancelarBtn,
                      onPress: () {
                        Navigator.pop(context, false);
                      },
                      width: 100,
                      color: Colors.red,
                    ),
                  ],
                  content: Container(
                    color: Colors.transparent,
                    margin: const EdgeInsets.only(left: 10),
                    height: 406,
                    width: 320,
                    child: Column(
                      children: [
                        Text(
                          appLocal.actInfo,
                          style: DashboardLabel.h1,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 500, minWidth: 360),
                          child: TextFormField(
                            cursorColor: azulText,
                            initialValue: authProvider.user!.nombre,
                            onChanged: (value) {
                              nombreModal = value;
                              authProvider.user!.nombre = value;
                            },
                            style: GoogleFonts.roboto(color: Colors.white, fontSize: 14),
                            decoration: buildInputDecoration(icon: FontAwesomeIcons.userAstronaut, label: appLocal.nombreTextField),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 500, minWidth: 360),
                          child: TextFormField(
                            cursorColor: azulText,
                            initialValue: authProvider.user!.apellido,
                            onChanged: (value) {
                              apellidoModal = value;
                              authProvider.user!.apellido = value;
                            },
                            style: GoogleFonts.roboto(color: Colors.white, fontSize: 14),
                            decoration: buildInputDecoration(icon: FontAwesomeIcons.idCard, label: appLocal.apellidoTextFiel),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          
                          constraints: const BoxConstraints(maxWidth: 500, minWidth: 360),
                          child: TextFormField(
                            cursorColor: azulText,
                            keyboardType: TextInputType.phone,
                            initialValue: authProvider.user!.telf,
                            onChanged: (value) {
                              telfModal = value.toString();
                              authProvider.user!.telf = value;
                            },
                            style: GoogleFonts.roboto(color: Colors.white, fontSize: 14),
                            decoration: buildInputDecoration(icon: FontAwesomeIcons.phone, label: appLocal.telefonoForm),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 500, minWidth: 360),
                          child: TextFormField(
                            cursorColor: azulText,
                            keyboardType: TextInputType.emailAddress,
                            initialValue: authProvider.user!.correo,
                            onChanged: (value) {
                              correoModal = value;
                              authProvider.user!.correo = value;
                            },
                            style: GoogleFonts.roboto(color: Colors.white, fontSize: 14),
                            decoration: buildInputDecoration(icon: FontAwesomeIcons.addressCard, label: appLocal.correoTextFiel),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 500, minWidth: 360),
                          child: TextFormField(
                            cursorColor: azulText,
                            maxLines: 4,
                            initialValue: authProvider.user!.me,
                            onChanged: (value) {
                              meModal = value;
                              authProvider.user!.me = value;
                            },
                            style: GoogleFonts.roboto(color: Colors.white, fontSize: 14),
                            decoration: buildInputDecoration(icon: FontAwesomeIcons.circleInfo, label: appLocal.sobreMi),
                          ),
                        ),
                      ],
                    ),
                  ),
                );

                final ifAct = await showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => dialog,
                );

                if (ifAct) {
                  setState(() {});
                }
              },
            )
          ],
        ),
        const SizedBox(
          height: 60,
        ),
        Form(
          key: formKey1,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                TitleLabel(texto: appLocal.redesSociales),
                const SizedBox(
                  height: 25,
                ),
                Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(22), color: blancoText.withOpacity(0.1)),
                    padding: const EdgeInsets.all(15),
                    constraints: const BoxConstraints(maxWidth: 400, minWidth: 320),
                    child: Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.facebook,
                          color: blancoText,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          authProvider.user!.facebook,
                          style: const TextStyle(color: blancoText),
                        )
                      ],
                    )),
                const SizedBox(
                  height: 15,
                ),
                Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(22), color: blancoText.withOpacity(0.1)),
                    constraints: const BoxConstraints(maxWidth: 400, minWidth: 320),
                    child: Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.instagram,
                          color: blancoText,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(authProvider.user!.instagram, style: const TextStyle(color: blancoText))
                      ],
                    )),
                const SizedBox(
                  height: 15,
                ),
                Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(22), color: blancoText.withOpacity(0.1)),
                    padding: const EdgeInsets.all(15),
                    constraints: const BoxConstraints(maxWidth: 400, minWidth: 320),
                    child: Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.tiktok,
                          color: blancoText,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(authProvider.user!.tiktok, style: const TextStyle(color: blancoText))
                      ],
                    )),
                const SizedBox(
                  height: 15,
                ),
                CustomButton(
                  text: appLocal.actRrssBtn,
                  width: 215,
                  onPress: () {
                    final dialog = AlertDialog(
                      backgroundColor: bgColor,
                      actions: [
                        CustomButton(
                          text: appLocal.actualizarBtn,
                          onPress: () {
                            usersProvider.updateUser(
                                uid: authProvider.user!.uid,
                                nombre: nombreModal,
                                apellido: apellidoModal,
                                correo: correoModal,
                                me: meModal,
                                telf: telfModal,
                                facebook: facebookModal,
                                instagram: instagramModal,
                                tiktok: tiktokModal,
                                pass: claveModal,
                                rol: 'USER_ROLE');
                            setState(() {});
                            Navigator.pop(context);
                          },
                          width: 100,
                          color: Colors.green,
                        ),
                        CustomButton(
                            text: appLocal.cancelarBtn,
                            onPress: () {
                              Navigator.pop(context);
                            },
                            width: 100,
                            color: Colors.red)
                      ],
                      content: Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: 240,
                        width: 320,
                        child: Column(
                          children: [
                            Text(
                              appLocal.actRrssBtn,
                              style: DashboardLabel.h2,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              constraints: const BoxConstraints(maxWidth: 500, minWidth: 360),
                              child: TextFormField(
                                cursorColor: azulText,
                                initialValue: authProvider.user!.facebook,
                                onChanged: (value) {
                                  facebookModal = value;
                                  authProvider.user!.facebook = value;
                                },
                                style: DashboardLabel.paragraph,
                                decoration: buildInputDecoration(icon: FontAwesomeIcons.facebook, label: 'Facebook'),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              constraints: const BoxConstraints(maxWidth: 500, minWidth: 360),
                              child: TextFormField(
                                cursorColor: azulText,
                                initialValue: authProvider.user!.instagram,
                                onChanged: (value) {
                                  instagramModal = value;
                                  authProvider.user!.instagram = value;
                                },
                                style: DashboardLabel.paragraph,
                                decoration: buildInputDecoration(icon: FontAwesomeIcons.instagram, label: 'Instagram'),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              constraints: const BoxConstraints(maxWidth: 500, minWidth: 360),
                              child: TextFormField(
                                cursorColor: azulText,
                                initialValue: authProvider.user!.tiktok,
                                onChanged: (value) {
                                  tiktokModal = value;
                                  authProvider.user!.tiktok = value.toString();
                                },
                                style: DashboardLabel.paragraph,
                                decoration: buildInputDecoration(icon: FontAwesomeIcons.tiktok, label: 'Tik Tok'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );

                    showDialog(
                      context: context,
                      builder: (context) => dialog,
                    );
                  },
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 60,
        ),
        const SizedBox(
          height: 80,
        )
      ],
    );
  }

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

      final img = await JpApi.editUserImg('/uploads/usuarios/$id', file.bytes!);
      if (context.mounted) {
        setState(() {
          Provider.of<AuthProvider>(context, listen: false).user!.img = img.toString();
        });
      }
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

  InputDecoration buildInputDecoration({required String label, required IconData icon, IconData? suffIcon, Function? onPrs}) => InputDecoration(
      fillColor: blancoText.withOpacity(0.03),
      filled: true,
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: azulText),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: azulText),
      ),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: azulText.withOpacity(0.3))),
      labelText: label,
      labelStyle: GoogleFonts.roboto(color: blancoText, fontSize: 14),
      prefixIcon: Icon(icon, color: azulText.withOpacity(0.3)),
      suffixIconColor: azulText.withOpacity(0.3));
}
