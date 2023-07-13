import 'package:flutter/material.dart';
import 'package:jpdirector_frontend/constant.dart';

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
              child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null)
                      ...[
                        Icon(icon, color: Colors.white,),
                        const SizedBox(width: 10)
                      ],
                      Text(text, style: const TextStyle(fontFamily: 'Roboto', color: blancoText, fontSize: 14, fontWeight: FontWeight.w800)),
                    ],
                  )),
        ),
      ),
    );
  }
}
