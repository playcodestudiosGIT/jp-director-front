import 'package:flutter/material.dart';

import '../../../constant.dart';
import 'dashboard_label.dart';

class TitleLabel extends StatelessWidget {
  final String texto;
  const TitleLabel({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      alignment: Alignment.centerLeft,
      height: 55,
      decoration: BoxDecoration(color: azulText.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Text(
          texto,
          style: DashboardLabel.h1.copyWith(color: blancoText),
        ),
      ),
    );
  }
}
