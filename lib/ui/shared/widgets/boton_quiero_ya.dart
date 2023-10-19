import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../generated/l10n.dart';
import '../../../models/curso.dart';
import '../../../providers/export_all_providers.dart';
import '../../../providers/events_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import '../botones/custom_button.dart';

class BotonQuieroYa extends StatelessWidget {
  final Curso curso;
  const BotonQuieroYa({super.key, required this.curso});

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return Container(
      constraints: const BoxConstraints(maxWidth: 800),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
              text: appLocal.quieroYaBtn,
              onPress: () async {
                if (authProvider.authStatus == AuthStatus.notAuthenticated) {
                  Provider.of<EventsProvider>(context, listen: false).clickEvent(
                      source: 'land/${curso.id}',
                      description:
                          'QUIERO ESTE CURSO YA. Curso ID: ${curso.id}, Nombre Curso: ${curso.nombre}, precio: ${curso.precio}',
                      title: curso.id);
                  NavigatorService.replaceTo(
                      '${Flurorouter.payNewUserRouteAlt}/${curso.id}/login');
                }
                if (authProvider.authStatus == AuthStatus.authenticated) {
                  Provider.of<EventsProvider>(context, listen: false).clickEvent(
                      uid: authProvider.user!.uid,
                      email: authProvider.user!.correo,
                      source: 'land/${curso.id}',
                      description:
                          'Curso ID: ${curso.id}, Nombre Curso: ${curso.nombre}, precio: ${curso.precio}',
                      title: curso.id);
                  final resp =
                      await Provider.of<PayProvider>(context, listen: false)
                          .createSession(
                              price: int.parse(curso.precio),
                              cursoId: curso.id,
                              userEmail: authProvider.user!.correo);
                  if (resp != '') {
                    final Uri urluri = Uri.parse(resp);
                    if (!await launchUrl(urluri)) {
                      throw Exception('Could not launch $urluri');
                    }
                  }
                }
              },
              width: 250)
        ],
      ),
    );
  }
}
