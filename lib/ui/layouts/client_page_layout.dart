import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jp_director/constant.dart';
import 'package:jp_director/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import 'package:jp_director/ui/shared/appbar_top.dart';
import 'package:jp_director/ui/shared/menus/home_app_menu.dart';

import '../../providers/all_cursos_provider.dart';
import '../../providers/page_provider.dart';
import '../../providers/sidebar_provider.dart';

class ClientPageLayout extends StatefulWidget {
  final Widget child;

  const ClientPageLayout({Key? key, required this.child}) : super(key: key);

  @override
  State<ClientPageLayout> createState() => _ClientPageLayoutState();
}

class _ClientPageLayoutState extends State<ClientPageLayout> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    Provider.of<AllCursosProvider>(context, listen: false).getAllCursos();
    Provider.of<AllCursosProvider>(context, listen: false).obtenerMisCursos(authProvider.user!);
    SideBarProvider.menuController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    final wScreen = MediaQuery.of(context).size.width;
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        mini: true,
        onPressed: () {
          // asdf
          if (authProvider.locale == const Locale('es')) {
            authProvider.setLocale(const Locale('en'));
          } else {
            authProvider.setLocale(const Locale('es'));
          }
        },
        child: (authProvider.locale == const Locale('es'))
            ? const Image(
                image: NetworkImage('https://res.cloudinary.com/dqiwrcosz/image/upload/v1692677994/statics/es_flag_qbeneh.png'),
                width: 30,
              )
            : const Image(
                image: NetworkImage('https://res.cloudinary.com/dqiwrcosz/image/upload/v1692677994/statics/en_flag_fyiybd.png'),
                width: 30,
              ),
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
                        child: const SizedBox(width: 300, child: Image(image: circulo)))),
                Positioned(
                    top: 0,
                    left: -500,
                    child: SlideInLeft(
                        duration: const Duration(seconds: 25),
                        from: 300,
                        controller: (controller) {
                          PageProvider.circleController = controller;
                        },
                        child: const SizedBox(width: 1100, child: Image(image: circulo)))),
                Container(constraints: const BoxConstraints(maxWidth: 1280), child: widget.child),
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
