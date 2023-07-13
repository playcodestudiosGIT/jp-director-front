import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jpdirector_frontend/constant.dart';
import 'package:jpdirector_frontend/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import 'package:jpdirector_frontend/ui/shared/appbar_top.dart';
import 'package:jpdirector_frontend/ui/shared/menus/home_app_menu.dart';
import 'package:jpdirector_frontend/ui/shared/sidebar.dart';

import '../../providers/all_cursos_provider.dart';
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
    final isAparece = Provider.of<SideBarProvider>(context).isAparece;
    final wScreen = MediaQuery.of(context).size.width;
    final hScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          Container(
              constraints: BoxConstraints(maxWidth: wScreen, maxHeight: hScreen),
              child: Row(children: [if (wScreen >= 715 && isAparece) const SideBar(), Expanded(child: widget.child)])),
          if (wScreen < 715)
            AnimatedBuilder(
                animation: SideBarProvider.menuController,
                builder: (context, _) => Stack(
                      children: [
                        if (SideBarProvider.isOpen) ...[
                          BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                            child: Opacity(
                              opacity: SideBarProvider.opacity.value,
                              child: GestureDetector(
                                onTap: () => SideBarProvider.closeMenu(),
                                child: Container(
                                  width: wScreen,
                                  height: hScreen,
                                  color: Colors.black26,
                                ),
                              ),
                            ),
                          ),
                        ],
                        Transform.translate(offset: Offset(SideBarProvider.movement.value, 0), child: (isAparece) ? const SideBar() : null)
                      ],
                    )),
          const AppbarTop(),
          const Positioned(
              right: 0,
              top: 15,
              child: Stack(
                children: [
                  HomeAppMenu(),
                  // Container(width: 200, height: 200, color: Colors.black,),
                ],
              )),
        ],
      ),
    );
  }
}
