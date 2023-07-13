import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/models/formulario.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import '../providers/form_provider.dart';
import '../services/notificacion_service.dart';
import '../ui/shared/modals/form_modal.dart';

class FormsDTS extends DataTableSource {
  List<Formulario> forms;
  final BuildContext context;

  FormsDTS(this.forms, this.context);

  @override
  DataRow getRow(int index) {
    final form = forms[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            form.rootform.toUpperCase(),
            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          const SizedBox(height: 4),
          Text('Nombre: ${form.nombre}'),
          const Divider(),
          const SizedBox(height: 4),
          Text('Email: ${form.email}'),
          const Divider(),
          const SizedBox(height: 4),
          Text('Telefono:  ${form.phone}'),
          const Divider(),
          const SizedBox(height: 4),
          Text('Negocio:   ${form.business}'),
          const Divider(),
          const SizedBox(height: 4),
          Text('Años de Operaciones:   ${form.operationyears}'),
          const Divider(),
          const SizedBox(height: 4),
          Text('Nivel de Publicidad:   ${form.advertisinglevel}'),
          const Divider(),
          Row(
            children: [
              const Text('Advertising Before   '),
              Checkbox(value: form.advertisingbefore, onChanged: null),
            ],
          ),
          const Divider(),
          Row(
            children: [
              const Text('Acepto:  '),
              Text(form.agree),
            ],
          ),
        ],
      )),
      DataCell(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(form.facebookurl),
          const Divider(),
          Text(form.instagramurl),
          const Divider(),
          Text(form.tiktokurl),
          const Divider(),
        ],
      )),
      DataCell(Row(
        children: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => FormsModal(form: form),
                );
              },
              icon: const Icon(
                Icons.edit_outlined,
                size: 16,
                color: bgColor,
              )),
          IconButton(
              onPressed: () {
                final dialog = AlertDialog(
                  title: const Text('Borrar formulario'),
                  content: Text('Borrar definitivamente el formulario "${form.email}"'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('No')),
                    TextButton(
                        onPressed: () {
                          //BORRAR USUARIO
                          Provider.of<FormProvider>(context, listen: false).deleteForm(form.uid);
                          Navigator.of(context).pop();
                          NotificationServices.showSnackbarError('Lead "${form.email}" Eliminado', Colors.green);
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
          IconButton(onPressed: () {}, icon: const Icon(Icons.email_outlined)),
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => forms.length;

  @override
  int get selectedRowCount => 0;
}













// 
