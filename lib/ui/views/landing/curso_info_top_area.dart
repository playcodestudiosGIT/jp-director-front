import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../models/curso.dart';
import '../../shared/labels/dashboard_label.dart';
import '../../shared/widgets/curso_baner.dart';

class CursoInfoTopArea extends StatelessWidget {
  final Curso curso;
  final bool esMio;
  const CursoInfoTopArea({super.key, required this.curso, required this.esMio});

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    return Column(
      children: [
        CursoBanerView(curso: curso, esMio: esMio),
        const SizedBox(height: 30),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          constraints: const BoxConstraints(maxWidth: 800),
          width: double.infinity,
          child: Text(
            appLocal.actualizado2023,
            style: DashboardLabel.h4.copyWith(color: const Color(0xffFFEF98), fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 15),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          constraints: const BoxConstraints(maxWidth: 800),
          child: Text(
            curso.descripcion,
            textAlign: TextAlign.start,
            style: DashboardLabel.h4.copyWith(height: 1.4, color: blancoText.withOpacity(0.5)),
          ),
        ),
      ],
    );
  }
}
