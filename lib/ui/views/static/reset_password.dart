import 'package:animate_do/animate_do.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/services/notificacion_service.dart';
import 'package:jpdirector_frontend/ui/shared/labels/dashboard_label.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../providers/auth_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import '../../shared/botones/custom_button.dart';

class ResetPass extends StatefulWidget {
  const ResetPass({super.key});

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  late String email;
  bool isOk = false;
  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final wScreen = MediaQuery.of(context).size.width;
    final hScreen = MediaQuery.of(context).size.height;
    
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color(0xFF00041C),
          ),
          Positioned(
              top: 0,
              left: -500,
              child: SizedBox(width: 1100, child: SlideInLeft(duration: const Duration(seconds: 10), child: const Image(image: circulo)))),
          SingleChildScrollView(
            child: SizedBox(
              width: wScreen,
              height: hScreen,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (wScreen > 980) const Image(image: logoGrande),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: 340,
                                  // height: 550,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 30),
                                    child: Column(
                                      children: [
                                        if (isOk)
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 50),
                                            child: Column(
                                              children: [
                                                Text(
                                                  appLocal.seHaEnviadoUnCorreo,
                                                  style: DashboardLabel.paragraph,
                                                ),
                                                const SizedBox(height: 15),
                                                CustomButton(
                                                  width: 140,
                                                  text: appLocal.irAlLoginBtn,
                                                  onPress: () async {
                                                    NavigatorService.navigateTo(Flurorouter.loginRoute);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        if (!isOk)
                                          Column(
                                            children: [
                                              if (wScreen <= 980) const SizedBox(width: 200, child: Image(image: logoGrande)),
                                              Text(
                                                'RECUPERAR TU CONTRASEÑA',
                                                style: GoogleFonts.roboto(fontSize: 32, color: azulText, fontWeight: FontWeight.w800),
                                              ),
                                              const SizedBox(height: 30),
                                              Text(
                                                appLocal.ingresaTuDirEmail,
                                                style: DashboardLabel.h3.copyWith(color: blancoText),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              TextFormField(
                                                cursorColor: azulText,
                                                validator: (value) => (EmailValidator.validate(value.toString())) ? null : appLocal.ingreseSuCorreo,
                                                style: GoogleFonts.roboto(color: blancoText, fontSize: 14),
                                                decoration: _buildInputDecoration(label: appLocal.correoTextFiel, icon: Icons.email_outlined),
                                                onChanged: (value) => email = value,
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              CustomButton(
                                                width: 140,
                                                text: appLocal.enviarBtn,
                                                onPress: () async {
                                                  final ok = await Provider.of<AuthProvider>(context, listen: false).sendResetPass(email: email);
                        
                                                  if (ok) {
                                                    setState(() {
                                                      isOk = true;
                                                    });
                                                  } else {
                                                    NotifServ.showSnackbarError(appLocal.elEmailNoExiste, Colors.red);
                                                  }
                                                },
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              Text(
                                                appLocal.recibirasInstruccionesPass,
                                                style: DashboardLabel.mini,
                                              ),
                                              const SizedBox(
                                                height: 60,
                                              )
                                            ],
                                          ),
                                      ],
                                    ),
                                  )),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          constraints: const BoxConstraints(maxWidth: 580),
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              Text(
                                appLocal.alIniciarSesion,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: blancoText, fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              InkWell(
                                onTap: () => NavigatorService.navigateTo(Flurorouter.tycRoute),
                                child: Text(
                                  appLocal.terminoDeUso,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: azulText, fontSize: 16, fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                appLocal.yReconocesQue,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: blancoText, fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                appLocal.nuestra,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: blancoText, fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              InkWell(
                                onTap: () => NavigatorService.navigateTo(Flurorouter.pdpRoute),
                                child: Text(
                                  appLocal.politicaDePrivacidad,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: azulText, fontSize: 16, fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

InputDecoration _buildInputDecoration({required String label, required IconData icon}) => InputDecoration(
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
