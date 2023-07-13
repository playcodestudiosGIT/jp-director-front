import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constant.dart';


class SeparadorMenuTexto extends StatelessWidget {
  final String text;

  const SeparadorMenuTexto({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(bottom: 5),
      child: Text(
        text,
        style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400, color: blancoText.withOpacity(0.5)),
      ),
    );
  }
}
