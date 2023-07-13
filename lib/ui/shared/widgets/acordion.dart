import 'package:flutter/material.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../../constant.dart';

class Acordeon extends StatelessWidget {
  final String title;
  final String content;

  const Acordeon({Key? key, required this.title, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wScreen = MediaQuery.of(context).size.width;
    return Column(
      children: [
        GFAccordion(
          title: title,
          content: content,
          collapsedTitleBackgroundColor: bgColor,
          expandedTitleBackgroundColor: bgColor,
          textStyle: GoogleFonts.roboto(
            color: blancoText,
            fontSize: (wScreen < 1200) ? 24 : 40,
          ),
          collapsedIcon: const Icon(
            Icons.arrow_downward,
            color: blancoText,
          ),
          expandedIcon: const Icon(
            Icons.arrow_upward,
            color: blancoText,
          ),
          contentPadding: const EdgeInsets.all(30),
        ),
        Container(
          width: double.infinity,
          height: 5,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            bgColor,
            azulText,
            bgColor,
          ])),
        ),
      ],
    );
  }
}
