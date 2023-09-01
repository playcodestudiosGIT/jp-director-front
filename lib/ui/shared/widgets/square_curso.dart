import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../models/curso.dart';
import '../../../providers/export_all_providers.dart';
import '../botones/custom_button.dart';
import '../labels/dashboard_label.dart';

class SquareCurso extends StatefulWidget {
  final Curso? curso;
  final String userId;
  const SquareCurso({
    super.key,
    this.curso,
    required this.userId,
  });

  @override
  State<SquareCurso> createState() => _SquareCursoState();
}

class _SquareCursoState extends State<SquareCurso> {
  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.all(8),
      constraints: const BoxConstraints(maxWidth: 420),
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      height: 60,
      child: Row(children: [
        Icon(Icons.menu_book_outlined, color: Colors.white.withOpacity(0.3), size: 15,),
        const SizedBox(width: 10),
        Text(
          widget.curso!.nombre,
          style: DashboardLabel.paragraph.copyWith(color: Colors.white.withOpacity(0.3)),
        ),
        const Spacer(),
        IconButton(
            onPressed: () async {
              final isOk = await showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text(appLocal.eliminarCurso),
                        content: Text('${appLocal.seguroEliminarCurso} ${widget.curso!.nombre}'),
                        actions: [
                          CustomButton(
                            text: appLocal.siBorrar,
                            onPress: () async {
                              await Provider.of<AllCursosProvider>(context, listen: false)
                                  .deleteCursoToUser(userId: widget.userId, cursoId: widget.curso!.id);
                              if (context.mounted) {
                                Navigator.pop(context, true);
                              }
                            },
                            width: 100,
                            color: Colors.red.withOpacity(0.3),
                          ),
                          CustomButton(
                            text: appLocal.cancelarBtn,
                            onPress: () {
                              Navigator.pop(context, false);
                            },
                            width: 100,
                          )
                        ],
                      ));
              if (isOk) {
                if (context.mounted) Navigator.pop(context, true);
              }
            },
            icon: const Center(
              child: Icon(
                Icons.delete,
                color: Colors.red,
                size: 16,
              ),
            ))
      ]),
    );
  }
}