import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/ui/shared/botones/botonverde.dart';


import '../../../constant.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import '../../shared/widgets/acordion.dart';

class MentoriaPage extends StatelessWidget {
  const MentoriaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Stack(
        children: [
          _MentoriaBody(),
          SizedBox(
            height: 200,
          )
        ],
      ),
    );
  }
}

class _MentoriaBody extends StatelessWidget {
  const _MentoriaBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double wScreen = MediaQuery.of(context).size.width;
    double hScreen = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        SizedBox(
            height: hScreen,
            width: wScreen,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: IconButton(
                        onPressed: () {
                          NavigatorService.navigateTo('/servicios');
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: azulText,
                          size: 30,
                        )),
                  ),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 880),
                        child: const LetrasMentoria(),
                      ),
                      // if (wScreen > 1300)
                        // Stack(
                        //   children: [
                        //     Positioned(
                        //       child: ConstrainedBox(
                        //         constraints: const BoxConstraints(maxWidth: 700),
                        //         child: const Image(
                        //           image: bgMentoria,
                        //           color: blancoText,
                        //           colorBlendMode: BlendMode.modulate,
                        //         ),
                        //       ),
                        //     ),
                        //     Positioned(
                        //       top: 500,
                        //       right: (wScreen > 1200) ? 230 : 0,
                        //       child: const Image(
                        //         image: adsCircle,
                        //         color: blancoText,
                        //         colorBlendMode: BlendMode.modulate,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        constraints: const BoxConstraints(minWidth: 300, maxWidth: 900),
                        child: const Column(
                          children: [
                            Acordeon(
                              title: '¿Qué veremos durante estos 3 meses?',
                              content:
                                  '-De nivel cero a 100 todos los factores y herramientas necesarias para tu estrategia de publicidad.\n\n-Toda la educación en Instagram - Facebook - Tik Tok para realizar campañas publicitarias rentables.\n\n-Estrategia y análisis de resultados como decisiones de optimización.',
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Acordeon(
                                title: 'Preguntas frecuentes',
                                content:
                                    '¿Debo tener un presupuesto alto para invertir en mis campañas?\nEsto es muy relativo y depende de tu producto o servicio, lo que si tienes que tener en cuenta es que como mínimo tengas \$1000 USD para poder hacer la mayor cantidad de pruebas y hagamos un buen análisis de resultados durante este tiempo.\n\nEntiendo gran parte pero quiero más detalles\nCómo este servicio es especializado, tendremos una videollamada de 20 minutos para saber si tu negocio está preparado y comprometido.\nEn la llamada te explicaré más a detalle todas tus dudas.\n\n¿Cuál es el precio de la mentoría intensiva?\nEl precio ronda entre los \$6000 -\$12.000 USD depende de múltiples factores que estaremos conversando en la video llamada.\n\nNo es una pregunta, quiero que seas mi mentor!\nCalma, primero conversemos y veamos si estás preparado y tienes los requisitos, si estás leyendo esto, ya tienes el primero: Ganas.'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

class LetrasMentoria extends StatelessWidget {
  const LetrasMentoria({super.key});

  @override
  Widget build(BuildContext context) {
    final wScreen = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'MENTORÍA INTENSIVA',
          style: GoogleFonts.roboto(fontSize: (wScreen < 600) ? 26 : 32, fontWeight: FontWeight.w900, color: blancoText),
        ),
        Container(
          width: 400,
          height: 5,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            bgColor,
            azulText,
            bgColor,
          ])),
        ),
        // if (wScreen < 1300)
          Stack(
            children: [
              Positioned(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700, minWidth: 300),
                  child: const Image(
                    image: bgMentoria,
                    width: 400,
                  ),
                ),
              ),
              const Positioned(
                top: 260,
                right: 150,
                child: Image(
                  image: adsCircle,
                  width: 100,
                ),
              ),
            ],
          ),
        if (wScreen > 1300)
          const SizedBox(
            height: 30,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Text(
            'Durante el primer mes, te enseñaré todo lo que sé y elaboraremos - lanzaremos en conjunto tu plan de publicidad donde aprenderás la forma correcta de crecer tu negocio.\n\nLos siguientes dos meses tendremos varias sesiones de análisis de resultados con el plan que desarrollamos, y progresivamente optimizaremos todas tus campañas.\n\nEntenderás como si estuvieras viendo un semáforo; avanzar o parar dependiendo del color que muestre.',
            style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w400, color: blancoText),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        BotonVerde(
          text: 'Estoy listo, comencemos.',
          onPressed: () => Navigator.pushNamed(context, Flurorouter.mentoriaFormRoute),
          width: 200,
        ),
        SizedBox(
          child: Image(
            image: baseGif,
            colorBlendMode: BlendMode.modulate,
            color: blancoText.withOpacity(0.4),
          ),
        ),
      ],
    );
  }
}
