import 'package:flutter/material.dart';

import '../ui/shared/labels/dashboard_label.dart';


class NotifServ {
  static GlobalKey<ScaffoldMessengerState> msgKey = GlobalKey<ScaffoldMessengerState>(debugLabel: 'msgKey');

  static void showSnackbarError(String msg, Color color) {
    try {
      // Verificar que tengamos una referencia válida al ScaffoldMessenger
      if (msgKey.currentState == null) {
        
        return;
      }
      
      // Crear el SnackBar con un límite de longitud para el mensaje
      final String displayMsg = msg.length > 200 ? '${msg.substring(0, 197)}...' : msg;
      
      final snackBar = SnackBar(
        backgroundColor: color,
        content: Text(
          displayMsg,
          style: DashboardLabel.h4,
        ),
        duration: const Duration(seconds: 4), // Duración más larga para mensajes importantes
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            // Acción al presionar el botón (cierra el SnackBar)
            msgKey.currentState?.hideCurrentSnackBar();
          },
        ),
      );

      // Mostrar el SnackBar con manejo de errores
      msgKey.currentState!.hideCurrentSnackBar(); // Ocultar cualquier SnackBar actual
      msgKey.currentState!.showSnackBar(snackBar);
      
    } catch (e) {
      
    }
  }
}
