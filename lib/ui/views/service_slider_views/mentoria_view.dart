import 'package:flutter/material.dart';
import 'package:jp_director/ui/shared/botones/botonverde.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../providers/meta_event_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import '../../shared/labels/dashboard_label.dart';

class MentoriaView extends StatelessWidget {
  const MentoriaView({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    double wScreen = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
                      children: [
                        Text(
                          appLocal.mentoriaIntensiva,
                          style: (wScreen < 550)
                              ? DashboardLabel.h1
                              : DashboardLabel.gigant,
                        ),
                        Container(
                          width: 360,
                          height: 5,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(colors: [
                            bgColor,
                            azulText,
                            bgColor,
                          ])),
                        ),
                        const SizedBox(
                          height: 25,
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FittedBox(
                          child: Text(appLocal.inteligenteInv,
                              textAlign: TextAlign.start,
                              style: DashboardLabel.h4),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          appLocal.tenerUnMentor,
                          style: DashboardLabel.paragraph.copyWith(
                            color: blancoText.withOpacity(0.5),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                BotonVerde(
                    width: 200,
                    text: appLocal.masInformacionBtn,
                    onPressed: () {
                      Provider.of<MetaEventProvider>(context, listen: false).clickEvent(
                        source: '/servicios - Slider MENTORIA',
                        description: 'Click en Mas Información',
                        title: 'Servicio Mentoria');
                      NavigatorService.navigateTo(Flurorouter.mentoriaRoute);
                    }),
              ],
            ),
          )),
    );
  }
}
