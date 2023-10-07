import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../constant.dart';
import '../../../../generated/l10n.dart';
import '../../../../providers/forms/login_form_provider.dart';
import '../../../../providers/meta_event_provider.dart';
import '../../../../router/router.dart';
import '../../../../services/navigator_service.dart';
import '../../../views/login/resgister_page.dart';
import '../../botones/custom_login_button.dart';
import '../../labels/dashboard_label.dart';
import '../../labels/inputs_decorations.dart';

class LoginForm extends StatefulWidget {
  final bool isBuying;
  final String? cursoId;
  const LoginForm({Key? key, this.isBuying = true, this.cursoId = ''})
      : super(key: key);
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> keyLoginForm = GlobalKey<FormState>(debugLabel: 'login');

  @override
  void dispose() {
    if (keyLoginForm.currentState != null) keyLoginForm.currentState!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);

    final loginFormProvider = Provider.of<LoginFormProvider>(context);
    return Builder(
      builder: (context) {
        return Container(
          width: double.infinity,
          height: 520,
          padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
          child: Form(
            key: keyLoginForm,
            child: Column(
              children: [
                Text(
                  appLocal.iniciaSesion,
                  style: DashboardLabel.azulTextGigant,
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  initialValue: (loginFormProvider.remember)
                      ? loginFormProvider.email
                      : '',
                  cursorColor: azulText,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      (EmailValidator.validate(value.toString()))
                          ? null
                          : appLocal.ingreseSuCorreo,
                  onChanged: (value) => loginFormProvider.setEmail(value),
                  style: DashboardLabel.paragraph,
                  decoration: InputDecor.formFieldInputDecoration(
                      icon: Icons.email, label: appLocal.correoTextFiel),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  initialValue: (loginFormProvider.remember)
                      ? loginFormProvider.pass
                      : '',
                  cursorColor: azulText,
                  obscureText: loginFormProvider.obscureText,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value!.isEmpty) return appLocal.ingreseUnaPassValida;
                    if (value.length < 6)
                      return appLocal.laContraDebe6Caracteres;
                    return null;
                  },
                  onChanged: (value) => loginFormProvider.setPassword(value),
                  style: DashboardLabel.paragraph,
                  decoration: InputDecor.formFieldInputDecoration(
                      icon: Icons.password,
                      label: appLocal.contrasenaTextFiel,
                      suffIcon: Icons.remove_red_eye_outlined,
                      onPrs: () {}),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      appLocal.recuerdame,
                      style: DashboardLabel.mini,
                    ),
                    Checkbox(
                      activeColor: azulText,
                      side: const BorderSide(color: azulText),
                      checkColor: bgColor,
                      value: loginFormProvider.remember,
                      onChanged: (value) {
                        loginFormProvider.setRemember();
                      },
                    ),
                    const Spacer(),
                    TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                blancoText.withOpacity(0.1))),
                        onPressed: () => loginFormProvider.setObscure(),
                        child: (loginFormProvider.obscureText)
                            ? Icon(
                                FontAwesomeIcons.eyeSlash,
                                color: blancoText.withOpacity(0.4),
                                size: 18,
                              )
                            : const Icon(
                                FontAwesomeIcons.eye,
                                color: blancoText,
                                size: 18,
                              )),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                LoginButton(
                  width: 140,
                  text: appLocal.iniciaSesion,
                  onPress: () async {
                    final bool isValid = keyLoginForm.currentState!.validate();
                    loginFormProvider.validateForm(
                        context: context, isValid: isValid);
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
                        appLocal.eresNuevo,
                        style: DashboardLabel.paragraph,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                blancoText.withOpacity(0.1))),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()));
                        }, // Navigate to register page
                        child: Text(
                          appLocal.registrateAqui,
                          style: DashboardLabel.paragraph,
                        ),
                      ),
                    ],
                    if (widget.isBuying) ...[
                      Text(
                        appLocal.eresNuevo,
                        style: DashboardLabel.paragraph,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                blancoText.withOpacity(0.1))),
                        onPressed: (widget.cursoId != '')
                            ? () {
                                Navigator.pushReplacementNamed(context,
                                    '${Flurorouter.payNewUserRouteAlt}/${widget.cursoId}/register');
                              }
                            : () {
                                Navigator.pushReplacementNamed(
                                    context, Flurorouter.registerRoute);
                              }, // Navigate to register page
                        child: Text(
                          appLocal.registrateAqui,
                          style: DashboardLabel.paragraph.copyWith(
                              color: azulText, fontWeight: FontWeight.w800),
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
                        onTap: () => NavigatorService.navigateTo(
                            Flurorouter.resetPassRoute),
                        child: Text(
                          appLocal.olvideMiPass,
                          style: DashboardLabel.mini.copyWith(color: azulText),
                        )),
                  )
                ]),
                const SizedBox(
                  height: 45,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
