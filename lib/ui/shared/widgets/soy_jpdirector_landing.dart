import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../labels/dashboard_label.dart';

class SoyJpdirectorLanding extends StatelessWidget {
  const SoyJpdirectorLanding({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Wrap(children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 400, minWidth: 300),
              child: Column(
                children: [
                  Text('Soy JP Director', style: DashboardLabel.h1.copyWith(color: const Color(0xffFFEF98))),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Desde hace 4 años me dedico a potenciar marcas y negocios con estrategias efectivas en ads que dan en el punto. \n\nEn todo el proceso he manejado una cantidad de \$1.000.000 USD en campañas publicitarias, logrando \$15.000.000 USD en ventas por internet. Luego de innumerables pruebas, análisis y educación, decidí realizar esta experiencia grupal para enseñarle a emprendedores, dueños de negocio o equipos de marketing a entender el motor que es realizar campañas publicitarias.',
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