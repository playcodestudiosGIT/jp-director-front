import 'package:flutter/material.dart';

import 'package:jp_director/ui/shared/botones/botonverde.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';
import 'package:jp_director/ui/shared/widgets/top_area_back.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../providers/meta_event_provider.dart';
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
                  TopAreaBack(
                      onPress: () => NavigatorService.navigateTo('/servicios')),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxWidth: 600, maxHeight: 912),
                        child: const _LetrasAsesoria(),
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
                              title: appLocal.disenoEstrat,
                              content: appLocal.disenoEstratResp,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Acordeon(
                                service: 'Encargado',
                                title: appLocal.confCampanas,
                                content: appLocal.confCampanasResp),
                            const SizedBox(
                              height: 30,
                            ),
                            Acordeon(
                                service: 'Encargado',
                                title: appLocal.optimizacion,
                                content: appLocal.optimizacionResp),
                            const SizedBox(
                              height: 30,
                            ),
                            Acordeon(
                                service: 'Encargado',
                                title: appLocal.porQueYo,
                                content: appLocal.porQueYoResp),
                            const SizedBox(
                              height: 30,
                            ),
                            Acordeon(
                                service: 'Encargado',
                                title: appLocal.preguntasfrecuentes,
                                content: appLocal.preguntasfrecuentes2Resp),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    constraints:
                        const BoxConstraints(maxHeight: 100, maxWidth: 980),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40, right: 20),
                      child: Text(
                        appLocal.recuerdaPrimero,
                        textAlign: TextAlign.center,
                        style: DashboardLabel.h4,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BotonVerde(
                    text: appLocal.empezamosBtn,
                    onPressed: () {
                      Provider.of<MetaEventProvider>(context, listen: false)
                          .clickEvent(
                              source: '/v/encargado - Ser el encargado',
                              description: 'Click en Empezamos?',
                              title: 'Servicio Ser el encargado');
                      Navigator.pushNamed(
                          context, Flurorouter.encargadoFormRoute);
                    },
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

class _LetrasAsesoria extends StatelessWidget {
  const _LetrasAsesoria();

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    double wScreen = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          appLocal.serElEncargado,
          style:
              (wScreen < 600) ? DashboardLabel.h2 : DashboardLabel.semiGigant,
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
                  height: 400,
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
            appLocal.esteServicioEsta,
            style: DashboardLabel.h4,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          appLocal.como,
          style: DashboardLabel.azulTextGigant,
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
          text: appLocal.estoyListoBtn,
          onPressed: () {
            Provider.of<MetaEventProvider>(context, listen: false).clickEvent(
                source: '/v/encargado - Ser el encargado',
                description: 'Click en Estoy listo, comencemos.',
                title: 'Servicio Ser el encargado');
            NavigatorService.navigateTo(Flurorouter.encargadoFormRoute);
          },
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
