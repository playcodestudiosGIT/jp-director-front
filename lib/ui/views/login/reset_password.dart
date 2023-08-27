import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/services/notificacion_service.dart';
import 'package:jpdirector_frontend/ui/shared/labels/dashboard_label.dart';
import 'package:jpdirector_frontend/ui/shared/politicas_footer.dart';
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
      backgroundColor: Colors.transparent,
      body: Container(
        alignment: Alignment.center,
        constraints: const BoxConstraints(maxWidth: 1200),
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: wScreen,
                height: hScreen,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (wScreen > 980) const Image(image: logoGrande),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: 315,
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
                                              appLocal.recuperarPass,
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
                                              height: 30,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                MouseRegion(
                                                  cursor: SystemMouseCursors.click,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      NavigatorService.navigateTo(Flurorouter.homeRoute);
                                                    },
                                                    child: Text(
                                                      appLocal.irAlLogin,
                                                      style: DashboardLabel.mini.copyWith(color: azulText),
                                                    ),
                                                  ),
                                                ),
                                              ],
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
                    const Spacer(),
                    const PoliticasFooter()
                  ],
                ),
              ),
            ],
          ),
        ),
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
