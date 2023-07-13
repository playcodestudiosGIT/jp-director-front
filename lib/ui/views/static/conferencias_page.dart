import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/ui/shared/botones/botonverde.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../providers/auth_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import '../../shared/widgets/acordion.dart';

class ConferenciasPage extends StatelessWidget {
  const ConferenciasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(color: bgColor),
          const _MentoriaBody(),
          const SizedBox(
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
    final authProvider = Provider.of<AuthProvider>(context);
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
                    alignment: Alignment.centerLeft,
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: Padding(
                      padding: (authProvider.authStatus == AuthStatus.authenticated)
                          ? const EdgeInsets.only(left: 40, top: 17)
                          : const EdgeInsets.only(left: 0, top: 0),
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
                  ),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: const LetrasConferencias(),
                      ),
                      if (wScreen > 1200)
                        Container(
                          child: Stack(
                            children: [
                              Positioned(
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(maxWidth: 600),
                                  child: const Image(
                                    image: bgConferencia,
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 460,
                                right: (wScreen > 1200) ? 250 : 250,
                                child: const Image(
                                  image: adsCircle,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    color: bgColor,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        constraints: const BoxConstraints(minWidth: 300, maxWidth: 900),
                        child: const Column(
                          children: [
                            Acordeon(
                              title: 'Publicidad Online',
                              content: 'La importancia de estar presentes y maneras de lograr el éxito con casos reales.',
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Acordeon(
                                title: 'Actualizaciones y rapidez de la tecnología',
                                content:
                                    'Leyendo esto seguro salió una actualización de alguna herramienta o una nueva funcionalidad es por eso que ese día hablaremos de lo actual del 2023.'),
                            SizedBox(
                              height: 30,
                            ),
                            Acordeon(
                                title: 'Motivación',
                                content:
                                    'Se necesita mucho coraje para llevar un negocio o cumplir con todos los objetivos del día a día. Es por eso que cuento mi trayectoria para inspirar y dar el ejemplo de que SÍ es posible.'),
                            SizedBox(
                              height: 30,
                            ),
                            Acordeon(
                                title: 'Casos especializados',
                                content:
                                    'Imaginemos que eres una empresa de Seguros y quieres ejemplos de cómo hacer publicidad. Pues entonces: manos a la obra, expondré temas y casos en los que entiendan y les sirvan para poder implementarlos en su día a día.'),
                            SizedBox(
                              height: 30,
                            ),
                            Acordeon(
                                title: 'Preguntas frecuentes',
                                content:
                                    '¿Cómo funciona el proceso para agendar la fecha?\nEscríbeme a hola@jpdirector.net para chequear si ese día  está disponible, si es el caso,  puedes hacer un pago de dos partes 50% del precio de la conferencia y el otro 50% debe ser cancelado cinco días antes del evento.\n\n¿Puedes asistir a cualquier estado dentro de los Estados Unidos?\nClaro, solo debemos coordinar los boletos de avión, hospedaje y viáticos.'),
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

class LetrasConferencias extends StatelessWidget {
  const LetrasConferencias({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    double wScreen = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'CONFERENCIAS',
          style: GoogleFonts.roboto(fontSize: (wScreen < 600) ? 32 : 40, fontWeight: FontWeight.w900, color: blancoText),
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
        if (wScreen < 1201)
          Container(
            child: Stack(
              children: [
                Positioned(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: const Image(
                      image: bgConferencia,
                      width: 400,
                    ),
                  ),
                ),
                const Positioned(
                  top: 280,
                  left: 140,
                  child: Image(
                    image: adsCircle,
                    width: 100,
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: (authProvider.authStatus == AuthStatus.authenticated)
              ? const EdgeInsets.only(left: 40, top: 17)
              : const EdgeInsets.only(left: 10, top: 10),
          child: Text(
            'Seamos sinceros, estamos en la era de lo personalizado.\n\nEs por eso que contratándome para tu conferencia me enfocaré en los temas que SÍ les interesan, educando y divirtiendo a todos los participantes del evento.',
            style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w400, color: blancoText),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            '¿Qué hablaré durante tu evento?',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(fontSize: 26, fontWeight: FontWeight.w900, color: azulText),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        BotonVerde(
          text: 'Estoy listo, Comencemos',
          onPressed: () => Navigator.pushNamed(context, Flurorouter.conferenciasFormRoute),
          width: 200,
        ),
        const SizedBox(height: 50),
        SizedBox(
          child: Image(
            image: baseGif,
            colorBlendMode: BlendMode.modulate,
            color: blancoText.withOpacity(0.4),
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
