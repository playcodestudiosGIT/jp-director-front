import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../constant.dart';

class WhiteCardBorder extends StatelessWidget {
  final String? title;
  final Widget child;
  final double border;

  const WhiteCardBorder({Key? key, this.title, required this.border, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      decoration: buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            FittedBox(
              fit: BoxFit.contain,
              child: Text(
                title!,
                style: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider()
          ],
          child
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
      color: blancoText, borderRadius: BorderRadius.circular(border), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)]);
}
