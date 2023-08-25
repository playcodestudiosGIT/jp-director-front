import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/constant.dart';

import '../../generated/l10n.dart';
import 'labels/dashboard_label.dart';
import 'widgets/testimonio.dart';

class ListTestimonios extends StatelessWidget {
  const ListTestimonios({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final List<Widget> listTestimonio = [
      Testimonio(
        img:
            'https://static.wixstatic.com/media/b69ab8_f97ce7c31e2d4208a8c6a3bc7a34f661~mv2.png/v1/fill/w_200,h_200,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/image%204.png',
        nombre: 'Saylin Vazquez de Alltech',
        testimonio: appLocal.testimonioSaylin,
      ),
      Testimonio(
        img:
            'https://static.wixstatic.com/media/b69ab8_bfb7361501fa4e6cab4a6e7335f5aff5~mv2.png/v1/fill/w_200,h_200,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/image%206.png',
        nombre: 'Anier Cruz',
        testimonio:
            appLocal.testimonioAnier,
      ),
      Testimonio(
        img:
            'https://static.wixstatic.com/media/b69ab8_cd0d5d47774a490095e8f7fd9243b853~mv2.png/v1/fill/w_200,h_200,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/image%207.png',
        nombre: 'Tania Crespo',
        testimonio: appLocal.testimonioTania,
      ),
      Testimonio(
        img:
            'https://static.wixstatic.com/media/b69ab8_ce68c5011d4f41a08e14db52ebad8c05~mv2.png/v1/fill/w_200,h_200,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/image%205.png',
        nombre: 'German Gamboa',
        testimonio:
            appLocal.testimonioGerman,
      ),
    ];
    return Column(
      children: [
        Text(appLocal.ellosVivieronMision, style: DashboardLabel.h1),
        Text(appLocal.quieroAds, style: DashboardLabel.h1),
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
        Text(appLocal.estudiantes, style: DashboardLabel.h1.copyWith(color: const Color(0xffFFEF98))),
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


