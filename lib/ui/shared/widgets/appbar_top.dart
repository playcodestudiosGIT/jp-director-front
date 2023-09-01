import 'package:flutter/material.dart';
import '../../../constant.dart';
import 'logotop.dart';

class AppbarTop extends StatelessWidget {
  const AppbarTop({super.key});

  @override
  Widget build(BuildContext context) {
    final wScreen = MediaQuery.of(context).size.width;
    return Container(
        width: wScreen,
        alignment: Alignment.centerLeft,
        height: 60,
        decoration: buildBoxDecoration(),
        child: const Stack(
          alignment: Alignment.centerLeft,
          children: [
           
            
            SizedBox(width: double.infinity),
            LogoTop(),
          ],
        ));
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(color: bgColor, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]);
}
