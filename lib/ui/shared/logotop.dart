import 'package:flutter/material.dart';


import '../../constant.dart';
import '../../router/router.dart';
import '../../services/navigator_service.dart';

class LogoTop extends StatelessWidget {
  const LogoTop({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorService.replaceTo(Flurorouter.homeRoute);
      },
      child: const MouseRegion(
        cursor: SystemMouseCursors.click,
        child: SizedBox(
          width: 230,
          child: Image(
            image: logoJp,
          ),
        ),
      ),
    );
  }
}
