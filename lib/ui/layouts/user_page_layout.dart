import 'package:flutter/material.dart';
import 'package:jpdirector_frontend/ui/shared/botones/custom_button.dart';

import '../../constant.dart';
import '../../router/router.dart';
import '../../services/navigator_service.dart';
import '../shared/menus/home_app_menu.dart';


class UserPageLayout extends StatefulWidget {
  final Widget child;

  const UserPageLayout({Key? key, required this.child}) : super(key: key);

  @override
  State<UserPageLayout> createState() => _UserPageLayoutState();
}

class _UserPageLayoutState extends State<UserPageLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        children: [
          Container(decoration: buildBoxDecoration(), child: widget.child),
          Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,
            height: 80,
            decoration: buildBoxDecorationAppbar(),
            child: GestureDetector(
              onTap: () {
                NavigatorService.replaceTo(Flurorouter.homeRoute);
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: 200,
                  child: const Image(image: logoJp),
                ),
              ),
            ),
          ),
          const Positioned(right: 20, top: 20, child: Stack(
            children: [
              HomeAppMenu(),
              // Container(width: 200, height: 200, color: Colors.black,),
            ],
          )),
          Positioned(
              right: 80,
              top: 28,
              child: CustomButton(
                text: 'LOG IN',
                width: 70,
                onPress: () {
                  NavigatorService.replaceTo(Flurorouter.loginRoute);
                },
              )),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() =>
      const BoxDecoration(gradient: LinearGradient(colors: [bgColor, bgColor], begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: [0.5, 0.5]));

  BoxDecoration buildBoxDecorationAppbar() => const BoxDecoration(color: Color(0xFF00041C), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]);
}
