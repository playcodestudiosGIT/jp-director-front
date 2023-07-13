import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../providers/auth_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import 'custom_menu_item.dart';

class HomeAppMenu extends StatefulWidget {
  const HomeAppMenu({super.key});

  @override
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
    final authProvider = Provider.of<AuthProvider>(context);
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
              ? Container(
                  color: const Color(0xFF00041C),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: isOpen ? 200 : 160,
                  height: isOpen ? 360 : 60,
                  child: Column(
                    children: [
                      _MenuTitle(isOpen: isOpen, controller: controller),
                      if (isOpen) ...[
                        CustomMenuItem(
                            delay: 0,
                            text: 'Inicio',
                            onPressed: () {
                              if (isOpen) {
                                controller.reverse();
                              } else {
                                controller.forward();
                              }
                              setState(() {
                                isOpen = !isOpen;
                                NavigatorService.replaceTo('/home');
                              });
                            }),
                        CustomMenuItem(
                            delay: 30,
                            text: 'Ads',
                            onPressed: () {
                              if (isOpen) {
                                controller.reverse();
                              } else {
                                controller.forward();
                              }
                              setState(() {
                                isOpen = !isOpen;
                                NavigatorService.navigateTo('/ads');
                              });
                            }),
                        CustomMenuItem(
                            delay: 60,
                            text: 'Servicios',
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
                            delay: 90,
                            text: 'Resultados',
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
                            delay: 120,
                            text: 'Contacto',
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
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton.icon(
                                label: Text(
                                  'CURSOS',
                                  style: GoogleFonts.roboto(fontSize: 10, color: azulText),
                                ),
                                onPressed: () {
                                  setState(() {
                                    isOpen = !isOpen;
                                    NavigatorService.navigateTo(Flurorouter.clienteMisCursosDash);
                                  });
                                },
                                icon: const Icon(
                                  Icons.menu_book_outlined,
                                  size: 12,
                                  color: azulText,
                                )),
                            TextButton.icon(
                                label: Text(
                                  'SALIR',
                                  style: GoogleFonts.roboto(fontSize: 10, color: azulText),
                                ),
                                onPressed: () {
                                  authProvider.logOut();
                                  isOpen = !isOpen;
                                },
                                icon: const Icon(
                                  Icons.logout,
                                  size: 12,
                                  color: azulText,
                                )),
                          ],
                        ),
                        const SizedBox(height: 8)
                      ]
                    ],
                  ),
                )
              : Container(
                  color: const Color(0xFF00041C),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: isOpen ? 130 : 130,
                  height: isOpen ? 310 : 60,
                  child: Column(
                    children: [
                      _MenuTitle(isOpen: isOpen, controller: controller),
                      if (isOpen) ...[
                        CustomMenuItem(
                            delay: 0,
                            text: 'Inicio',
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
                            delay: 30,
                            text: 'Ads',
                            onPressed: () {
                              if (isOpen) {
                                controller.reverse();
                              } else {
                                controller.forward();
                              }
                              setState(() {
                                isOpen = !isOpen;
                                NavigatorService.navigateTo('/ads');
                              });
                            }),
                        CustomMenuItem(
                            delay: 60,
                            text: 'Servicios',
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
                            delay: 90,
                            text: 'Resultados',
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
                            delay: 120,
                            text: 'Contacto',
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
      width: 260,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            width: 0,
          ),
          if (authProvider.authStatus == AuthStatus.authenticated)
            CircleAvatar(
              backgroundImage: NetworkImage(authProvider.user!.img ?? noimage),
            ),
          const SizedBox(
            width: 15,
          ),
          AnimatedIcon(
            size: 40,
            icon: AnimatedIcons.menu_close,
            progress: controller,
            color: blancoText,
          )
        ],
      ),
    );
  }
}
