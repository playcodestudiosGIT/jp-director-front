import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:jp_director/ui/shared/politicas_footer.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import '../../shared/botones/custom_button.dart';
import '../../shared/labels/dashboard_label.dart';
import '../../shared/labels/inputs_decorations.dart';
import 'login_page.dart';

class RecoverypassPage extends StatefulWidget {
  const RecoverypassPage({super.key});

  @override
  State<RecoverypassPage> createState() => _RecoverypassPageState();
}

class _RecoverypassPageState extends State<RecoverypassPage> {
  @override
  Widget build(BuildContext context) {
    final wScreen = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: const Color(0xFF00041C),
            ),
            const Positioned(top: 0, left: -500, child: SizedBox(width: 1100, child: Image(image: circulo))),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (wScreen > 980) const Image(image: logoGrande),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              decoration: BoxDecoration(color: const Color(0xff021E36), borderRadius: BorderRadius.circular(80)),
                              width: 380,
                              height: 550,
                              child: const RecoverypassForm()),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const PoliticasFooter()
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              height: 60,
              color: const Color(0xFF00041C),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, Flurorouter.homeRoute);
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: 345,
                    child: const Image(
                      image: logoJp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecoverypassForm extends StatefulWidget {
  const RecoverypassForm({super.key});

  @override
  State<RecoverypassForm> createState() => _RecoverypassFormState();
}

class _RecoverypassFormState extends State<RecoverypassForm> {
  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    GlobalKey<FormState> recoveryKey = GlobalKey<FormState>();
    String email = '';
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
      child: Form(
        key: recoveryKey,
        child: Column(
          children: [
            Text(
              appLocal.recuperarPass,
              style: DashboardLabel.semiGigant.copyWith(color: azulText, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              cursorColor: azulText,
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => (EmailValidator.validate(value.toString())) ? null : appLocal.correoTextFiel,
              initialValue: email,
              onChanged: (value) => email = value,
              style: DashboardLabel.h4,
              decoration: InputDecor.formFieldInputDecoration(icon: Icons.email, label: appLocal.correoTextFiel),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              appLocal.recibirasInstruccionesPass,
              style: DashboardLabel.h4
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              width: 80,
              text: appLocal.enviarBtn,
              onPress: () {
                if (recoveryKey.currentState!.validate()) {
                  // recoverypass
                  return NavigatorService.navigateTo(Flurorouter.loginRoute);
                } else {
                  return () {};
                }
              },
            ),
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  appLocal.irAlLogin,
                  style: DashboardLabel.h4,
                ),
                const SizedBox(
                  width: 4,
                ),
                TextButton(
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(blancoText.withOpacity(0.1))),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                  }, // Navigate to register page
                  child: Text(
                    appLocal.iniciaSesion,
                    style: DashboardLabel.h4.copyWith(color: azulText, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
