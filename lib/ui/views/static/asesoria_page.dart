import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:jp_director/ui/shared/botones/botonverde.dart';


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
    final appLocal = AppLocalizations.of(context);
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
                        child: Column(
                          children: [
                            Acordeon(
                              title: appLocal.xdondeComenzar,
                              content:
                                  appLocal.xdondeComenzarResp,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Acordeon(
                                title: appLocal.queHablaremos,
                                content:
                                    appLocal.queHablaremosResp),
                            const SizedBox(
                              height: 30,
                            ),
                            Acordeon(
                                title: appLocal.preguntasfrecuentes,
                                content:
                                    appLocal.preguntasfrecuentesResp),
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
          appLocal.videollamada,
          style: GoogleFonts.roboto(fontSize: 32, fontWeight: FontWeight.w900, color: blancoText),
        ),
        Text(
          appLocal.conTuNeg,
          style: GoogleFonts.roboto(fontSize: 32, fontWeight: FontWeight.w900, color: blancoText),
        ),
        // if (wScreen < 1200)
          Stack(
            children: [
              const Image(
                image: bgAsesoria,
                width: 400,
                height: 400,
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
          appLocal.unoAuno,
          style: GoogleFonts.roboto(fontSize: 32, fontWeight: FontWeight.w900, color: azulText),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              appLocal.precio11,
              style: GoogleFonts.roboto(fontSize: 32, fontWeight: FontWeight.w900, color: azulText),
            ),
            Text(
              appLocal.usd,
              style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w900, color: azulText),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              appLocal.xHora,
              style: GoogleFonts.roboto(fontSize: 32, fontWeight: FontWeight.w900, color: azulText),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        BotonVerde(
          text: appLocal.agendarBtn,
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
