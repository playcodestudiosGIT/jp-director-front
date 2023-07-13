import 'package:flutter/material.dart';
import 'package:jpdirector_frontend/ui/shared/logotop.dart';

class AppbarTop extends StatelessWidget {
  const AppbarTop({super.key});

  @override
  Widget build(BuildContext context) {
    final wScreen = MediaQuery.of(context).size.width;
    return Container(
        width: wScreen,
        alignment: Alignment.centerLeft,
        height: 80,
        decoration: buildBoxDecoration(),
        child: const Stack(
          children: [
            Positioned(left: 0, top: 0, child: LogoTop()),
          ],
        ));
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      color: Color(0xFF00041C),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]);
}
