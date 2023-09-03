import 'package:flutter/material.dart';
import 'package:jp_director/constant.dart';

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
      DiapoItem(
        bigText: appLocal.emprendedorOFree,
        bigIcon: Icons.laptop,
        text: appLocal.emprendedorOFreeText,
        image: monitor,
      ),
      DiapoItem(
        bigText: appLocal.duenosNegocios,
        bigIcon: Icons.person_pin_outlined,
        text: appLocal.duenosNegociosText,
        image: tablet,
      ),
      DiapoItem(
        bigText: appLocal.negocioLocFis,
        bigIcon: Icons.home_outlined,
        text: appLocal.negocioLocFisText,
        image: pc,
      ),
      DiapoItem(
        bigText: appLocal.profesionalesEnMark,
        bigIcon: Icons.people_alt_outlined,
        text: appLocal.profesionalesEnMarkText,
        image: telf,
      ),
      DiapoItem(
        bigText: appLocal.consultEspec,
        bigIcon: Icons.lightbulb_outline,
        text: appLocal.consultEspecText,
        image: satelite,
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
