import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/providers/sidebar_provider.dart';
import 'package:jpdirector_frontend/ui/shared/widgets/menu_item_top.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import '../../providers/page_provider.dart';
import '../../router/router.dart';
import '../../services/navigator_service.dart';
import '../shared/botones/custom_button.dart';
import '../shared/menus/home_app_menu.dart';
import '../shared/sidebar.dart';

class UserPageLayout extends StatefulWidget {
  final Widget child;

  const UserPageLayout({Key? key, required this.child}) : super(key: key);

  @override
  State<UserPageLayout> createState() => _UserPageLayoutState();
}

class _UserPageLayoutState extends State<UserPageLayout> {
  @override
  Widget build(BuildContext context) {
    final isAparece = Provider.of<SideBarProvider>(context).isAparece;
    final wScreen = MediaQuery.of(context).size.width;
    final hScreen = MediaQuery.of(context).size.height;

    return Scaffold(
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
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [if (wScreen >= 715 && isAparece) const SideBar(), Expanded(child: widget.child)])),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  height: 60,
                  decoration: buildBoxDecorationAppbar(),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        NavigatorService.replaceTo(Flurorouter.homeRoute);
                      },
                      child: Row(
                        children: [
                          if(wScreen <= 390)
                          const SizedBox(width: 50),
                          if(wScreen > 390)
                          const SizedBox(width: 30),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              width: (wScreen <= 390)? 50 :200,
                              child: (wScreen <= 390)
                                ? const Image(image: logoIso)
                                : const Image(image: logoJp),
                            ),
                          ),
                          const Spacer(),
                          if (wScreen >= 850) ...[
                            // MenuItemTop(text: 'INICIO', isActive: false, onPress: () {}),
                            MenuItemTop(text: 'CURSOS', isActive: false, onPress: () {NavigatorService.navigateTo('/cursos');}),
                            MenuItemTop(text: 'SERVICIOS', isActive: false, onPress: () {NavigatorService.navigateTo('/servicios');}),
                            MenuItemTop(text: 'RESULTADOS', isActive: false, onPress: () {NavigatorService.navigateTo('/resultados');}),
                            MenuItemTop(text: 'CONTACTO', isActive: false, onPress: () {NavigatorService.navigateTo('/contacto');}),
                            const SizedBox(width: 245)
                          ]
                        ],
                      ),
                    ),
                  ),
                ),
                if (wScreen < 850) const Positioned(left: -10, top: 5, child: HomeAppMenu()),
                Positioned(
                    right: (wScreen <= 390) ? 10 : 45,
                    top: 12,
                    child: CustomButton(
                      text: 'ENTRAR',
                      width: 70,
                      onPress: () {
                        NavigatorService.replaceTo(Flurorouter.loginRoute);
                      },
                    )),
                if(wScreen > 420)
                Positioned(
                  right: (wScreen <= 390) ? 90 : 125,
                  top: 15,
                  child: TextButton(
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(blancoText.withOpacity(0.1))),
                    onPressed: () {
                      NavigatorService.replaceTo(Flurorouter.registerRoute);
                    }, // Navigate to register page
                    child: Text(
                      'Registrate',
                      style: GoogleFonts.roboto(fontSize: 14, color: azulText, fontWeight: FontWeight.w800),
                    ),
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