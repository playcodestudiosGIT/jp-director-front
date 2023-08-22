import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/ui/shared/botones/botonverde.dart';
import 'package:jpdirector_frontend/ui/shared/labels/dashboard_label.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';


class AsesoriaView extends StatelessWidget {
  const AsesoriaView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AsesoriaMain();
  }
}

class AsesoriaMain extends StatelessWidget {
  const AsesoriaMain({super.key});

  @override
  Widget build(BuildContext context) {
    
    final appLocal = AppLocalizations.of(context);
    double wScreen = MediaQuery.of(context).size.width;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        constraints: const BoxConstraints(maxWidth: 800),
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Wrap(
                alignment: WrapAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        appLocal.asesoria11,
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
                        height: 30,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        child: Text(
                          appLocal.completamentePers,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: blancoText,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        appLocal.enUnaVideollamada,
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: blancoText.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        appLocal.resolvamosEsto,
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
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
              BotonVerde(text: appLocal.quieroMiAsesoriaBtn, onPressed: ()=> NavigatorService.navigateTo(Flurorouter.asesoriaRoute), width: 200)
            ],
          ),
        ));
  }
}

