import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:jp_director/constant.dart';
import 'package:jp_director/generated/l10n.dart';
import 'package:jp_director/providers/auth_provider.dart';
import 'package:jp_director/services/navigator_service.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';
import 'package:provider/provider.dart';

import 'package:jp_director/ui/shared/menus/home_app_menu.dart';

import '../../providers/all_cursos_provider.dart';
import '../../providers/events_provider.dart';
import '../../providers/page_provider.dart';
import '../../providers/sidebar_provider.dart';
import '../shared/widgets/appbar_top.dart';

class ClientPageLayout extends StatefulWidget {
  final Widget child;

  const ClientPageLayout({Key? key, required this.child}) : super(key: key);

  @override
  State<ClientPageLayout> createState() => _ClientPageLayoutState();
}

class _ClientPageLayoutState extends State<ClientPageLayout>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    Provider.of<AllCursosProvider>(context, listen: false).getAllCursos();
    Provider.of<AllCursosProvider>(context, listen: false)
        .obtenerMisCursos(authProvider.user!);
    SideBarProvider.menuController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    final wScreen = MediaQuery.of(context).size.width;
    final authProvider = Provider.of<AuthProvider>(context);
    final appLocal = AppLocalizations.of(context);
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.transparent,
            onPressed: () async {
              Provider.of<EventsProvider>(context, listen: false).clickEvent(
                    uid: authProvider.user!.uid,
                    email: authProvider.user!.correo,
                    source: 'Anywhere',
                    description:
                        'Click en el Floating action Button Soporte',
                    title: 'click-en-soporte');
              NavigatorService.navigateTo('/support');
            },
            child: Overlay(
              initialEntries: [
                OverlayEntry(
                  builder: (context) => Tooltip(
                      textStyle: DashboardLabel.mini.copyWith(fontSize: 10),
                      verticalOffset: 10,
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                      message: appLocal.soporte,
                      child: const Icon(Icons.support_agent, color: azulText)),
                )
              ],
            ),
          ),
          FloatingActionButton(
            backgroundColor: Colors.transparent,
            mini: true,
            onPressed: () {
              // asdf
              if (authProvider.locale == const Locale('es')) {
                Provider.of<EventsProvider>(context, listen: false).clickEvent(
                source: 'Anywhere',
                description: 'Cambio idioma a ingles',
                title: 'click-lenguaje-ingles');
                authProvider.setLocale(const Locale('en'));
              } else {
                Provider.of<EventsProvider>(context, listen: false).clickEvent(
                source: 'Anywhere',
                description: 'Cambio idioma a Espanol',
                title: 'click-lenguaje-espanil');
                authProvider.setLocale(const Locale('es'));
              }
            },
            child: (authProvider.locale == const Locale('es'))
                ? const Image(
                    image: NetworkImage(
                        'https://res.cloudinary.com/dqiwrcosz/image/upload/v1692677994/statics/es_flag_qbeneh.png'),
                    width: 30,
                  )
                : const Image(
                    image: NetworkImage(
                        'https://res.cloudinary.com/dqiwrcosz/image/upload/v1692677994/statics/en_flag_fyiybd.png'),
                    width: 30,
                  ),
          ),
        ],
      ),
      backgroundColor: bgColor,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: wScreen),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                    top: 0,
                    right: 100,
                    child: SlideInRight(
                        duration: const Duration(seconds: 50),
                        from: 300,
                        controller: (controller) {
                          PageProvider.circleController = controller;
                        },
                        child: const SizedBox(
                            width: 300, child: Image(image: circulo)))),
                Positioned(
                    top: 0,
                    left: -500,
                    child: SlideInLeft(
                        duration: const Duration(seconds: 25),
                        from: 300,
                        controller: (controller) {
                          PageProvider.circleController = controller;
                        },
                        child: const SizedBox(
                            width: 1100, child: Image(image: circulo)))),
                Container(
                    constraints: const BoxConstraints(maxWidth: 1920),
                    child: widget.child),
                const AppbarTop(),
                const Positioned(
                    right: 0,
                    top: 5,
                    child: Stack(
                      children: [
                        HomeAppMenu(),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
