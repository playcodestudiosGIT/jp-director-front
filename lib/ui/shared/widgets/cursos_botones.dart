import 'package:flutter/material.dart';
import 'package:jpdirector_frontend/constant.dart';
import 'package:jpdirector_frontend/router/router.dart';
import 'package:jpdirector_frontend/services/navigator_service.dart';

import '../../../models/baner.dart';
import '../labels/dashboard_label.dart';

class CursoImagen extends StatelessWidget {
  final Baner baner;
  const CursoImagen({
    super.key,
    required this.baner,
  });

  @override
  Widget build(BuildContext context) {
    final wScreen = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () {
          NavigatorService.navigateTo('${Flurorouter.cursoLanding}/${baner.cursoId}');
        },
        child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              decoration: buildBoxDecoration(),
              child: Stack(
                children: [
                  Image(width: (wScreen < 580) ? 180 : 250, image: NetworkImage(baner.img)),
                  Container(
                    width: (wScreen < 580) ? 180 : 250,
                    height: (wScreen < 580) ? 180 : 250,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.transparent, bgColor.withOpacity(1)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.6, 1])),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextButton(
                            style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(blancoText.withOpacity(0.1))),
                            onPressed: () {
                              NavigatorService.navigateTo('${Flurorouter.cursoLanding}${baner.cursoId}/${'0'}');
                            },
                            child: Text('VER MAS', style: DashboardLabel.mini.copyWith(color: azulText)))
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(color: bgColor.withOpacity(0.7), borderRadius: BorderRadius.circular(0), boxShadow: [
        BoxShadow(
          color: azulText.withOpacity(0.08),
          blurRadius: 20,
          offset: const Offset(0, 0),
        )
      ]);
}
