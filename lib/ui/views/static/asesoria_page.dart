import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/ui/shared/botones/botonverde.dart';


import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import '../../shared/widgets/acordion.dart';

class AsesoriaPage extends StatelessWidget {
  const AsesoriaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Stack(
        children: [
          // Container(color: bgColor),
          _AsesoriaBody(),
          SizedBox(
            height: 200,
          )
        ],
      ),
    );
  }
}

class _AsesoriaBody extends StatelessWidget {
  const _AsesoriaBody({Key? key}) : super(key: key);

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
                        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 850),
                        child: const _LetrasAsesoria(),
                      ),
                      // if (wScreen > 1200)
                      //   Container(
                      //     child: Stack(
                      //       children: [
                      //         Positioned(
                      //           child: ConstrainedBox(
                      //             constraints: const BoxConstraints(maxWidth: 600, minWidth: 300),
                      //             child: const Image(image: bgAsesoria),
                      //           ),
                      //         ),
                      //         Positioned(
                      //           top: 360,
                      //           right: (wScreen > 1200) ? 250 : 250,
                      //           child: const Image(
                      //             image: adsCircle,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    // color: bgColor,
                    child: Center(
                      child: Container(
                        // padding: EdgeInsets.symmetric(horizontal: 20),
                        constraints: const BoxConstraints(minWidth: 300, maxWidth: 900),
                        child: const Column(
                          children: [
                            Acordeon(
                              title: '¿Por dónde comenzar?',
                              content:
                                  'Estar solo en el proceso suele ser difícil e intentar comprender la plataforma, cuánto presupuesto diario invertir, tener errores, estar inhabilitados, no saber si la estrategia funcionará y cómo analizar los resultados suele ser un dolor de cabeza.\n\nEs por eso que esta asesoría te ayudará a obtener un panorama más exacto de lo que necesitas y además acelerar el proceso que debes tener como negocio.\n\nCon mi experiencia en el mundo de la publicidad digital, puedo darte una visión más clara de lo que requieres para aumentar las ventas.\n\nDurante el 2021 comencé a realizar estas asesorías y he perfeccionado la metodología para que puedas aprovechar este tiempo en aclarar todas tus dudas y solucionar esos errores comunes que hacen que no avances, corregirlos y dar en el punto de posicionar tu negocio.\n\nAl comprar el servicio te llegará un correo con la información que necesitas tener para ese día y podamos aprovechar la asesoría al máximo.',
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Acordeon(
                                title: '¿Qué hablaremos en la reunión?',
                                content:
                                    'Plan de negocio\nAnalizaré si tu propuesta te dará rentabilidad con los servicios o productos que quieres comercializar por internet.\n\nCampañas\nCreadas o no creadas revisaré su estructura y estrategia de manera estratégica.\n\nSitio Web\nExaminaré toda la estructura y te daré la vía para que puedas vender más por tu web.\n\nMétodo de Ventas\nDependiendo de la metodología mejoraremos la manera en la que cierras con tus clientes.'),
                            SizedBox(
                              height: 30,
                            ),
                            Acordeon(
                                title: 'Preguntas frecuentes',
                                content:
                                    '¿Importa si no conozco nada de Facebook - Instagram o Tik Tok Ads?\nNo, míralo como si fueran clases privadas solo para ti.\n\n¿Si conozco y hago campañas actualmente esto es para mi?\nSí, te haré un examen general de tu negocio y cómo puedes mejorar en los puntos en que estés fallando en ads.\n\n¿Puedo ver más de 1 hora?\nPor supuesto, en caso de requerir más clases al final de nuestro meeting podemos coordinar la hora y día de las siguientes, tendrás muchas tareas que te enviaré, si eso sucede, prepárate para este reto.\n\n¿Dónde será la video llamada?\nSerá a través de la plataforma Zoom.\n\n¿Y si no estoy satisfecho con mi mentoría?\nEn caso de que no sea lo que esperabas, te devolveré todo tu dinero.\n\n¿Tuve un inconveniente, puedo reprogramar nuestra reunión?\nTienes 24 horas a más tardar para poder agendar otro día y hora, debes notificar en el siguiente correo: hola@jpdirector.net\n\nEn caso de que no lo hagas en ese tiempo perderás tu inversión y pagarás nuevamente una nueva asesoría.'),
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

class _LetrasAsesoria extends StatelessWidget {
  const _LetrasAsesoria();

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    double wScreen = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          appLocal.asesoria11,
          style: GoogleFonts.roboto(fontSize: (wScreen < 600) ? 26 : 32, fontWeight: FontWeight.w900, color: blancoText),
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
        ),
        Text(
          'VIDEOLLAMADA',
          style: GoogleFonts.roboto(fontSize: 32, fontWeight: FontWeight.w900, color: blancoText),
        ),
        Text(
          'con TU NEGOCIO',
          style: GoogleFonts.roboto(fontSize: 32, fontWeight: FontWeight.w900, color: blancoText),
        ),
        // if (wScreen < 1200)
          Stack(
            children: [
              const Image(
                image: bgAsesoria,
                width: 400,
              ),
              Positioned(
                top: 220,
                right: 160,
                child: Image(
                  image: adsCircle,
                  color: (wScreen < 1200) ? blancoText.withOpacity(0.3) : blancoText,
                  colorBlendMode: BlendMode.modulate,
                  width: 80,
                ),
              ),
            ],
          ),
        Text(
          'UNO A UNO',
          style: GoogleFonts.roboto(fontSize: 32, fontWeight: FontWeight.w900, color: azulText),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '\$250',
              style: GoogleFonts.roboto(fontSize: 32, fontWeight: FontWeight.w900, color: azulText),
            ),
            Text(
              'usd',
              style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w900, color: azulText),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              'x hora',
              style: GoogleFonts.roboto(fontSize: 32, fontWeight: FontWeight.w900, color: azulText),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        BotonVerde(
          text: 'Agendar',
          onPressed: () => Navigator.pushNamed(context, Flurorouter.agendarRoute),
          width: 100,
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
