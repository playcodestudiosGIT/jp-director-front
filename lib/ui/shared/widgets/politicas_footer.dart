import 'package:flutter/material.dart';
import 'package:jp_director/router/router.dart';
import 'package:jp_director/services/navigator_service.dart';


import '../../../constant.dart';
import '../../../generated/l10n.dart';


class PoliticasFooter extends StatelessWidget {
  const PoliticasFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    return Center(
      child: Container(
          constraints: const BoxConstraints(maxWidth: 315),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Text(
                appLocal.alIniciarSesion,
                textAlign: TextAlign.center,
                style: const TextStyle(color: blancoText, fontSize: 16, fontWeight: FontWeight.w400),
              ),
              InkWell(
                onTap: () {
                  NavigatorService.navigateTo(Flurorouter.tycRoute);
                },
                child: Text(
                  appLocal.terminoDeUso,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: azulText, fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
              Text(
                appLocal.yReconocesQue,
                textAlign: TextAlign.center,
                style: const TextStyle(color: blancoText, fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Text(
                appLocal.nuestra,
                textAlign: TextAlign.center,
                style: const TextStyle(color: blancoText, fontSize: 16, fontWeight: FontWeight.w400),
              ),
              InkWell(
                onTap: () {
                  NavigatorService.navigateTo(Flurorouter.pdpRoute);
                },
                child: Text(
                  appLocal.politicaDePrivacidad,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: azulText, fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          )),
    );
  }
}
