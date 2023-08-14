import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../providers/auth_provider.dart';
import '../../../services/navigator_service.dart';

class FirstView extends StatelessWidget {
  const FirstView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenData = MediaQuery.of(context).size.width;
    return (screenData > 850) ? const NormalBody() : const MobileBody();
  }
}

class NormalBody extends StatelessWidget {
  const NormalBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenData = MediaQuery.of(context).size;
    // final pageProvider = Provider.of<PageProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: (screenData.width < 715 && authProvider.authStatus == AuthStatus.authenticated)
            ? const EdgeInsets.only(left: 50)
            : const EdgeInsets.only(left: 0),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 100),

            ),
            Positioned(
              top: 250,
              left: 135,
              child: SlideInLeft(from: 60, duration: const Duration(seconds: 10), child: const Image(width: 160, image: planetaI)),
            ),
            Positioned(
              top: 400,
              left: 0,
              child: SlideInRight(from: 60, duration: const Duration(seconds: 10), child: const Image(width: 200, image: planetaM)),
            ),
            Positioned(
              bottom: 260,
              left: 220,
              child: SlideInLeft(from: 60, duration: const Duration(seconds: 10), child: const Image(width: 100, image: planetaF)),
            ),
            Row(
              children: [
                SizedBox(
                  height: screenData.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 80),
                                // width: 600,
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Educación y\nEstrategia de ADS',
                                        style: GoogleFonts.roboto(
                                            fontSize: (screenData.width < 450) ? 38 : 48, fontWeight: FontWeight.bold, color: blancoText),
                                      ),
                                      Text(
                                        'Llegaste al mundo indicado',
                                        style: GoogleFonts.roboto(
                                            fontSize: (screenData.width < 450) ? 26 : 32, fontWeight: FontWeight.w500, color: blancoText),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'SI',
                                            style: GoogleFonts.roboto(fontSize: 86, fontWeight: FontWeight.w500, color: azulText),
                                          ),
                                          FadeInRight(
                                            from: 20,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Buscas acelerar tu negocio con publicidad',
                                                  style: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w500, color: blancoText),
                                                ),
                                                Text(
                                                  'Quieres conseguir más clientes',
                                                  style: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w500, color: blancoText),
                                                ),
                                                Text(
                                                  'Quieres tener un mentor que te enseñe de manera correcta',
                                                  style: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w500, color: blancoText),
                                                ),
                                                Text(
                                                  'Deseas dejar de sentir angustia por resultados que no convierten',
                                                  style: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w500, color: blancoText),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        'Descubre cómo impulsar tu negocio',
                                        style: GoogleFonts.roboto(fontSize: 29, fontWeight: FontWeight.w500, color: azulText),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          NavigatorService.navigateTo('/cursos');
                                        },
                                        child: MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: BounceInDown(
                                              from: 15,
                                              duration: const Duration(seconds: 1),
                                              child: const Image(
                                                image: arrDown,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 800, minWidth: 200),
                    alignment: Alignment.center,
                    child: Image(
                        // color: (screenData.width < 1300) ? Colors.black.withOpacity(0.6) : bgColor.withOpacity(0),
                        colorBlendMode: (screenData.width < 1300) ? BlendMode.multiply : BlendMode.screen,
                        fit: BoxFit.scaleDown,
                        image: bgHome),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MobileBody extends StatelessWidget {
  const MobileBody({super.key});

  @override
  Widget build(BuildContext context) {
    double screenData = MediaQuery.of(context).size.width;
    return SizedBox(
      
      width: 430,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Educación y\nEstrategia de ADS',
            textAlign: (screenData > 550) ? TextAlign.left : TextAlign.center,
            style: GoogleFonts.roboto(fontSize: (screenData > 550) ? 40 : 28, fontWeight: FontWeight.bold, color: blancoText),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Llegaste al mundo indicado',
              style: GoogleFonts.roboto(fontSize: (screenData > 550) ? 32 : 24, fontWeight: FontWeight.w500, color: blancoText),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  'SI',
                  style: GoogleFonts.roboto(fontSize: (screenData > 550) ? 86 : 54, fontWeight: FontWeight.w500, color: azulText),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Buscas acelerar tu negocio con publicidad',
                      style: GoogleFonts.roboto(fontSize: (screenData > 550) ? 15 : 10, fontWeight: FontWeight.w500, color: blancoText),
                    ),
                    Text(
                      'Quieres conseguir más clientes',
                      style: GoogleFonts.roboto(fontSize: (screenData > 550) ? 15 : 10, fontWeight: FontWeight.w500, color: blancoText),
                    ),
                    Text(
                      'Quieres tener un mentor que te enseñe de manera correcta',
                      style: GoogleFonts.roboto(fontSize: (screenData > 550) ? 15 : 10, fontWeight: FontWeight.w500, color: blancoText),
                    ),
                    Text(
                      'Deseas dejar de sentir angustia por resultados que no convierten',
                      style: GoogleFonts.roboto(fontSize: (screenData > 550) ? 15 : 10, fontWeight: FontWeight.w500, color: blancoText),
                    ),
                  ],
                )
              ],
            ),
          ),
          Image(
            image: bgHome,
            width: (screenData < 450) ? 400 : 500,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'Descubre cómo impulsar tu negocio',
              textAlign: (screenData > 550) ? TextAlign.left : TextAlign.center,
              style: GoogleFonts.roboto(fontSize: (screenData < 450) ? 20 : 32, fontWeight: FontWeight.w900, color: azulText),
            ),
          ),
        ],
      ),
    );
  }
}
