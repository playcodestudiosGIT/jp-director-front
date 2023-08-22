import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/ui/shared/botones/botonverde.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../providers/auth_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import '../../shared/widgets/acordion.dart';

class ConferenciasPage extends StatelessWidget {
  const ConferenciasPage({super.key});

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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: const _LetrasConferencias(),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      appLocal.queHablareEvento,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(fontSize: 26, fontWeight: FontWeight.w900, color: azulText),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        constraints: const BoxConstraints(minWidth: 300, maxWidth: 900),
                        child: Column(
                          children: [
                            Acordeon(
                              title: appLocal.pubOnline,
                              content: appLocal.pubOnlineResp,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Acordeon(
                                title: appLocal.actRapidez,
                                content:
                                    appLocal.actRapidezResp),
                            const SizedBox(
                              height: 30,
                            ),
                            Acordeon(
                                title: appLocal.motivacion,
                                content:
                                    appLocal.motivacionResp),
                            const SizedBox(
                              height: 30,
                            ),
                            Acordeon(
                                title: appLocal.casosEsp,
                                content:
                                    appLocal.casosEspResp),
                            const SizedBox(
                              height: 30,
                            ),
                            Acordeon(
                                title: appLocal.preguntasfrecuentes,
                                content:
                                    appLocal.preguntasfrecuentes3Resp),
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

class _LetrasConferencias extends StatelessWidget {
  const _LetrasConferencias();

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final authProvider = Provider.of<AuthProvider>(context);
    double wScreen = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          appLocal.conferencias,
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
        Stack(
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
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: (authProvider.authStatus == AuthStatus.authenticated)
              ? const EdgeInsets.only(left: 40, top: 17)
              : const EdgeInsets.only(left: 10, top: 10),
          child: Text(
            appLocal.seamosSinceros,
            style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w400, color: blancoText),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        BotonVerde(
          text: appLocal.estoyListoBtn,
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
