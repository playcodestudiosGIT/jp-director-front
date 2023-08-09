import 'package:animate_do/animate_do.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/services/notificacion_service.dart';
import 'package:jpdirector_frontend/ui/shared/labels/dashboard_label.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
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
    final wScreen = MediaQuery.of(context).size.width;
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
          Center(
            child: PageView(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 120,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (wScreen > 980) const Image(image: logoGrande),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              decoration: BoxDecoration(color: const Color(0xff021E36), borderRadius: BorderRadius.circular(80)),
                              width: 340,
                              // height: 550,
                              child: Container(
                                padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
                                child: Column(
                                  children: [
                                    if (isOk)
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 50),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Se ha enviado un correo electrónico con instrucciones, porfavor verifica tu correo electrónico',
                                              style: DashboardLabel.paragraph,
                                            ),
                                            const SizedBox(height: 15),
                                            CustomButton(
                                              width: 140,
                                              text: 'Ir al Login',
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
                                          Text(
                                            'Ingresa tu dirección de correo',
                                            style: DashboardLabel.h3,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          TextFormField(
                                            validator: (value) => (EmailValidator.validate(value.toString())) ? null : 'Ingrese su correo',
                                            style: GoogleFonts.roboto(color: blancoText, fontSize: 14),
                                            decoration: buildInputDecoration(label: 'Correo Electrónico', icon: Icons.email_outlined),
                                            onChanged: (value) => email = value,
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          CustomButton(
                                            width: 140,
                                            text: 'Enviar',
                                            onPress: () async {
                                              final ok = await Provider.of<AuthProvider>(context, listen: false).sendResetPass(email: email);

                                              if (ok) {
                                                setState(() {
                                                  isOk = true;
                                                });
                                              } else {
                                                NotifServ.showSnackbarError('El correo no existe', Colors.red);
                                              }
                                            },
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                            'recibiras un correo electrónico con instrucciones para reestablecer tu contraseña',
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
                  const Spacer(),
                  Center(
                    child: Container(
                        padding: const EdgeInsets.all(10),
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
                              onTap: () => NavigatorService.navigateTo(Flurorouter.tycRoute),
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
                              onTap: () => NavigatorService.navigateTo(Flurorouter.pdpRoute),
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
            ]),
          ),
        ],
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
