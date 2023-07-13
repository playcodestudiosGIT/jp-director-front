import 'package:flutter/material.dart';
import 'package:jpdirector_frontend/providers/auth_provider.dart';
import 'package:jpdirector_frontend/providers/pay_provider.dart';
import 'package:jpdirector_frontend/router/router.dart';
import 'package:jpdirector_frontend/services/navigator_service.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../services/local_storage.dart';

class CursoImagen extends StatelessWidget {
  final String cursoId;
  final String priceId;
  final String img;
  const CursoImagen({super.key, required this.priceId, required this.img, required this.cursoId});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: GestureDetector(
        onTap: () async {
          final token = LocalStorage.prefs.getString('token');
          if (token != null) {
            final resp = await Provider.of<PayProvider>(context, listen: false)
                .createSession(price: 20, cursoId: cursoId, userEmail: authProvider.user!.correo);
            if (resp != '') {
              final Uri urluri = Uri.parse(resp);
              if (!await launchUrl(urluri)) {
                throw Exception('Could not launch $urluri');
              }
            }
          } else {
            NavigatorService.navigateTo('${Flurorouter.payNewUserRouteAlt}$cursoId?state=login');
          }
        },
        child: MouseRegion(cursor: SystemMouseCursors.click, child: Image(width: 200, image: NetworkImage(img))),
      ),
    );
  }
}
