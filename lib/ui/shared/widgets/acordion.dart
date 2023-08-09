import 'package:flutter/material.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';

import 'package:jpdirector_frontend/ui/shared/labels/dashboard_label.dart';


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
          contentBackgroundColor: blancoText,
          collapsedTitleBackgroundColor: bgColor.withOpacity(0.5),
          expandedTitleBackgroundColor: bgColor.withOpacity(0.5),
          textStyle: (wScreen < 1200) ? DashboardLabel.h2 : DashboardLabel.h1,
          collapsedIcon: const Icon(
            Icons.arrow_downward,
            color: azulText,
          ),
          expandedIcon: const Icon(
            Icons.arrow_upward,
            color: azulText,
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
