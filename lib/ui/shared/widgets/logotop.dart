import 'package:flutter/material.dart';


import '../../../constant.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';


class LogoTop extends StatelessWidget {
  const LogoTop({super.key});

  @override
  Widget build(BuildContext context) {
    final wSize = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        NavigatorService.replaceTo(Flurorouter.clienteMisCursosDash);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: SizedBox(
          width: (wSize < 400) ? 80 : 200,
          child: Image(
            image: (wSize < 400) ?logoIso :logoJp,
          ),
        ),
      ),
    );
  }
}
