import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/providers/all_cursos_provider.dart';
import 'package:jpdirector_frontend/providers/auth_provider.dart';
import 'package:jpdirector_frontend/providers/sidebar_provider.dart';
import 'package:jpdirector_frontend/ui/shared/widgets/menu_item_top.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import '../../generated/l10n.dart';
import '../../providers/page_provider.dart';
import '../../router/router.dart';
import '../../services/navigator_service.dart';
import '../shared/botones/custom_button.dart';
import '../shared/menus/home_app_menu.dart';

class UserPageLayout extends StatefulWidget {
  final Widget child;

  const UserPageLayout({Key? key, required this.child}) : super(key: key);

  @override
  State<UserPageLayout> createState() => _UserPageLayoutState();
}

class _UserPageLayoutState extends State<UserPageLayout> {
  @override
  void initState() {
    super.initState();
    Provider.of<AllCursosProvider>(context, listen: false).getAllCursos();
  }

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final isAparece = Provider.of<SideBarProvider>(context).isAparece;
    final authProvider = Provider.of<AuthProvider>(context);
    final wScreen = MediaQuery.of(context).size.width;
    final hScreen = MediaQuery.of(context).size.height;

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
                Container(
                    constraints: BoxConstraints(maxWidth: wScreen, maxHeight: hScreen),
                    child: widget.child),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  height: 60,
                  decoration: buildBoxDecorationAppbar(),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        if (wScreen <= 390) const SizedBox(width: 47),
                        if (wScreen > 390) const SizedBox(width: 30),
                        GestureDetector(
                          onTap: () {
                            NavigatorService.replaceTo(Flurorouter.homeRoute);
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              width: (wScreen <= 390) ? 53 : 200,
                              child: (wScreen <= 390) ? const Image(image: logoIso) : const Image(image: logoJp),
                            ),
                          ),
                        ),
                        const Spacer(),
                        if (wScreen >= 850) ...[
                          // MenuItemTop(text: 'INICIO', isActive: false, onPress: () {}),
                          MenuItemTop(
                              text: appLocal.topBotonCursos,
                              isActive: false,
                              onPress: () {
                                NavigatorService.navigateTo('/cursos');
                              }),
                          MenuItemTop(
                              text: appLocal.topBotonServicios,
                              isActive: false,
                              onPress: () {
                                NavigatorService.navigateTo('/servicios');
                              }),
                          MenuItemTop(
                              text: appLocal.topBotonResultados,
                              isActive: false,
                              onPress: () {
                                NavigatorService.navigateTo('/resultados');
                              }),
                          MenuItemTop(
                              text: appLocal.topBotonContacto,
                              isActive: false,
                              onPress: () {
                                NavigatorService.navigateTo('/contacto');
                              }),
                          const SizedBox(width: 245)
                        ]
                      ],
                    ),
                  ),
                ),
                if (wScreen < 850) const Positioned(left: -10, top: 5, child: HomeAppMenu()),
                if (wScreen > 480)
                  Positioned(
                      right: 10,
                      top: 12,
                      child: CustomButton(
                        text: appLocal.botonLogin,
                        width: 70,
                        onPress: () {
                          NavigatorService.replaceTo(Flurorouter.loginRoute);
                        },
                      )),
                if (wScreen <= 480)
                  Positioned(
                      right: 10,
                      top: 10,
                      child: IconButton(
                        icon: const Icon(Icons.login_outlined, color: azulText),
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(blancoText.withOpacity(0.1))),
                        onPressed: () {
                          NavigatorService.replaceTo(Flurorouter.loginRoute);
                        },
                      )),
                if (wScreen > 480)
                  Positioned(
                    right: 90,
                    top: 15,
                    child: TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(blancoText.withOpacity(0.1))),
                      onPressed: () {
                        NavigatorService.replaceTo(Flurorouter.registerRoute);
                      },
                      child: Text(
                        appLocal.botonReg,
                        style: GoogleFonts.roboto(fontSize: 14, color: azulText, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                if (wScreen <= 480)
                  Positioned(
                    right: 60,
                    top: 10,
                    child: IconButton(
                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(blancoText.withOpacity(0.1))),
                      onPressed: () {
                        NavigatorService.replaceTo(Flurorouter.registerRoute);
                      },
                      icon: const Icon(
                        Icons.app_registration_rounded,
                        color: azulText,
                      ), // Navigate to register page
                      // child: Text(
                      //   appLocal.botonReg,
                      //   style: GoogleFonts.roboto(fontSize: 14, color: azulText, fontWeight: FontWeight.w800),
                      // ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      gradient: LinearGradient(colors: [bgColor, bgColor], begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: [0.5, 0.5]));

  BoxDecoration buildBoxDecorationAppbar() =>
      const BoxDecoration(color: Color(0xFF00041C), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]);
}




// 