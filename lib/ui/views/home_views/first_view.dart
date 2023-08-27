import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/generated/l10n.dart';
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
    final appLocal = AppLocalizations.of(context);
    final screenData = MediaQuery.of(context).size;
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
                                padding: const EdgeInsets.only(left: 60),
                                // width: 600,
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        appLocal.educacionYEstrategia,
                                        style: GoogleFonts.roboto(
                                            fontSize: (screenData.width < 450) ? 38 : 48, fontWeight: FontWeight.bold, color: blancoText),
                                      ),
                                      Text(
                                        appLocal.llegasteAlMundo,
                                        style: GoogleFonts.roboto(
                                            fontSize: (screenData.width < 450) ? 26 : 32, fontWeight: FontWeight.w500, color: blancoText),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            appLocal.siu,
                                            style: GoogleFonts.roboto(fontSize: 86, fontWeight: FontWeight.w500, color: azulText),
                                          ),
                                          FadeInRight(
                                            from: 20,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  appLocal.buscasAcelerar,
                                                  style: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w500, color: blancoText),
                                                ),
                                                Text(
                                                  appLocal.quieresConseguir,
                                                  style: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w500, color: blancoText),
                                                ),
                                                Text(
                                                  appLocal.quieresTener,
                                                  style: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w500, color: blancoText),
                                                ),
                                                Text(
                                                  appLocal.deseasDejar,
                                                  style: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w500, color: blancoText),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        appLocal.descubreComo,
                                        style: GoogleFonts.roboto(fontSize: 29, fontWeight: FontWeight.w500, color: azulText),
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            constraints: const BoxConstraints(maxWidth: 450),
                                            child: GestureDetector(
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
                                            ),
                                          ),
                                        ],
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
    final appLocal = AppLocalizations.of(context);
    double screenData = MediaQuery.of(context).size.width;
    return SizedBox(
      width: 430,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          Text(
            appLocal.educacionYEstrategia,
            textAlign: (screenData > 550) ? TextAlign.left : TextAlign.center,
            style: GoogleFonts.roboto(fontSize: (screenData > 550) ? 40 : 28, fontWeight: FontWeight.bold, color: blancoText),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              appLocal.llegasteAlMundo,
              style: GoogleFonts.roboto(fontSize: (screenData > 550) ? 32 : 24, fontWeight: FontWeight.w500, color: blancoText),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  appLocal.siu,
                  style: GoogleFonts.roboto(fontSize: (screenData > 550) ? 86 : 54, fontWeight: FontWeight.w500, color: azulText),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appLocal.buscasAcelerar,
                      style: GoogleFonts.roboto(fontSize: (screenData > 550) ? 15 : 10, fontWeight: FontWeight.w500, color: blancoText),
                    ),
                    Text(
                      appLocal.quieresConseguir,
                      style: GoogleFonts.roboto(fontSize: (screenData > 550) ? 15 : 10, fontWeight: FontWeight.w500, color: blancoText),
                    ),
                    Text(
                      appLocal.quieresTener,
                      style: GoogleFonts.roboto(fontSize: (screenData > 550) ? 15 : 10, fontWeight: FontWeight.w500, color: blancoText),
                    ),
                    Text(
                      appLocal.deseasDejar,
                      style: GoogleFonts.roboto(fontSize: (screenData > 550) ? 15 : 10, fontWeight: FontWeight.w500, color: blancoText),
                    ),
                  ],
                )
              ],
            ),
          ),
          Image(
            image: bgHome,
            width: (screenData < 450) ? 300 : 500,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              appLocal.descubreComo,
              textAlign: (screenData > 550) ? TextAlign.left : TextAlign.center,
              style: GoogleFonts.roboto(fontSize: (screenData < 450) ? 20 : 32, fontWeight: FontWeight.w900, color: azulText),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                constraints: BoxConstraints(maxWidth: screenData),
                child: GestureDetector(
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
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
