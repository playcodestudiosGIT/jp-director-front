import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant.dart';
import '../shared/labels/dashboard_label.dart';

class WhiteCardBorder extends StatelessWidget {
  final String? title;
  final Widget child;
  final double border;

  const WhiteCardBorder({Key? key, this.title, required this.border, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            FittedBox(
              fit: BoxFit.contain,
              child: Text(
                title!,
                style: DashboardLabel.paragraph.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const Divider()
          ],
          child
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(border), boxShadow: [
        BoxShadow(
          color: azulText.withOpacity(0.08),
          blurRadius: 20,
          offset: const Offset(0, 0),
        )
      ]);
}
