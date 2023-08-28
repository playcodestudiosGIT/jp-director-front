

import 'package:flutter/material.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';

import '../../../constant.dart';

class InputDecor {
  static InputDecoration formFieldInputDecorationSimple({required String label, IconData? icon}) => InputDecoration(
    fillColor: blancoText.withOpacity(0.03),
    filled: true,
    border: const OutlineInputBorder(
      borderSide: BorderSide(color: azulText),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: azulText),
    ),
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: azulText.withOpacity(0.3))),
    labelText: label,
    labelStyle: DashboardLabel.paragraph,
    prefixIcon: (icon == null) ? null : Icon(icon, color: azulText.withOpacity(0.3)),
    suffixIconColor: azulText.withOpacity(0.3));

  static  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      color: bgColor,
      boxShadow: [BoxShadow(color: Colors.black)]);

  static InputDecoration formFieldInputDecoration({required String label, IconData? icon, IconData? suffIcon, Function? onPrs}) => InputDecoration(
      fillColor: blancoText.withOpacity(0.03),
      filled: true,
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: azulText),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: azulText),
      ),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: azulText.withOpacity(0.3))),
      labelText: label,
      labelStyle: DashboardLabel.paragraph,
      prefixIcon: (icon == null) ? null : Icon(icon, color: azulText.withOpacity(0.3)),
      suffixIconColor: azulText.withOpacity(0.3));
}
