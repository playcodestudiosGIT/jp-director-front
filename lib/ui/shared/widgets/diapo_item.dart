import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../labels/dashboard_label.dart';

class DiapoItem extends StatelessWidget {
  final NetworkImage image;
  final IconData bigIcon;
  final String bigText;
  final String text;
  const DiapoItem({super.key, required this.bigIcon, required this.bigText, required this.text, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 200, height: 200, child: Image(image: image)),
            const SizedBox(height: 15),
            Text(bigText, style: DashboardLabel.h2),
            const SizedBox(height: 15),
            Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: DashboardLabel.h4.copyWith(color: blancoText.withOpacity(0.5))))
          ],
        ),
      ),
    );
  }
}
