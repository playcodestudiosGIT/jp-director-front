import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../models/modulo.dart';
import '../../../providers/export_all_providers.dart';
import '../botones/custom_button.dart';
import '../labels/dashboard_label.dart';
import '../modals/new_module_dialog.dart';

class SquareModulo extends StatefulWidget {
  final String cursoID;
  final Modulo? modulo;
  const SquareModulo({
    super.key,
    this.modulo, required this.cursoID,
    
  });

  @override
  State<SquareModulo> createState() => _SquareModuloState();
}

class _SquareModuloState extends State<SquareModulo> {
  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      color: azulText.withOpacity(0.1),
      constraints: const BoxConstraints(maxWidth: 400, minWidth: 315),
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
        Icon(
          Icons.view_module,
          color: Colors.white.withOpacity(0.3),
          size: 16,
        ),
        const SizedBox(width: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 270,
              child: Row(
                children: [
                  Text(
                    widget.modulo!.nombre,
                    style: DashboardLabel.h4,
                  ),
                  const SizedBox(width: 15),
                  Icon(Icons.videocam_sharp, color: (widget.modulo!.video.isEmpty) ? Colors.red : Colors.green, size: 16),
                  const SizedBox(width: 5),
                  Icon(Icons.folder_copy_sharp, color: (widget.modulo!.idDriveFolder.isEmpty) ? Colors.red : Colors.green, size: 16),
                  const SizedBox(width: 5),
                  Icon(Icons.download_sharp, color: (widget.modulo!.idDriveZip.isEmpty) ? Colors.red : Colors.green, size: 16),
                  const SizedBox(width: 5),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
                width: 270,
                child: Text(
                  widget.modulo!.descripcion,
                  overflow: TextOverflow.fade,
                  style: DashboardLabel.mini.copyWith(color: blancoText.withOpacity(0.5)),
                ))
          ],
        ),
        const Spacer(),
        IconButton(
            splashRadius: 16,
            onPressed: () async {
              final isok = await showDialog(
                  context: context,
                  builder: (context) => NewModuleDialog(
                        cursoID: widget.cursoID,
                        modulo: widget.modulo,
                      ));
              if (isok && context.mounted) {
                setState(() {});
              }
            },
            icon: const Icon(
              Icons.edit,
              color: azulText,
              size: 16,
            )),
        IconButton(
            splashRadius: 16,
            onPressed: () async {
              await showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => AlertDialog(
                        backgroundColor: bgColor,
                        title: Text(appLocal.eliminarModulo),
                        content: Text('${appLocal.seguroEliminarModulo}${widget.modulo!.nombre}'),
                        actions: [
                          CustomButton(
                            text: appLocal.siBorrar,
                            onPress: () async {
                              await Provider.of<AllCursosProvider>(context, listen: false).deleteModulo(widget.modulo!.id);
                              if (context.mounted) {
                                Navigator.pop(context, true);
                              }
                            },
                            width: 100,
                            color: Colors.green,
                          ),
                          CustomButton(
                            color: Colors.red,
                            text: appLocal.cancelarBtn,
                            onPress: () {
                              Navigator.pop(context, false);
                            },
                            width: 100,
                          )
                        ],
                      ));
            },
            icon: const Icon(
              Icons.clear,
              color: Colors.red,
              size: 16,
            ))
      ]),
    );
  }
}