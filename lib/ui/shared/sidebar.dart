import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import '../../providers/auth_provider.dart';
import '../../providers/sidebar_provider.dart';
import '../../router/router.dart';
import '../../services/navigator_service.dart';
import 'widgets/menu_item_side.dart';
import 'widgets/text_separador_menu.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  void navigateTo(String routeName) {
    NavigatorService.replaceTo(routeName);
    SideBarProvider.closeMenu();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final sideBarProvider = Provider.of<SideBarProvider>(context);
    final wScreen = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(top: 100),
      decoration: buildBoxDecoration(),
      width: 200,
      height: double.infinity,
      child: Stack(children: [
        SizedBox(
          width: 160,
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              const SizedBox(
                height: 20,
              ),
              const SeparadorMenuTexto(text: 'ESCRITORIO'),
              MenuItemSide(
                  text: 'Mi Cuenta',
                  icon: Icons.person_outline,
                  isActive: sideBarProvider.currentPage == Flurorouter.clienteDash,
                  onPress: () => navigateTo(Flurorouter.clienteDash)),
              MenuItemSide(
                  text: 'Mis Cursos',
                  icon: Icons.local_library_outlined,
                  isActive: sideBarProvider.currentPage == Flurorouter.clienteMisCursosDash,
                  onPress: () => navigateTo(Flurorouter.clienteMisCursosDash)),
              const SizedBox(
                height: 50,
              ),
              if (authProvider.authStatus == AuthStatus.authenticated && authProvider.user!.rol == 'ADMIN_ROLE') ...[
                const SeparadorMenuTexto(text: 'ADMIN'),
                MenuItemSide(
                    text: 'Usuarios',
                    icon: Icons.supervised_user_circle_outlined,
                    isActive: sideBarProvider.currentPage == Flurorouter.usersAdminDash,
                    onPress: () => navigateTo(Flurorouter.usersAdminDash)),
                MenuItemSide(
                    text: 'Cursos',
                    icon: Icons.menu_book_outlined,
                    isActive: sideBarProvider.currentPage == Flurorouter.cursosAdminDash,
                    onPress: () => navigateTo(Flurorouter.cursosAdminDash)
                    ),
                
                MenuItemSide(
                    text: 'Baners',
                    icon: Icons.style_outlined,
                    isActive: sideBarProvider.currentPage == Flurorouter.banersAdminDash,
                    onPress: () => navigateTo(Flurorouter.banersAdminDash)
                    ),

                    MenuItemSide(
                    text: 'Leads',
                    icon: Icons.email_outlined,
                    isActive: sideBarProvider.currentPage == Flurorouter.leadsAdminDash,
                    onPress: () => navigateTo(Flurorouter.leadsAdminDash)
                    ),

                    MenuItemSide(
                    text: 'Formularios',
                    icon: Icons.format_list_numbered_outlined,
                    isActive: sideBarProvider.currentPage == Flurorouter.formsAdminDash,
                    onPress: () => navigateTo(Flurorouter.formsAdminDash)
                    ),
                const SizedBox(
                  height: 50,
                ),
              ],
              const SeparadorMenuTexto(text: 'SALIR'),
              MenuItemSide(
                  text: 'Logout',
                  icon: Icons.logout_rounded,
                  isActive: false,
                  onPress: () {
                    authProvider.logOut();
                  }),
            ],
          ),
        ),
        if (wScreen < 715)
          Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: (SideBarProvider.isOpen)
                    ? const Icon(
                        Icons.close,
                        color: azulText,
                        size: 22,
                      )
                    : const Icon(
                        Icons.dashboard,
                        color: azulText,
                        size: 22,
                      ),
                onPressed: () {
                  SideBarProvider.toggleMenu();
                },
              )),
      ]),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(color: Color(0xFF00041C), boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)]);
}
