import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jp_director/constant.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';

class TestimonioWidget extends StatelessWidget {
  final String img;
  final String nombre;
  final String testimonio;

  const TestimonioWidget({
    super.key,
    required this.img,
    required this.nombre,
    required this.testimonio,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: 200,      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(img),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                nombre,
                textAlign: TextAlign.center,
                style: DashboardLabel.paragraph.copyWith(color: const Color(0xffFFEF98), fontSize: 24, fontWeight: FontWeight.normal),
              )),
          const SizedBox(height: 15),
              Text(
                testimonio,
                textAlign: TextAlign.center,
                style: GoogleFonts.albertSans(color: blancoText.withOpacity(0.5), height: 2, fontSize: 18, fontWeight: FontWeight.w100),
              ),

          const SizedBox(height: 30),
          Text('”', style: GoogleFonts.spaceGrotesk(fontSize: 60, color: const Color(0xffFFEF98)),)
        ],
      ),
    );
  }
}
