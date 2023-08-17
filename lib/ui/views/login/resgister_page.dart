import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../providers/forms/register_form_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import '../../shared/widgets/forms/register_form.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final wScreen = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (_) => RegisterFormProvider(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [

              // const Positioned(top: 0, left: -500, child: SizedBox(width: 1100, child: Image(image: circulo))),
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
                            const SizedBox(
                              height: 80,
                            ),
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Container(
                                  decoration: BoxDecoration(color: const Color(0xff021E36), borderRadius: BorderRadius.circular(80)),
                                  width: 340,
                                  child: const RegisterForm()),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Text(
                                  '¿Ya tienes cuenta?',
                                  style: GoogleFonts.roboto(fontSize: 14, color: blancoText, fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                TextButton(
                                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(blancoText.withOpacity(0.1))),
                                  onPressed: () {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage()));
                                  }, // Navigate to register page
                                  child: Text(
                                    'Inicia sesión aquí',
                                    style: GoogleFonts.roboto(fontSize: 14, color: azulText, fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ],
                            ),
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
      ),
    );
  }
}

