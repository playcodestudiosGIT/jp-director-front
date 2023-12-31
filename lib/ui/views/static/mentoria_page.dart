import 'package:flutter/material.dart';

import 'package:jp_director/ui/shared/botones/botonverde.dart';
import 'package:jp_director/ui/shared/widgets/top_area_back.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../providers/events_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import '../../shared/labels/dashboard_label.dart';
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
                children: [
                  TopAreaBack(
                      onPress: () => NavigatorService.navigateTo('/servicios')),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxWidth: 600, maxHeight: 880),
                        child: const LetrasMentoria(),
                      ),
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
                        constraints:
                            const BoxConstraints(minWidth: 300, maxWidth: 900),
                        child: Column(
                          children: [
                            Acordeon(
                              service: 'Encargado',
                              title: appLocal.queVeremos3m,
                              content: appLocal.queVeremos3mResp,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Acordeon(
                                service: 'Encargado',
                                title: appLocal.preguntasfrecuentes,
                                content: appLocal.preguntasfrecuentes1Resp),
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
    final appLocal = AppLocalizations.of(context);
    final wScreen = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(appLocal.mentoriaIntensiva,
            style: (wScreen < 600)
                ? DashboardLabel.h2
                : DashboardLabel.semiGigant),
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
                  height: 400,
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
            appLocal.duranteElPrimerMes,
            style: DashboardLabel.h4,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        BotonVerde(
          text: appLocal.estoyListoBtn,
          onPressed: () {
            Provider.of<EventsProvider>(context, listen: false).clickEvent(
                        source: '/v/mentoria - Mentoria intensiva',
                        description: 'Click en Estoy listo, comencemos.',
                        title: 'Servicio Mentoria Intensiva');
            Navigator.pushNamed(context, Flurorouter.mentoriaFormRoute);
          },
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
