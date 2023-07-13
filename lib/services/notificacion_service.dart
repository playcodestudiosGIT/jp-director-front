import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant.dart';


class NotificationServices {
  static GlobalKey<ScaffoldMessengerState> msgKey = GlobalKey<ScaffoldMessengerState>(debugLabel: 'msgKey');

  static showSnackbarError(String msg, Color color) {
    final snackBar = SnackBar(
        backgroundColor: color,
        content: Text(
          msg,
          style: GoogleFonts.roboto(color: blancoText, fontSize: 20),
        ));

    msgKey.currentState!.showSnackBar(snackBar);
  }
}
