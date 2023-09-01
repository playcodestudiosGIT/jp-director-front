import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jp_director/ui/shared/botones/botonverde.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import '../../shared/labels/dashboard_label.dart';

class EncargadoView extends StatelessWidget {
  const EncargadoView({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    double wScreen = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8.0),
      child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          width: double.infinity,
          height: 500,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          appLocal.serElEncargado,
                          style: (wScreen < 550) ? DashboardLabel.h1 : DashboardLabel.gigant,
                        ),
                        Container(
                          width: 300,
                          height: 5,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(colors: [
                            bgColor,
                            azulText,
                            bgColor,
                          ])),
                        ),
                        const SizedBox(
                          height: 25,
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          appLocal.soyElResp,
                          textAlign: TextAlign.start,
                          style: DashboardLabel.h4
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          appLocal.estasEnElMomento,
                          style: DashboardLabel.h4.copyWith(
                            color: blancoText.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          appLocal.cuentaConmigo,
                          style: DashboardLabel.h4.copyWith(
                            color: blancoText.withOpacity(0.5),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                BotonVerde(text: appLocal.agendarLlamadaBtn, onPressed: () => NavigatorService.navigateTo(Flurorouter.encargadoRoute), width: 200)
              ],
            ),
          )),
    );
  }
}
