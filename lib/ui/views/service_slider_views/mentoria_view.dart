import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/ui/shared/botones/botonverde.dart';

import '../../../constant.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import '../../shared/labels/dashboard_label.dart';

class MentoriaView extends StatelessWidget {
  const MentoriaView({super.key});

  @override
  Widget build(BuildContext context) {
    double wScreen = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
                      children: [
                        Text(
                          'MENTORÍA INTENSIVA',
                          style: (wScreen < 550) ? DashboardLabel.h1 : DashboardLabel.gigant,
                        ),
                        Container(
                          width: 360,
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
                        FittedBox(
                          child: Text(
                            'INTELIGENTE INVERSIÓN'.toUpperCase(),
                            textAlign: TextAlign.start,
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: blancoText,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Tener un mentor acelera drásticamente el éxito de tu negocio. Durante 3 meses estaré contigo mano a mano elaborando tu plan de publicidad y enseñándote cómo hacerlo por ti mismo.',
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
                  height: 30,
                ),
                BotonVerde(
                  width: 200,
                  text: 'Mas Información',
                  onPressed: () => NavigatorService.navigateTo(Flurorouter.mentoriaRoute),
                ),
                
              ],
            ),
          )),
    );
  }
}
