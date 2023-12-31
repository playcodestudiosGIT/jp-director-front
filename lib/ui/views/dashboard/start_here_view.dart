import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jp_director/generated/l10n.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';
import 'package:jp_director/ui/shared/labels/title_label.dart';
import 'package:jp_director/ui/shared/widgets/top_area_back.dart';

import '../../../constant.dart';
import '../../../providers/export_all_providers.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import '../../shared/botones/boton_icon_redondo.dart';
import '../../shared/botones/custom_button.dart';

class StartHereView extends StatelessWidget {
  const StartHereView({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final appLocal = AppLocalizations.of(context);
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            alignment: Alignment.topCenter,
            constraints: const BoxConstraints(maxWidth: 800),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TopAreaBack(
                    onPress: () => NavigatorService.navigateTo(Flurorouter.clienteMisCursosDash),
                  ),
                  const SizedBox(height: 30),
                  const TitleLabel(texto: 'Comienza aquí'),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('"${appLocal.hola} ${authProvider.user!.nombre} ${authProvider.user!.apellido}', style: DashboardLabel.h1),
                        const SizedBox(height: 15),
                        Text(
                            appLocal.bienvenidoAlosProg,
                            style: DashboardLabel.paragraph),
                        const SizedBox(height: 15),
                        Text(appLocal.teExplicamos, style: DashboardLabel.paragraph),
                        const SizedBox(height: 30),
                        Wrap(
                          children: [
                            SizedBox(
                              width: 315,
                              height: 100,
                              child: Center(
                                child: Text(
                                  appLocal.cadaCursoCuenta,
                                  style: DashboardLabel.mini,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                                width: 315,
                                height: 100,
                                child: Center(
                                  child: CustomButton(
                                    text: appLocal.comentariosBtn,
                                    onPress: () {},
                                    width: 160,
                                  ),
                                )),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Wrap(
                          children: [
                            SizedBox(
                              width: 315,
                              height: 100,
                              child: Center(
                                child: Text(
                                  appLocal.podrasDescargar,
                                  style: DashboardLabel.mini,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                                width: 315,
                                height: 100,
                                child: Center(
                                    child: Row(
                                  children: [
                                    CustomButton(
                                      text: appLocal.verMaterialBtn,
                                      onPress: () {},
                                      width: 200,
                                      icon: Icons.download_outlined,
                                    ),
                                    const SizedBox(width: 15),
                                    BotonRedondoIcono(
                                      fillColor: azulText,
                                      iconColor: bgColor,
                                      icon: Icons.file_download,
                                      onTap: () {},
                                    ),
                                  ],
                                ))),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Wrap(
                          children: [
                            SizedBox(
                              width: 315,
                              height: 100,
                              child: Center(
                                child: Text(
                                  appLocal.unaVezFinalices,
                                  style: DashboardLabel.mini,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                                width: 315,
                                height: 100,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      TextButton(
                                          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(blancoText.withOpacity(0.1))),
                                          onPressed: null,
                                          child: Text(
                                            appLocal.certificadoBtn,
                                            style: DashboardLabel.paragraph.copyWith(color: azulText),
                                          )),
                                      const SizedBox(width: 10),
                                      Stack(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(2),
                                            width: 30,
                                            height: 30,
                                            child: CircularProgressIndicator(
                                              value: 100,

                                              color: Colors.green,
                                              backgroundColor: Colors.white.withOpacity(0.3),

                                              // valueColor: ,
                                            ),
                                          ),
                                          const Positioned(
                                              top: 8,
                                              left: 7,
                                              child: Icon(
                                                Icons.check,
                                                color: Colors.green,
                                                size: 20,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Wrap(
                          children: [
                            SizedBox(
                              width: 315,
                              height: 100,
                              child: Center(
                                child: RichText(
                                  text: TextSpan(style: DashboardLabel.mini, children: [
                                    TextSpan(text: appLocal.siTienesAlgunaDuda),
                                    TextSpan(
                                        text: '${appLocal.centroSoporte} ',
                                        style: DashboardLabel.mini.copyWith(color: azulText, fontStyle: FontStyle.italic),
                                        recognizer: TapGestureRecognizer()..onTap = () => NavigatorService.navigateTo('/support')),
                                    TextSpan(text: appLocal.dondeTeBrindaremos),
                                  ]),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const SizedBox(
                                width: 315,
                                height: 100,
                                child: Center(
                                    child: Icon(
                                  Icons.support_agent,
                                  color: azulText,
                                  size: 60,
                                ))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
