import 'package:flutter/material.dart';
import 'package:jp_director/constant.dart';

import '../labels/dashboard_label.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double width;
  final Function? onPress;
  final Color color;
  final IconData? icon;
  const CustomButton({super.key, required this.text, required this.onPress, required this.width, this.color = azulText, this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress!(),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
          width: width,
          height: 34,
          child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
              
                        Text(text.toUpperCase(), style: DashboardLabel.paragraph.copyWith(color: bgColor, fontWeight: FontWeight.bold)),
                      ],
                    ),
              )),
        ),
      ),
    );
  }
}
