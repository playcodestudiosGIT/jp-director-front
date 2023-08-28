import 'package:flutter/material.dart';
import 'package:jp_director/providers/sidebar_provider.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';

import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../providers/auth_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import '../widgets/menu_item_side.dart';
import '../widgets/text_separador_menu.dart';
import 'custom_menu_item.dart';

class HomeAppMenu extends StatefulWidget {
  const HomeAppMenu({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeAppMenuState createState() => _HomeAppMenuState();
}

class _HomeAppMenuState extends State<HomeAppMenu> with SingleTickerProviderStateMixin {
  bool isOpen = false;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final wScreen = MediaQuery.of(context).size.width;
    final hScreen = MediaQuery.of(context).size.height;
    final authProvider = Provider.of<AuthProvider>(context);
    final role = authProvider.user?.rol ?? 'USER_ROLE';
    final sideBarProvider = Provider.of<SideBarProvider>(context);
    final double anothervalue = (wScreen >= 500) ? 435 : 520;
    final double menuHSize = (role == 'ADMIN_ROLE') ? anothervalue : 220;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
          onTap: () {
            if (isOpen) {
              controller.reverse();
            } else {
              controller.forward();
            }

            setState(() {
              isOpen = !isOpen;
            });
          },
          child: (authProvider.authStatus == AuthStatus.authenticated)
              ? Stack(
                alignment: Alignment.topRight,
                children: [
                  if(isOpen)
                    MouseRegion(
                      cursor: SystemMouseCursors.noDrop,
                      child: Container(width: wScreen, height: hScreen, color: Colors.transparent)),
                  Container(
                      color: const Color(0xFF00041C),
                      width: isOpen ? 180 : 180,
                      height: isOpen ? menuHSize : 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _MenuTitle(isOpen: isOpen, controller: controller),
                          if (isOpen) ...[
                            SeparadorMenuTexto(text: appLocal.configuracionMenuBtn),
                            MenuItemSide(
                                text: appLocal.miCuentaMenuBtn,
                                icon: Icons.person_outline,
                                isActive: sideBarProvider.currentPage == Flurorouter.clienteDash,
                                onPress: () {
                                  NavigatorService.navigateTo(Flurorouter.clienteDash);
                                  isOpen = false;
                                }),
                            if (wScreen < 500)
                              MenuItemSide(
                                  text: appLocal.misCursosLabel,
                                  icon: Icons.person_outline,
                                  isActive: sideBarProvider.currentPage == Flurorouter.clienteMisCursosDash,
                                  onPress: () {
                                    NavigatorService.navigateTo(Flurorouter.clienteMisCursosDash);
                                    isOpen = false;
                                  }),
                            if (authProvider.user!.rol == 'ADMIN_ROLE') ...[
                              const SizedBox(height: 30),
                              const SeparadorMenuTexto(text: 'ADMIN'),
                              MenuItemSide(
                                  text: appLocal.usuariosMenuBtn,
                                  icon: Icons.people_alt_outlined,
                                  isActive: sideBarProvider.currentPage == Flurorouter.usersAdminDash,
                                  onPress: () {
                                    NavigatorService.navigateTo(Flurorouter.usersAdminDash);
                                    isOpen = false;
                                  }),
                              MenuItemSide(
                                  text: appLocal.cursos,
                                  icon: Icons.menu_book_outlined,
                                  isActive: sideBarProvider.currentPage == Flurorouter.cursosAdminDash,
                                  onPress: () {
                                    NavigatorService.navigateTo(Flurorouter.cursosAdminDash);
                                    isOpen = false;
                                  }),
                             
                              MenuItemSide(
                                  text: appLocal.formulariosMenuBtn,
                                  icon: Icons.question_answer,
                                  isActive: sideBarProvider.currentPage == Flurorouter.formsAdminDash,
                                  onPress: () {
                                    NavigatorService.navigateTo(Flurorouter.formsAdminDash);
                                    isOpen = false;
                                  }),
                              MenuItemSide(
                                  text: appLocal.leadsMenuBtn,
                                  icon: Icons.card_giftcard,
                                  isActive: sideBarProvider.currentPage == Flurorouter.leadsAdminDash,
                                  onPress: () {
                                    NavigatorService.navigateTo(Flurorouter.leadsAdminDash);
                                    isOpen = false;
                                  }),
                            ],
                            const SizedBox(
                              height: 30,
                            ),
                            SeparadorMenuTexto(text: appLocal.logoutLabel),
                            MenuItemSide(
                                text: appLocal.logout,
                                icon: Icons.logout_rounded,
                                isActive: false,
                                onPress: () {
                                  authProvider.logOut(context);
                                  
                                }),
                          ]
                        ],
                      ),
                    ),
                ],
              )
              : Stack(
                children: [
                  if(isOpen)
                    Container(width: wScreen, height: hScreen, color: Colors.transparent,),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    alignment: Alignment.center,
                      color: bgColor,
                      
                      width: isOpen ? 200 : 40,
                      height: isOpen ? 310 : 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _MenuTitle(isOpen: isOpen, controller: controller),
                          if (isOpen) ...[
                            CustomMenuItem(
                                padding: 30,
                                width: 240,
                                delay: 0,
                                text: appLocal.inicioMenuBtn,
                                onPressed: () {
                                  if (isOpen) {
                                    controller.reverse();
                                  } else {
                                    controller.forward();
                                  }
                                  setState(() {
                                    isOpen = !isOpen;
                                    NavigatorService.navigateTo('/home');
                                  });
                                }),
                            CustomMenuItem(
                                padding: 30,
                                width: 240,
                                delay: 30,
                                text: appLocal.cursosMenuBtn,
                                onPressed: () {
                                  if (isOpen) {
                                    controller.reverse();
                                  } else {
                                    controller.forward();
                                  }
                                  setState(() {
                                    isOpen = !isOpen;
                                    NavigatorService.navigateTo('/cursos');
                                  });
                                }),
                            CustomMenuItem(
                                padding: 30,
                                width: 240,
                                delay: 60,
                                text: appLocal.serviciosMenuBtn,
                                onPressed: () {
                                  if (isOpen) {
                                    controller.reverse();
                                  } else {
                                    controller.forward();
                                  }
                                  setState(() {
                                    isOpen = !isOpen;
                                    NavigatorService.navigateTo('/servicios');
                                  });
                                }),
                            CustomMenuItem(
                                padding: 30,
                                width: 240,
                                delay: 90,
                                text: appLocal.resultadosMenuBtn,
                                onPressed: () {
                                  if (isOpen) {
                                    controller.reverse();
                                  } else {
                                    controller.forward();
                                  }
                                  setState(() {
                                    isOpen = !isOpen;
                                    NavigatorService.navigateTo('/resultados');
                                  });
                                }),
                            CustomMenuItem(
                                padding: 30,
                                width: 240,
                                delay: 120,
                                text: appLocal.contactoMenuBtn,
                                onPressed: () {
                                  if (isOpen) {
                                    controller.reverse();
                                  } else {
                                    controller.forward();
                                  }
                                  setState(() {
                                    isOpen = !isOpen;
                                    NavigatorService.navigateTo('/contacto');
                                  });
                                }),
                            const SizedBox(height: 8)
                          ]
                        ],
                      ),
                    ),
                    
                ],
              )),
    );
  }
}

class _MenuTitle extends StatelessWidget {
  const _MenuTitle({
    Key? key,
    required this.isOpen,
    required this.controller,
  }) : super(key: key);

  final bool isOpen;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return SizedBox(
      // width: 160,
      height: 50,
      child: (authProvider.authStatus == AuthStatus.authenticated)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: bgColor,
                  radius: 15,
                  backgroundImage: NetworkImage(authProvider.user!.img),
                ),
                const SizedBox(width: 10),
                SizedBox(
                    width: 115,
                    child: Text('${authProvider.user!.nombre} ${authProvider.user!.apellido}',
                        style: DashboardLabel.paragraph.copyWith(color: azulText), overflow: TextOverflow.ellipsis))
              ],
            )
          : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AnimatedIcon(
                size: 30,
                icon: AnimatedIcons.menu_close,
                progress: controller,
                color: azulText,
              ),
              if(isOpen)
              Container(
                margin: const EdgeInsets.only(left: 11, bottom: 1),
                child: const Image(image: logoIso, width: 49,))
            ],
          ),
    );
  }
}
