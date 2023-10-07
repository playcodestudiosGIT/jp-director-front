import 'package:flutter/material.dart';
import 'package:jp_director/providers/meta_event_provider.dart';
import 'package:jp_director/ui/shared/botones/botonverde.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../providers/export_all_providers.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';

class AsesoriaView extends StatelessWidget {
  const AsesoriaView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AsesoriaMain();
  }
}

class AsesoriaMain extends StatelessWidget {
  const AsesoriaMain({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    double wScreen = MediaQuery.of(context).size.width;
    double hScreen = MediaQuery.of(context).size.height;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        constraints: const BoxConstraints(maxWidth: 800),
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                alignment: WrapAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (hScreen > 624) ...[
                        Text(
                          appLocal.asesoria11,
                          style: (wScreen < 550)
                              ? DashboardLabel.h1
                              : DashboardLabel.gigant,
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
                      ],
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(appLocal.completPers,
                          textAlign: TextAlign.start, style: DashboardLabel.h4),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        appLocal.enUnaVideollamada,
                        style: DashboardLabel.paragraph.copyWith(
                          color: blancoText.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        appLocal.resolvamosEsto,
                        style: DashboardLabel.paragraph.copyWith(
                          color: blancoText.withOpacity(0.5),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              BotonVerde(
                  text: appLocal.quieroMiAsesoriaBtn,
                  onPressed: () {
                    Provider.of<MetaEventProvider>(context, listen: false).clickEvent(
                        source: '/servicios - Slider ASESORIA',
                        description: 'Click en Quiero mi asesoria',
                        title: 'Servicio Asesoria');
                    NavigatorService.navigateTo(Flurorouter.asesoriaRoute);
                  },
                  width: 200)
            ],
          ),
        ));
  }
}
