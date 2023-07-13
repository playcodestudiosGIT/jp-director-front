import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import '../../shared/widgets/forms/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double wScreen = MediaQuery.of(context).size.width;
    double hScreen = MediaQuery.of(context).size.height;

    return Scaffold(
        body: ListView(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            const Positioned(top: 0, left: -500, child: SizedBox(width: 1100, child: Image(image: circulo))),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 200,
                ),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      constraints: BoxConstraints(maxWidth: 1200, minHeight: hScreen - 200),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (wScreen > 980)
                            Column(
                              children: [
                                const Image(image: logoGrande),
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
                                ),
                              ],
                            ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  decoration: BoxDecoration(color: const Color(0xff021E36), borderRadius: BorderRadius.circular(80)),
                                  width: 340,
                                  // height: 550,
                                  child: const LoginForm()),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ));
  }
}
