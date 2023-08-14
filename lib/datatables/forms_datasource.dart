import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          Row(
            children: [
              Text(
                'Servicio:  ',
                style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.bold, color: blancoText.withOpacity(0.5)),
              ),
              Text(
                form.rootform.toUpperCase(),
                style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('Nombre:  ', style: TextStyle(color: blancoText.withOpacity(0.5)),),
              Text(form.nombre),
              
            ],
          ),
          const Divider(),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('Email:  ', style: TextStyle(color: blancoText.withOpacity(0.5))),
              Text(form.email),
              const Spacer(),
              Icon(Icons.copy, size: 15, color: blancoText.withOpacity(0.5),)
            ],
          ),
          const Divider(),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('Teléfono:  ', style: TextStyle(color: blancoText.withOpacity(0.5))),
              Text(form.phone),
            ],
          ),
          const Divider(),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('Negocio:   ', style: TextStyle(color: blancoText.withOpacity(0.5))),
              Text(form.business),
            ],
          ),
          const Divider(),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('Años de Operaciones:   ', style: TextStyle(color: blancoText.withOpacity(0.5))),
              Text(form.operationyears),
            ],
          ),
          const Divider(),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('Nivel de Publicidad:   ', style: TextStyle(color: blancoText.withOpacity(0.5))),
              Text(form.advertisinglevel),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Text('Advertising Before   ', style: TextStyle(color: blancoText.withOpacity(0.5))),
              if(form.advertisingbefore) const Text('SI'),
              if(!form.advertisingbefore) const Text('NO')
            ],
          ),
          const Divider(),
          Row(
            children: [
              Text('Acepto:  ', style: TextStyle(color: blancoText.withOpacity(0.5))),
              Text(form.agree.toUpperCase()),
            ],
          ),
        ],
      )),
      DataCell(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(FontAwesomeIcons.facebook, color: blancoText.withOpacity(0.5),),
              const SizedBox(width: 15), 
              Text(form.facebookurl),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Icon(FontAwesomeIcons.instagram, color: blancoText.withOpacity(0.5),),
              const SizedBox(width: 15), 
              Text(form.instagramurl),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Icon(FontAwesomeIcons.tiktok, color: blancoText.withOpacity(0.5),),
              const SizedBox(width: 15), 
              Text(form.tiktokurl),
            ],
          ),
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
                          NotifServ.showSnackbarError('Lead "${form.email}" Eliminado', Colors.green);
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
          IconButton(onPressed: () {}, icon: const Icon(Icons.email_outlined, color: azulText,)),
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
