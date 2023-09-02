import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jp_director/constant.dart';
import 'package:jp_director/ui/shared/widgets/testimonio_widget.dart';

import '../../../generated/l10n.dart';
import '../labels/dashboard_label.dart';

class ListTestimonios extends StatelessWidget {
  final List testimonios;
  final String numeroEst;
  const ListTestimonios({super.key, required this.numeroEst, required this.testimonios});

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final List <TestimonioWidget> listTestimonio = testimonios.map((e) => TestimonioWidget(img: e.img, nombre: e.nombre, testimonio: e.testimonio),).toList();
    return Column(
      children: (numeroEst == '0')
          ? []
          : [
              Text(appLocal.ellosVivieronMision, style: DashboardLabel.h1),
              Text(appLocal.quieroAds, style: DashboardLabel.h1),
              Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text('+', style: DashboardLabel.gigant.copyWith(fontSize: 80, color: const Color(0xffFFEF98))),
                      Text(
                        numeroEst,
                        style: GoogleFonts.raleway(fontSize: 85, fontWeight: FontWeight.bold, color: blancoText),
                      )
                    ])
                  ])),
              Text(appLocal.estudiantes, style: DashboardLabel.h1.copyWith(color: const Color(0xffFFEF98))),
              const SizedBox(height: 60),
              if (listTestimonio.isNotEmpty)
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
