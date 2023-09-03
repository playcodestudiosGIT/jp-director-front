import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:jp_director/providers/auth_provider.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import '../../shared/botones/custom_button.dart';
import '../../shared/labels/inputs_decorations.dart';

class NewPassword extends StatefulWidget {
  final String token;
  const NewPassword({super.key, required this.token});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  bool isOk = false;
  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final GlobalKey<FormState> keyFormPass = GlobalKey();
    final wScreen = MediaQuery.of(context).size.width;
    String passw1 = '';
    String passw2 = '';
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
                                child: Form(
                                  key: keyFormPass,
                                  child: Column(
                                    children: [
                                      if (isOk)
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 50),
                                          child: Column(
                                            children: [
                                              Text(
                                                appLocal.laContrasenaSeHaReest,
                                                style: DashboardLabel.paragraph,
                                              ),
                                              const SizedBox(height: 15),
                                              CustomButton(
                                                width: 140,
                                                text: appLocal.irAlLogin,
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
                                              appLocal.ingresaNewPass,
                                              style: DashboardLabel.h3,
                                            ),
                                            const SizedBox(height: 15),
                                            TextFormField(
                                              cursorColor: azulText,
                                              obscureText: true,
                                              validator: (value) => (passw1 == passw2) ? null : appLocal.passNoCoinciden,
                                              onChanged: (value) => passw1 = value,
                                              style: DashboardLabel.paragraph,
                                              decoration: InputDecor.formFieldInputDecoration(label: appLocal.ingresaNewPass, icon: Icons.email_outlined),
                                            ),
                                            const SizedBox(height: 15),
                                            TextFormField(
                                              cursorColor: azulText,
                                              obscureText: true,
                                              validator: (value) => (passw1 == passw2) ? null : appLocal.passNoCoinciden,
                                              onChanged: (value) => passw2 = value,
                                              style: DashboardLabel.h4,
                                              decoration: InputDecor.formFieldInputDecoration(label: appLocal.repitaContrasenaTextFiel, icon: Icons.email_outlined),
                                            ),
                                            const SizedBox(height: 30),
                                            CustomButton(
                                              width: 140,
                                              text: appLocal.enviarBtn,
                                              onPress: () async {
                                                if (keyFormPass.currentState!.validate()) {
                                                  final ok = await Provider.of<AuthProvider>(context, listen: false)
                                                      .resetPass(token: widget.token, newPass: passw1);

                                                  if (ok) {
                                                    setState(() {
                                                      isOk = true;
                                                    });
                                                  }
                                                }
                                              },
                                            ),
                                            const SizedBox(height: 60)
                                          ],
                                        ),
                                    ],
                                  ),
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
            ]),
          ),
        ],
      ),
    );
  }
}


