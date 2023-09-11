import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:jp_director/services/notificacion_service.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';
import 'package:jp_director/ui/shared/labels/inputs_decorations.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../providers/auth_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import '../../shared/botones/custom_button.dart';
import '../../shared/widgets/politicas_footer.dart';

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
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
                                            Text(appLocal.recuperarPass, style: DashboardLabel.azulTextGigant),
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
                                              style: DashboardLabel.h4,
                                              decoration:
                                                  InputDecor.formFieldInputDecoration(label: appLocal.correoTextFiel, icon: Icons.email_outlined),
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
                                                      NavigatorService.navigateTo(Flurorouter.loginRoute);
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
                            const PoliticasFooter(),
                            const SizedBox(
                              height: 100,
                            ),
                          ],
                        ),
                      ],
                    ),
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
