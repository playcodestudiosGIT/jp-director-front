import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:jp_director/providers/users_provider.dart';
import 'package:jp_director/router/router.dart';
import 'package:jp_director/services/navigator_service.dart';
import 'package:jp_director/ui/shared/botones/custom_button.dart';
import 'package:jp_director/ui/shared/labels/title_label.dart';
import 'package:jp_director/ui/shared/widgets/top_area_back.dart';

import 'package:provider/provider.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../api/jp_api.dart';
import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../providers/auth_provider.dart';
import '../../../services/notificacion_service.dart';
import '../../shared/labels/dashboard_label.dart';
import '../../shared/labels/inputs_decorations.dart';

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
  late String correoModal;
  late String telfModal;
  late String meModal;
  late String claveModal;
  late String facebookModal;
  late String instagramModal;
  late String tiktokModal;

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
    final hSize = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: hSize,
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              TopAreaBack(onPress: () => NavigatorService.navigateTo(Flurorouter.clienteMisCursosDash)),
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
                    width: 315,
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Text(
                          '${authProvider.user!.nombre} ${authProvider.user!.apellido}',
                          textAlign: TextAlign.start,
                          style: DashboardLabel.azulTextH2.copyWith(color: blancoText),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.email_outlined, color: Colors.white.withOpacity(0.3)),
                            const SizedBox(width: 8),
                            Text(
                              authProvider.user!.correo,
                              textAlign: TextAlign.start,
                              style: DashboardLabel.paragraph,
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
                              style: DashboardLabel.paragraph,
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
                    width: 280,
                    onPress: () async {
                      final dialog = AlertDialog(
                        backgroundColor: bgColor,
                        content: Container(
                          width: double.infinity,
                          constraints: const BoxConstraints(minWidth: 360),
                          color: Colors.transparent,
                          height: 480,
                          child: Column(
                            children: [
                              // if (size.width < 575) const SizedBox(height: 80),
                              FittedBox(
                                child: Text(
                                  appLocal.actInfo,
                                  style: DashboardLabel.h2,
                                ),
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
                                  style: DashboardLabel.h4,
                                  decoration:
                                      InputDecor.formFieldInputDecoration(icon: FontAwesomeIcons.userAstronaut, label: appLocal.nombreTextField),
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
                                  style: DashboardLabel.h4,
                                  decoration: InputDecor.formFieldInputDecoration(icon: FontAwesomeIcons.idCard, label: appLocal.apellidoTextFiel),
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
                                  style: DashboardLabel.h4,
                                  decoration: InputDecor.formFieldInputDecoration(icon: FontAwesomeIcons.phone, label: appLocal.telefonoForm),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                constraints: const BoxConstraints(maxWidth: 500, minWidth: 360),
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (value) => (EmailValidator.validate(value.toString())) ? null : appLocal.ingreseSuCorreo,
                                  cursorColor: azulText,
                                  keyboardType: TextInputType.emailAddress,
                                  initialValue: authProvider.user!.correo,
                                  onChanged: (value) {
                                    correoModal = value;
                                    authProvider.user!.correo = value;
                                  },
                                  style: DashboardLabel.h4,
                                  decoration: InputDecor.formFieldInputDecoration(icon: FontAwesomeIcons.addressCard, label: appLocal.correoTextFiel),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                constraints: const BoxConstraints(maxWidth: 500, minWidth: 360),
                                child: TextFormField(
                                  cursorColor: azulText,
                                  maxLines: 2,
                                  initialValue: authProvider.user!.me,
                                  onChanged: (value) {
                                    meModal = value;
                                    authProvider.user!.me = value;
                                  },
                                  style: DashboardLabel.h4,
                                  decoration: InputDecor.formFieldInputDecoration(icon: FontAwesomeIcons.circleInfo, label: appLocal.sobreMi),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
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
                                    width: 110,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(width: 10),
                                  CustomButton(
                                    text: appLocal.cancelarBtn,
                                    onPress: () {
                                      Navigator.pop(context, false);
                                    },
                                    width: 100,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );

                      await showDialog(
                        context: context,
                        builder: (context) => dialog,
                      );

                      setState(() {});
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
                            content: Container(
                              margin: const EdgeInsets.only(left: 10),
                              height: 320,
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
                                      decoration: InputDecor.formFieldInputDecoration(icon: FontAwesomeIcons.facebook, label: 'Facebook'),
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
                                      decoration: InputDecor.formFieldInputDecoration(icon: FontAwesomeIcons.instagram, label: 'Instagram'),
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
                                      decoration: InputDecor.formFieldInputDecoration(icon: FontAwesomeIcons.tiktok, label: 'Tik Tok'),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
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
                                        width: 120,
                                        color: Colors.green,
                                      ),
                                      const SizedBox(width: 10),
                                      CustomButton(
                                          text: appLocal.cancelarBtn,
                                          onPress: () {
                                            Navigator.pop(context);
                                          },
                                          width: 100,
                                          color: Colors.red)
                                    ],
                                  )
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
          ),
        ),
      ],
    );
  }

  pickImage(BuildContext context, String id) async {
    final appLocal = AppLocalizations.of(context);
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;

      if (file.extension!.toLowerCase() != 'jpg' && file.extension!.toLowerCase() != 'jpeg' && file.extension!.toLowerCase() != 'png') {
        return alertaDeDialogo(title: appLocal.extensionInvalida, dubtitle: appLocal.laExtensionDebe, textButton: 'OK');
      }
      if (file.size > 3000000) {
        return alertaDeDialogo(title: appLocal.tamanoInvalido, dubtitle: appLocal.debePesarMenos, textButton: 'OK');
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
          child: Container(
              padding: const EdgeInsets.all(8),
              color: bgColor,
              width: 300,
              height: 300,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(title, style: DashboardLabel.h4),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    dubtitle,
                    style: DashboardLabel.paragraph,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [ElevatedButton(onPressed: () => Navigator.pop(context), child: Text(textButton))],
                  )
                ],
              )))),
    );
  }
}
