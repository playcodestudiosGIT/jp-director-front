import 'package:flutter/material.dart';

import '../../../constant.dart';
import 'dashboard_label.dart';

class TitleLabel extends StatelessWidget {
  final String texto;
  const TitleLabel({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 8, right: 8, bottom: 8),
      alignment: Alignment.centerLeft,
      height: 55,
      decoration: BoxDecoration(color: azulText.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Text(
          texto,
          style: (size.width <= 400 ) ? DashboardLabel.h3.copyWith(color: blancoText) : DashboardLabel.h1.copyWith(color: blancoText),
        ),
      ),
    );
  }
}
