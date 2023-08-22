import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constant.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import '../../shared/botones/custom_button.dart';
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
                  Center(
                    child: Container(
                        constraints: const BoxConstraints(maxWidth: 580),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            const Text(
                              'Al iniciar sesión aceptas nuestros ',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: blancoText, fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Text(
                                'Términos de Uso ',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: azulText, fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ),
                            const Text(
                              'y reconoces que has leído ',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: blancoText, fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            const Text(
                              'nuestra ',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: blancoText, fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Text(
                                'Política de Privacidad.',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: azulText, fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        )),
                  )
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
    GlobalKey<FormState> recoveryKey = GlobalKey<FormState>();
    String email = '';
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
      child: Form(
        key: recoveryKey,
        child: Column(
          children: [
            Text(
              'RECUPERAR CONTRASEÑA',
              style: GoogleFonts.roboto(fontSize: 32, color: azulText, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              cursorColor: azulText,
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => (EmailValidator.validate(value.toString())) ? null : 'Ingrese su correo',
              initialValue: email,
              onChanged: (value) => email = value,
              style: GoogleFonts.roboto(color: blancoText, fontSize: 14),
              decoration: buildInputDecoration(icon: Icons.email, label: 'Correo Electrónico'),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Recibiras un correo electronico con un link para poder recuperar tu contraseña',
              style: GoogleFonts.roboto(fontSize: 14, color: blancoText, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              width: 80,
              text: 'ENVIAR',
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
                  'Ir a',
                  style: GoogleFonts.roboto(fontSize: 14, color: blancoText, fontWeight: FontWeight.w400),
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
                    'Iniciar Sesión',
                    style: GoogleFonts.roboto(fontSize: 14, color: azulText, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration({
    required String label,
    required IconData icon,
  }) =>
      InputDecoration(
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
      );
}
