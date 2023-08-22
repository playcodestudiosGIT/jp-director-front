import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
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
    final appLocal = AppLocalizations.of(context);
    double wScreen = MediaQuery.of(context).size.width;
    double hScreen = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
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
                                    const SizedBox(height: 353, child: Image(image: logoGrande)),
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
                                    ),
                                  ],
                                ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (wScreen <= 980) const SizedBox(width: 200, child: Image(image: logoGrande)),
                                  const SizedBox(width: 340, child: LoginForm()),
                                  if (wScreen <= 980)
                                    Column(
                                      children: [
                                        Center(
                                          child: Container(
                                              padding: const EdgeInsets.all(10),
                                              constraints: const BoxConstraints(maxWidth: 400),
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
                                                      appLocal.politicasDeProivacidad,
                                                      textAlign: TextAlign.center,
                                                      style: const TextStyle(color: azulText, fontSize: 16, fontWeight: FontWeight.w400),
                                                    ),
                                                  ),
                                                ],
                                              )),
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
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
