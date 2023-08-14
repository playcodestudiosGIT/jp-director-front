import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/ui/shared/botones/botonverde.dart';
import 'package:jpdirector_frontend/ui/shared/labels/dashboard_label.dart';

import '../../../constant.dart';
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
                        'ASESORIA 1:1',
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
                          'COMPLETAMENTE PERSONALIZADO'.toUpperCase(),
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
                        'En una videollamada de 1 hora conversaremos de:\nCampañas, Presupuestos, Estrategias, Problemas Actuales, Inhabilitaciones y todo lo que quieras aclarar o aprender.',
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
                        'Resolvamos esto',
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
              BotonVerde(text: 'Quiero mi Asesoría', onPressed: ()=> NavigatorService.navigateTo(Flurorouter.asesoriaRoute), width: 200)
            ],
          ),
        ));
  }
}

