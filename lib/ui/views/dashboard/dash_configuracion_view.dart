import 'package:flutter/material.dart';

import '../../cards/white_card.dart';
import '../../shared/labels/dashboard_label.dart';

class DashConfiguracionView extends StatelessWidget {
  const DashConfiguracionView({super.key});

  @override
  Widget build(BuildContext context) {
    final wScreen = MediaQuery.of(context).size.width;
    return Container(
        margin: (wScreen < 715)
            ? const EdgeInsets.only(left: 45)
            : const EdgeInsets.only(left: 10),
        child: ListView(physics: const ClampingScrollPhysics(), children: [
          const SizedBox(
            height: 80,
          ),
          Text(
            'Configuración',
            style: DashboardLabel.h1,
          ),
          const SizedBox(
            height: 10,
          ),
          const WhiteCard(title: 'Hola Munfo TITLE', child: Text('Hola Mundo')),
        ]));
  }
}
