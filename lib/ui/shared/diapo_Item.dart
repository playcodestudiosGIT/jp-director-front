
import 'package:flutter/material.dart';

import '../../constant.dart';
import 'labels/dashboard_label.dart';

class DiapoItem extends StatelessWidget {
  final IconData bigIcon;
  final String bigText;
  final String text;
  const DiapoItem({super.key, required this.bigIcon, required this.bigText, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(bigIcon, size: 120, color: blancoText),
            const SizedBox(height: 15),
            Text(bigText, style: DashboardLabel.h2),
            const SizedBox(height: 15),
            Container(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Text(text, style: DashboardLabel.h4.copyWith(color: blancoText.withOpacity(0.5))))
          ],
        ),
      ),
    );
  }
}