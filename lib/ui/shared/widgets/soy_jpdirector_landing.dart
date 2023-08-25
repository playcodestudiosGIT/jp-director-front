import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../labels/dashboard_label.dart';

class SoyJpdirectorLanding extends StatelessWidget {
  const SoyJpdirectorLanding({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    return Column(children: [
      Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Wrap(children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 400, minWidth: 300),
              child: Column(
                children: [
                  Text(appLocal.soyJpDir, style: DashboardLabel.h1.copyWith(color: const Color(0xffFFEF98))),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    appLocal.desdeHace4,
                    style: DashboardLabel.h4.copyWith(height: 1.4, color: blancoText.withOpacity(0.5)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Container(
                constraints: const BoxConstraints(maxWidth: 400, minWidth: 300),
                child: const Image(
                    image: NetworkImage(
                        'https://static.wixstatic.com/media/b69ab8_f5760d9dc3e54e7497e4c4d419c95cd2~mv2.png/v1/fill/w_508,h_674,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/DSC032987.png')))
          ]),
        ),
        const SizedBox(height: 60),
    ],);
  }
}