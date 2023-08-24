import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/constant.dart';

import 'labels/dashboard_label.dart';
import 'widgets/testimonio.dart';

class ListTestimonios extends StatelessWidget {
  const ListTestimonios({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Ellos vivieron la misión', style: DashboardLabel.h1),
        Text('Quiero Ads', style: DashboardLabel.h1),
        Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('+', style: DashboardLabel.gigant.copyWith(fontSize: 80, color: const Color(0xffFFEF98))),
                Text(
                  '250',
                  style: GoogleFonts.raleway(fontSize: 85, fontWeight: FontWeight.bold, color: blancoText),
                )
              ])
            ])),
        Text('estudiantes', style: DashboardLabel.h1.copyWith(color: const Color(0xffFFEF98))),
        const SizedBox(height: 60),
        Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: listTestimonio,
              )),
        ),
      ],
    );
  }
}

final List<Widget> listTestimonio = [
      const Testimonio(
        img:
            'https://static.wixstatic.com/media/b69ab8_f97ce7c31e2d4208a8c6a3bc7a34f661~mv2.png/v1/fill/w_200,h_200,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/image%204.png',
        nombre: 'Saylin Vazquez de Alltech',
        testimonio: '“Me ha encantado, es muy completo y un mundo de conocimiento. Para mi negocio este curso logró un antes y un después”.',
      ),
      const Testimonio(
        img:
            'https://static.wixstatic.com/media/b69ab8_bfb7361501fa4e6cab4a6e7335f5aff5~mv2.png/v1/fill/w_200,h_200,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/image%206.png',
        nombre: 'Anier Cruz',
        testimonio:
            '“Estudié informática y un montón de educación. Luego de ver el curso no solo recuperé mi inversión sino que además puedo correr mis propia publicidad, gracias JP”.',
      ),
      const Testimonio(
        img:
            'https://static.wixstatic.com/media/b69ab8_cd0d5d47774a490095e8f7fd9243b853~mv2.png/v1/fill/w_200,h_200,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/image%207.png',
        nombre: 'Tania Crespo',
        testimonio: '“Tengo ideas y planes para desarrollar por 6 meses gracias a este curso. Todo el que lo vea entenderá luego de aprender con JP”',
      ),
      const Testimonio(
        img:
            'https://static.wixstatic.com/media/b69ab8_ce68c5011d4f41a08e14db52ebad8c05~mv2.png/v1/fill/w_200,h_200,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/image%205.png',
        nombre: 'German Gamboa',
        testimonio:
            '“En 1 mes logré tener más de 100 clientes potenciales con mis campañas de publicidad. A todo el que quiera aprender le recomiendo este curso.”',
      ),
    ];
