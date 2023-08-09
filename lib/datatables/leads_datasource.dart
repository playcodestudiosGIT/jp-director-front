import 'package:flutter/material.dart';
import 'package:jpdirector_frontend/providers/leads_provider.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import '../models/lead.dart';
import '../services/notificacion_service.dart';
import '../ui/shared/modals/leads_modal.dart';

class LeadsDTS extends DataTableSource {
  List<Lead> leads;
  final BuildContext context;

  LeadsDTS(this.leads, this.context);

  @override
  DataRow getRow(int index) {
    final lead = leads[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Column(
        children: [
          Text(lead.email),
          const SizedBox(height: 10),
          Text(lead.telf),
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
                size: 16,
                color: bgColor,
              )),
          IconButton(onPressed: () {}, icon: const Icon(Icons.email_outlined)),
          IconButton(
              onPressed: () {
                final dialog = AlertDialog(
                  title: const Text('Esta seguro de borrar'),
                  content: Text('Borrar definitivamente el usuario "${lead.email}"'),
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
                            NotifServ.showSnackbarError('Lead "${lead.email}" Eliminado', Colors.green);
                          } else {
                            Navigator.of(context).pop();
                            NotifServ.showSnackbarError('Error Eliminando Usuario', Colors.red);
                          }
                        },
                        child: const Text('Si, Borrar'))
                  ],
                );
                showDialog(
                  context: context,
                  builder: (context) => dialog,
                );
              },
              icon: Icon(
                Icons.delete_outline,
                size: 16,
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
