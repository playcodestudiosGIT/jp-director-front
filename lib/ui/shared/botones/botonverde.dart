import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constant.dart';

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
              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w700, color: blancoText),
            ),
          ),
        ),
      ),
    );
  }
}
