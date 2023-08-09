import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/router/router.dart';
import 'package:jpdirector_frontend/ui/shared/botones/botonverde.dart';

import '../../../constant.dart';
import '../../../services/navigator_service.dart';
import '../../shared/labels/dashboard_label.dart';

class ConferenceView extends StatelessWidget {
  const ConferenceView({super.key});

  @override
  Widget build(BuildContext context) {
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'CONFERENCIAS',
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
                          height: 20,
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Contrátame para exponer la importancia de publicidad online enfocada en el rubro que desees Seguros, Abogados, Real Estate, Médicos, Salones de Belleza, Coaching, Restaurantes y todos los negocios o emprendimientos que necesiten conocer ejemplos reales para hacer publicidad.',
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: blancoText.withOpacity(0.5),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                BotonVerde(text: 'Agendar', onPressed: ()=> NavigatorService.navigateTo(Flurorouter.conferenciasRoute), width: 100)
              ],
            ),
          )),
    );
  }
}