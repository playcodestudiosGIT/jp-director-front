import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../labels/dashboard_label.dart';
import 'diapo_item.dart';


class CursoLandingSlider extends StatelessWidget {
  final PageController pageController;
  const CursoLandingSlider({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    List<Widget> listSliders = [
      DiapoItem(bigText: appLocal.emprendedorOFree, bigIcon: Icons.laptop, text: appLocal.emprendedorOFreeText),
      DiapoItem(
        bigText: appLocal.duenosNegocios,
        bigIcon: Icons.person_pin_outlined,
        text: appLocal.duenosNegociosText,
      ),
      DiapoItem(
        bigText: appLocal.negocioLocFis,
        bigIcon: Icons.home_outlined,
        text: appLocal.negocioLocFisText,
      ),
      DiapoItem(
        bigText: appLocal.profesionalesEnMark,
        bigIcon: Icons.people_alt_outlined,
        text: appLocal.profesionalesEnMarkText,
      ),
      DiapoItem(
        bigText: appLocal.consultEspec,
        bigIcon: Icons.lightbulb_outline,
        text: appLocal.consultEspecText,
      ),
      DiapoItem(
        bigText: appLocal.inhabResagBloq,
        bigIcon: Icons.visibility_off_outlined,
        text: appLocal.inhabResagBloqText,
      ),
    ];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(appLocal.estaMision, style: DashboardLabel.h1),
          ],
        ),
        Expanded(
            child: PageView(
          controller: pageController,
          scrollDirection: Axis.horizontal,
          children: listSliders,
        )),
      ],
    );
  }
}
