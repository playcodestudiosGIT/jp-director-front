import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:jpdirector_frontend/ui/shared/labels/dashboard_label.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../providers/auth_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import '../../shared/botones/custom_button.dart';

class VerifyUserPage extends StatefulWidget {
  final String confirmCode;
  const VerifyUserPage({super.key, required this.confirmCode});

  @override
  State<VerifyUserPage> createState() => _VerifyUserPageState();
}

class _VerifyUserPageState extends State<VerifyUserPage> {
  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final wScreen = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: Provider.of<AuthProvider>(context, listen: false).confirmEmail(token: widget.confirmCode),
      builder: (context, snapshot) {
       
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
                                        if(snapshot.hasData && snapshot.data!)
                                        Text(
                                          appLocal.graciasPorConfirmar.toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: DashboardLabel.gigant.copyWith(color: azulText, fontWeight: FontWeight.bold),
                                        ),
                                        if(snapshot.hasData && !snapshot.data!)
                                        Text(
                                          appLocal.enlaceInvalido.toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: DashboardLabel.gigant.copyWith(color: Colors.red, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        CustomButton(
                                          width: 140,
                                          text: appLocal.irAlLogin,
                                          onPress: () {
                                            NavigatorService.navigateTo(Flurorouter.loginRoute);
                                          },
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        const SizedBox(
                                          height: 60,
                                        )
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
      },
    );
  }
}
