import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import 'logotop.dart';
import 'menu_item_top.dart';


class AppbarTop extends StatelessWidget {
  const AppbarTop({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final wScreen = MediaQuery.of(context).size.width;
    return Container(
        width: wScreen,
        alignment: Alignment.centerLeft,
        height: 60,
        decoration: buildBoxDecoration(),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            
            const LogoTop(), 
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if(wScreen >= 500)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    width: 110,
                    alignment: Alignment.center,
                    child: MenuItemTop(text: appLocal.misCursosMenuBtn, isActive: false, onPress: () {
                      NavigatorService.navigateTo(Flurorouter.clienteMisCursosDash);
                    }),
                  ),
                ),
                const SizedBox(width: 200, height: 10),
              ],
            ),
          ],
        ));
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(color: Color(0xFF00041C), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]);
}
