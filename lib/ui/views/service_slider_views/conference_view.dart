import 'package:flutter/material.dart';
import 'package:jp_director/router/router.dart';
import 'package:jp_director/ui/shared/botones/botonverde.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../providers/export_all_providers.dart';
import '../../../providers/events_provider.dart';
import '../../../services/navigator_service.dart';
import '../../shared/labels/dashboard_label.dart';

class ConferenceView extends StatelessWidget {
  const ConferenceView({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    double wScreen = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8.0),
      child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          width: double.infinity,
          height: 500,
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
                        Text(
                          appLocal.conferencias,
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
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          appLocal.contratamePara,
                          style: DashboardLabel.paragraph.copyWith(
                            color: blancoText.withOpacity(0.5),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                BotonVerde(
                    text: appLocal.agendarBtn,
                    onPressed: () {
                      Provider.of<EventsProvider>(context, listen: false).clickEvent(
                        source: '/servicios - Slider CONFERENCIA',
                        description: 'Click en Agendar',
                        title: 'Servicio Conferencia');
                      NavigatorService.navigateTo(
                          Flurorouter.conferenciasRoute);
                    },
                    width: 100)
              ],
            ),
          )),
    );
  }
}
