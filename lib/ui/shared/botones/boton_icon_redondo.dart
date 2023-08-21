import 'package:flutter/material.dart';

class BotonRedondoIcono extends StatelessWidget {
  final Color fillColor;
  final Color iconColor;
  final IconData icon;
  final Function onTap;

  const BotonRedondoIcono({super.key, required this.fillColor, required this.iconColor, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: fillColor,
          ),
          child: Center(
              child: Icon(
            icon,
            color: iconColor,
          )),
        ),
      ),
    );
  }
}
