import 'package:flutter/material.dart';

import 'package:jp_director/ui/shared/botones/botonverde.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';
import 'package:jp_director/ui/shared/widgets/top_area_back.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../providers/events_provider.dart';
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
                  TopAreaBack(onPress: () {
                    NavigatorService.navigateTo('/servicios');
                  }),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxWidth: 600, maxHeight: 850),
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
                        constraints:
                            const BoxConstraints(minWidth: 300, maxWidth: 900),
                        child: Column(
                          children: [
                            Acordeon(
                              title: appLocal.xdondeComenzar,
                              content: appLocal.xdondeComenzarResp,
                              service: 'Asesoria',
                            ),
                            const SizedBox(height: 30),
                            Acordeon(
                              title: appLocal.queHablaremos,
                              content: appLocal.queHablaremosResp,
                              service: 'Asesoria',
                            ),
                            const SizedBox(height: 30),
                            Acordeon(
                              title: appLocal.preguntasfrecuentes,
                              content: appLocal.preguntasfrecuentesResp,
                              service: 'Asesoria',
                            ),
                            const SizedBox(height: 30),
                            Acordeon(
                              title: appLocal.tiempoSeAcumulaPreg,
                              content: appLocal.tiempoSeAcumulaResp,
                              service: 'Asesoria',
                            ),
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
        Text(appLocal.asesoria11,
            style: (wScreen < 600)
                ? DashboardLabel.h1
                : DashboardLabel.semiGigant),
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
          style: DashboardLabel.semiGigant,
        ),
        Text(
          appLocal.conTuNeg,
          style: DashboardLabel.semiGigant,
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
                color:
                    (wScreen < 1200) ? blancoText.withOpacity(0.3) : blancoText,
                colorBlendMode: BlendMode.modulate,
                width: 80,
              ),
            ),
          ],
        ),
        Text(
          appLocal.unoAuno,
          style: DashboardLabel.azulTextGigant,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              appLocal.precio11,
              style: DashboardLabel.azulTextGigant,
            ),
            Text(appLocal.usd,
                style: DashboardLabel.paragraph.copyWith(color: azulText)),
            const SizedBox(
              width: 8,
            ),
            Text(
              appLocal.xHora,
              style: DashboardLabel.azulTextGigant,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        BotonVerde(
          text: appLocal.agendarBtn,
          onPressed: () async {
            await Provider.of<EventsProvider>(context, listen: false)
                .clickEvent(
                    title: 'Click Asesoria Agendar',
                    source: '/v/asesoria',
                    description: 'Click en boton agendar asesoria');
            NavigatorService.navigateTo(Flurorouter.agendarRoute);
          },
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
