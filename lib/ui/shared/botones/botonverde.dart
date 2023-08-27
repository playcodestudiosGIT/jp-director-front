import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../labels/dashboard_label.dart';

class BotonVerde extends StatelessWidget {
  final double width;
  final String text;
  final Function onPressed;
  const BotonVerde({super.key, required this.text, required this.onPressed, required this.width});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onPressed(),
        child: Container(
          height: 40,
          width: width,
          decoration:
              BoxDecoration(border: Border.all(color: verdeBorde, width: 4, style: BorderStyle.solid), borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Text(
              text,
              style: DashboardLabel.paragraph.copyWith(color: blancoText, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
