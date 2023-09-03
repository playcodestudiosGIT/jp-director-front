import 'package:flutter/material.dart';
import 'package:jp_director/providers/leads_provider.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import '../generated/l10n.dart';
import '../models/lead.dart';
import '../services/notificacion_service.dart';
import '../ui/shared/labels/dashboard_label.dart';
import '../ui/shared/modals/leads_modal.dart';

class LeadsDTS extends DataTableSource {
  List<Lead> leads;
  final BuildContext context;

  LeadsDTS(this.leads, this.context);

  @override
  DataRow getRow(int index) {
    final appLocal = AppLocalizations.of(context);
    final lead = leads[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(
        Column(
        children: [
          Row(
            children: [
              Text('${appLocal.correoForm}:  ', style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5))),
              Text(lead.email),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text('${appLocal.telefonoForm}:  ', style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5))),
              Text(lead.telf),
            ],
          ),
        ],
      )),
      DataCell(Row(
        children: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => LeadsModal(lead: lead),
                );
              },
              icon: const Icon(
                Icons.edit_outlined,
                size: 18,
                color: azulText,
              )),
          IconButton(onPressed: () {}, icon: const Icon(Icons.email_outlined, color: blancoText, size: 18,)),
          IconButton(
              onPressed: () {
                final dialog = AlertDialog(
                  title: Text(appLocal.seguroBorrar),
                  content: Text('${appLocal.borrarDefinitivo} Lead "${lead.email}"'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('No')),
                    TextButton(
                        onPressed: () async {
                          //BORRAR USUARIO
                          final isDelete = await Provider.of<LeadsProvider>(context, listen: false).deleteLead(lead.uid);
                          if (isDelete != null && context.mounted) {
                            Navigator.of(context).pop();
                            NotifServ.showSnackbarError('Lead "${lead.email}" ${appLocal.eliminado}', Colors.green);
                          } else {
                            if (context.mounted)Navigator.of(context).pop();
                            NotifServ.showSnackbarError(appLocal.errorEliminadoLead, Colors.red);
                          }
                        },
                        child: Text(appLocal.siBorrar))
                  ],
                );
                showDialog(
                  context: context,
                  builder: (context) => dialog,
                );
              },
              icon: Icon(
                Icons.delete_outline,
                size: 18,
                color: Colors.red.withOpacity(0.8),
              )),
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => leads.length;

  @override
  int get selectedRowCount => 0;
}













// 
