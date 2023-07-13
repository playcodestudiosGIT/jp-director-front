import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../constant.dart';
import '../../../../providers/forms/login_form_provider.dart';
import '../../../../router/router.dart';
import '../../../../services/navigator_service.dart';
import '../../../views/login/resgister_page.dart';
import '../../botones/custom_login_button.dart';
import '../../labels/dashboard_label.dart';

class LoginForm extends StatefulWidget {
  final bool isBuying;
  final String? cursoId;
  const LoginForm({Key? key, this.isBuying = true, this.cursoId}) : super(key: key);
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  @override
  Widget build(BuildContext context) {
    final loginFormProvider = Provider.of<LoginFormProvider>(context);
    TextEditingController emailCtrl = TextEditingController(text: loginFormProvider.email);
    TextEditingController passCtrl = TextEditingController(text: loginFormProvider.pass);
    return Container(
      width: double.infinity,
      height: 500,
      padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
      child: Form(
        key: loginFormProvider.keyLoginForm,
        child: Column(
          children: [
            Text(
              'INICIA SESIÓN',
              style: GoogleFonts.roboto(fontSize: 32, color: azulText, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              // initialValue: loginFormProvider.email,
              controller: emailCtrl,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => (EmailValidator.validate(value.toString())) ? null : 'Ingrese su correo',
              onChanged: (value) => loginFormProvider.setEmail(value),
              style: GoogleFonts.roboto(color: blancoText, fontSize: 14),
              decoration: buildInputDecoration(icon: Icons.email, label: 'Correo Electrónico'),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              // initialValue: loginFormProvider.pass,
              controller: passCtrl,
              obscureText: loginFormProvider.obscureText,
              keyboardType: TextInputType.visiblePassword,
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) return 'Ingrese una contraseña valido';
                if (value.length < 6) return 'La contraseña debe contener mas de 6 caracteres';
                return null;
              },
              onChanged: (value) => loginFormProvider.setPassword(value),
              style: GoogleFonts.roboto(color: blancoText, fontSize: 14),
              decoration: buildInputDecoration(icon: Icons.password, label: 'Contraseña', suffIcon: Icons.remove_red_eye_outlined, onPrs: () {}),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Recuérdame',
                  style: GoogleFonts.roboto(color: blancoText, fontSize: 12),
                ),
                Checkbox(
                  activeColor: azulText,
                  side: const BorderSide(color: azulText),
                  checkColor: blancoText,
                  value: loginFormProvider.remember,
                  onChanged: (value) {
                    loginFormProvider.setRemember();
                  },
                ),
                const Spacer(),
                TextButton(
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(blancoText.withOpacity(0.1))),
                    onPressed: () => loginFormProvider.setObscure(),
                    child: (loginFormProvider.obscureText)
                        ? Icon(
                            FontAwesomeIcons.eyeSlash,
                            color: blancoText.withOpacity(0.4),
                            size: 14,
                          )
                        : const Icon(
                            FontAwesomeIcons.eye,
                            color: blancoText,
                            size: 14,
                          )),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            LoginButton(
              width: 140,
              text: 'INICIAR SESIÓN',
              onPress: () async {
                await loginFormProvider.validateForm(context);
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!widget.isBuying) ...[
                  Text(
                    '¿Eres Nuevo?',
                    style: GoogleFonts.roboto(fontSize: 14, color: blancoText, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  TextButton(
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(blancoText.withOpacity(0.1))),
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                    }, // Navigate to register page
                    child: Text(
                      'Registrate aquí',
                      style: GoogleFonts.roboto(fontSize: 14, color: azulText, fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
                if (widget.isBuying) ...[
                  Text(
                    '¿Eres Nuevo?',
                    style: GoogleFonts.roboto(fontSize: 14, color: blancoText, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  TextButton(
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(blancoText.withOpacity(0.1))),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '${Flurorouter.payNewUserRouteAlt}${widget.cursoId}?state=register');
                    }, // Navigate to register page
                    child: Text(
                      'Registrate aquí',
                      style: GoogleFonts.roboto(fontSize: 14, color: azulText, fontWeight: FontWeight.w800),
                    ),
                  )
                ]
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                    onTap: () => NavigatorService.navigateTo(Flurorouter.resetPassRoute),
                    child: Text(
                      'Olvide mi contraseña',
                      style: DashboardLabel.mini.copyWith(color: azulText),
                    )),
              )
            ]),
            const SizedBox(
              height: 60,
            )
          ],
        ),
      ),
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
