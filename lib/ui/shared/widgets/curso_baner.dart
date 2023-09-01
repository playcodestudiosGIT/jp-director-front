import 'package:flutter/material.dart';
import 'package:jp_director/providers/export_all_providers.dart';
import 'package:jp_director/ui/shared/widgets/progress_ind.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../models/curso.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import '../botones/custom_button.dart';
import '../labels/dashboard_label.dart';


class CursoBanerView extends StatelessWidget {
  final Curso curso;
  final bool esMio;
  const CursoBanerView({super.key, required this.curso, required this.esMio});

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final wSize = MediaQuery.of(context).size.width;
    return (wSize < 615)
        ? Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 250),
                    child: (curso.img == '') ? const ProgressInd() : Image(image: NetworkImage(curso.img)),
                  ),
                  Positioned(
                      top: 120,
                      child: Container(
                        width: 252,
                        height: 250,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                          colors: [bgColor, Colors.transparent],
                          end: Alignment.topCenter,
                          begin: Alignment.bottomCenter,
                        )),
                      )),
                ],
              ),
              Container(
                width: 250,
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Spacer(),
                        Text(
                          '\$${curso.precio}',
                          style: DashboardLabel.gigant.copyWith(color: const Color(0xffFFEF98), fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    // const SizedBox(height: 30),
                  ],
                ),
              ),
              if (esMio) ...[
                Text(
                  appLocal.comprarBtn,
                  style: DashboardLabel.mini,
                ),
                CustomButton(
                    text: appLocal.continuar,
                    onPress: () async {
                      NavigatorService.replaceTo('${Flurorouter.curso}/${curso.id}/0');
                    },
                    width: 250),
              ],
              if (!esMio) ...[
                CustomButton(
                    text: appLocal.comprarBtn,
                    onPress: () async {
                      if (authProvider.authStatus == AuthStatus.notAuthenticated) {
                        NavigatorService.replaceTo('${Flurorouter.payNewUserRouteAlt}/${curso.id}/login');
                      }
                      if (authProvider.authStatus == AuthStatus.authenticated) {
                        final resp = await Provider.of<PayProvider>(context, listen: false)
                            .createSession(price: int.parse(curso.precio), cursoId: curso.id, userEmail: authProvider.user!.correo);
                        if (resp != '') {
                          final Uri urluri = Uri.parse(resp);
                          if (!await launchUrl(urluri)) {
                            throw Exception('Could not launch $urluri');
                          }
                        }
                      }
                    },
                    width: 250),
              ],
              const SizedBox(height: 30),
            ],
          )
        : Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxWidth: 800, minHeight: 280),
                child: (curso.baner == '')
                    ? const ProgressInd()
                    : Image(
                        image: NetworkImage(curso.baner),
                      ),
              ),
              Container(
                constraints: const BoxConstraints(maxWidth: 800, minHeight: 280),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [bgColor, Colors.transparent],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    stops: [0.1, 0.6],
                  ),
                ),
              ),
              Container(
                constraints: const BoxConstraints(maxWidth: 800, minHeight: 280),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      width: 200,
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          if (!esMio)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '\$',
                                  style: DashboardLabel.gigant.copyWith(color: const Color(0xffFFEF98), fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  curso.precio,
                                  style: DashboardLabel.gigant.copyWith(color: const Color(0xffFFEF98), fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          if (esMio)
                            Text(
                              appLocal.yaTienesEsteCurso,
                              style: DashboardLabel.mini,
                            ),
                          const SizedBox(height: 10),
                          if (esMio)
                            CustomButton(
                                text: appLocal.continuar,
                                onPress: () {
                                  NavigatorService.replaceTo('${Flurorouter.curso}/${curso.id}/0');
                                },
                                width: 250),
                          if (!esMio)
                            CustomButton(
                                text: appLocal.comprarBtn,
                                onPress: () async {
                                  if (authProvider.authStatus == AuthStatus.notAuthenticated) {
                                    NavigatorService.replaceTo('${Flurorouter.payNewUserRouteAlt}/${curso.id}/login');
                                  }
                                  if (authProvider.authStatus == AuthStatus.authenticated) {
                                    final resp = await Provider.of<PayProvider>(context, listen: false)
                                        .createSession(price: int.parse(curso.precio), cursoId: curso.id, userEmail: authProvider.user!.correo);
                                    if (resp != '') {
                                      final Uri urluri = Uri.parse(resp);
                                      if (!await launchUrl(urluri)) {
                                        throw Exception('Could not launch $urluri');
                                      }
                                    }
                                  }
                                },
                                width: 250),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ),
            ],
          );
  }
}
