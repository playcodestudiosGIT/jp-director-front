import 'package:flutter/material.dart';

import '../ui/shared/labels/dashboard_label.dart';


class NotifServ {
  static GlobalKey<ScaffoldMessengerState> msgKey = GlobalKey<ScaffoldMessengerState>(debugLabel: 'msgKey');

  static showSnackbarError(String msg, Color color) {
    final snackBar = SnackBar(
        backgroundColor: color,
        content: Text(
          msg,
          style: DashboardLabel.h4,
        ));

    msgKey.currentState!.showSnackBar(snackBar);
  }
}
