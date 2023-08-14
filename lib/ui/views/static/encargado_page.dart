import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/ui/shared/botones/botonverde.dart';
import 'package:jpdirector_frontend/ui/shared/labels/dashboard_label.dart';

import '../../../constant.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import '../../shared/widgets/acordion.dart';

class EncargadoPage extends StatelessWidget {
  const EncargadoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Stack(
        children: [
          _EncargadoBody(),
          SizedBox(
            height: 200,
          )
        ],
      ),
    );
  }
}

class _EncargadoBody extends StatelessWidget {
  const _EncargadoBody({Key? key}) : super(key: key);

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
                // mainAxisAlignment: MainAxisAlignment.center,
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
                        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 912),
                        child: const LetrasAsesoria(),
                      ),
                      // if (wScreen > 1200)
                      //   Stack(
                      //     children: [
                      //       Positioned(
                      //         child: ConstrainedBox(
                      //           constraints: const BoxConstraints(maxWidth: 700),
                      //           child: const Image(
                      //             image: bgEncargado,
                      //             color: blancoText,
                      //             colorBlendMode: BlendMode.modulate,
                      //           ),
                      //         ),
                      //       ),
                      //       const Positioned(
                      //         top: 100,
                      //         right: 100,
                      //         child: Image(
                      //           image: adsCircle,
                      //           width: 100,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
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
                          // \n\n
                          children: [
                            Acordeon(
                              title: 'Diseño de Estrategias',
                              content:
                                  'Desarrollaré las estrategias claras y precisas con tiempos definidos poniendo en prioridad a tus distintos clientes ideales con todo el estudio que se necesita para poder impactarlos de manera persuasiva. ',
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Acordeon(
                                title: '¿Configuración de Campañas',
                                content:
                                    'Todo lo técnico que se hace dentro de la plataforma para que las campañas estén en correcto funcionamiento según la estrategia establecida. '),
                            SizedBox(
                              height: 30,
                            ),
                            Acordeon(
                                title: 'Optimización',
                                content:
                                    'Una optimización eficaz, en español, quiere decir que analizaré los datos y luego de obtener los resultados tomaremos decisiones para mejorarlos según transcurra el tiempo y así el éxito sea continuo.'),
                            SizedBox(
                              height: 30,
                            ),
                            Acordeon(
                                title: '¿Por qué yo?',
                                content:
                                    'SELECTIVO Y SINCERO\nSer el encargado de tu marca requiere compromiso y responsabilidad, es por eso que antes de comenzar analizaré tu negocio con mucho detalle para concluir si cumples con todos los requerimientos para poder apoyarte.\n\nEn caso de ser un SÍ pondremos un plan de acción eficaz.\n\nEn caso de ser un NO te daré mi feedback sincero para referirte con el especialista o plan que tu negocio necesite.\n\nPRECIO SEGÚN TU MODELO DE NEGOCIO\nAlgo que me caracteriza es que reviso muy a detalle tu negocio antes de comenzar e incluso evaluando en conjunto contigo puedo saber si estás preparado para dar este paso.\n\nMi promesa es que cuando adquieras mi servicio sea un gran alivio y veas resultados.\n\nEXPERIENCIA Y RESULTADOS\nDesde la creación de la estrategia, copywriting, anuncios creativos, segmentación, funnels de conversión de tu web, manejo de presupuesto y análisis de resultados están dentro de mis capacidades para ocupar este puesto'),
                            SizedBox(
                              height: 30,
                            ),
                            Acordeon(
                                title: 'Preguntas frecuentes',
                                content:
                                    '¿Cuál es el costo promedio para que seas el encargado de la publicidad de mi negocio?\nEl precio comienza desde los \$4000 en adelante, depende de muchos factores y los objetivos que tengas como negocio es por eso que me tomo el tiempo de analizar previamente y saber si puedo asumir el proyecto.\n\n¿Veré resultados de inmediato?\nEsta pregunta es muy común, y esto depende de como está plasmada la estrategia, tu producto, precio y valor percibido por tu audiencia.\n\nLa respuesta correcta es que me encargaré de que impactes a tu público objetivo de una manera inteligente.\n\nUna vez rellene el formulario ¿Qué sucederá?\nEn el transcurso de  2 a 3 días me comunicaré contigo para darte todos los detalles y tendremos una reunión que durará 30 minutos para entender tus necesidades y números al 100%.'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    constraints: const BoxConstraints(maxHeight: 100, maxWidth: 980),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40, right: 20),
                      child: Text(
                        'Recuerda: Primero. conversaremos para hacer el checklist de tu negocio y analizar qué es lo que más necesitas en este momento.',
                        textAlign: TextAlign.center,
                        style: DashboardLabel.h4,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BotonVerde(
                    text: '¿Empezamos?',
                    onPressed: () => Navigator.pushNamed(context, Flurorouter.encargadoFormRoute),
                    width: 120,
                  ),
                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
            )),
      ],
    );
  }
}

class LetrasAsesoria extends StatelessWidget {
  const LetrasAsesoria({super.key});

  @override
  Widget build(BuildContext context) {
    double wScreen = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'SER EL ENCARGADO',
          style: GoogleFonts.roboto(fontSize: (wScreen < 600) ? 26 : 32, fontWeight: FontWeight.w900, color: blancoText),
        ),
        Container(
          width: 320,
          height: 5,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            bgColor,
            azulText,
            bgColor,
          ])),
        ),
        // if (wScreen < 1200)
          Stack(
            children: [
              Positioned(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: const Image(
                    image: bgEncargado,
                    width: 400,
                  ),
                ),
              ),
              const Positioned(
                top: 100,
                right: 40,
                child: Image(
                  image: adsCircle,
                  width: 100,
                ),
              ),
            ],
          ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'Este servicio está diseñado para ti, que estás buscando a la persona que se encargue de realizar la estrategia y manejo de publicidad de tu marca. Me enfocaré en el crecimiento, obtención de clientes potenciales de calidad y aumento de las ventas.',
            style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w400, color: blancoText),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          '¿Cómo?',
          style: GoogleFonts.roboto(fontSize: 36, fontWeight: FontWeight.w900, color: azulText),
        ),
        GestureDetector(
          onTap: () {},
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              alignment: Alignment.center,
              child: const Image(
                image: arrDown,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        BotonVerde(
          text: 'Estoy listo, comencemos.',
          onPressed: () => NavigatorService.navigateTo(Flurorouter.encargadoFormRoute),
          width: 200,
        ),
        Image(
          image: baseGif,
          colorBlendMode: BlendMode.modulate,
          color: blancoText.withOpacity(0.4),
        ),
      ],
    );
  }
}
