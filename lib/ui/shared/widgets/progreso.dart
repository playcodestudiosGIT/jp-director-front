import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../models/curso.dart';
import '../../../models/progress.dart';
import '../../../providers/auth_provider.dart';
import '../labels/dashboard_label.dart';

class MiProgreso extends StatelessWidget {
  final Curso curso;
  const MiProgreso({super.key, required this.curso});

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final ids = [];
    final List<Progress> progresses = [];

    for (var i in curso.modulos) {
      ids.add(i.id);
    }

    for (var i in ids) {
      progresses.add(authProvider.user!.progress.where((element) => element.moduloId == i).first);
    }

    final total = progresses.length;
    final pont = progresses.where((element) => element.isComplete).length;

    final percent = pont / total * 100;
    return Container(
      padding: const EdgeInsets.only(left: 7),
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(appLocal.progreso2puntos, style: DashboardLabel.mini.copyWith(color: blancoText)),
              Text('${percent.toStringAsFixed(0)} %', style: DashboardLabel.mini.copyWith(color: blancoText)),
            ],
          ),
          const SizedBox(width: double.infinity, height: 8),
          SizedBox(
            width: 220,
            child: LinearProgressIndicator(
              value: pont / total,
    
              color: azulText,
              backgroundColor: Colors.white.withOpacity(0.3),
    
              // valueColor: ,
            ),
          ),
        ],
      ),
    );
  }
}
