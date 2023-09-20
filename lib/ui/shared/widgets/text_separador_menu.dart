import 'package:flutter/material.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';

import '../../../constant.dart';


class SeparadorMenuTexto extends StatelessWidget {
  final String text;

  const SeparadorMenuTexto({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      margin: const EdgeInsets.only(bottom: 5),
      child: Text(
        text,
        style: DashboardLabel.mini.copyWith(color: blancoText.withOpacity(0.5)),
      ),
    );
  }
}
