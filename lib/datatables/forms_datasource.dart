import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jp_director/models/formulario.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import '../generated/l10n.dart';
import '../providers/form_provider.dart';
import '../services/notificacion_service.dart';
import '../ui/shared/labels/dashboard_label.dart';
import '../ui/shared/modals/form_modal.dart';

class FormsDTS extends DataTableSource {
  List<Formulario> forms;
  final BuildContext context;

  FormsDTS(this.forms, this.context);

  @override
  DataRow getRow(int index) {
    final appLocal = AppLocalizations.of(context);
    final form = forms[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                appLocal.servicios2puntos,
                style: DashboardLabel.paragraph.copyWith(fontWeight: FontWeight.bold, color: blancoText.withOpacity(0.5)),
              ),
              Text(
                form.rootform.toUpperCase(),
                style: DashboardLabel.paragraph.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('${appLocal.nombreTextField}:  ', style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),),
              Text(form.nombre),
              
            ],
          ),
          const Divider(),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('${appLocal.correoTextFiel}:  ', style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5))),
              Text(form.email),
              const Spacer(),
              Icon(Icons.copy, size: 15, color: blancoText.withOpacity(0.5),)
            ],
          ),
          const Divider(),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('${appLocal.telefonoForm}:  ', style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5))),
              Text(form.phone),
            ],
          ),
          const Divider(),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('${appLocal.negocio2puntos}:   ', style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5))),
              Text(form.business),
            ],
          ),
          const Divider(),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(' ${appLocal.cuantosAnosNegAct}:  ', style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5))),
              Text(form.operationyears),
            ],
          ),
          const Divider(),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('${appLocal.advisoryLvl}:   ', style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5))),
              Text(form.advertisinglevel),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Text('${appLocal.advisoryBefore}:  ', style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5))),
              if(form.advertisingbefore) Text(appLocal.si),
              if(!form.advertisingbefore) const Text('NO')
            ],
          ),
          const Divider(),
          Row(
            children: [
              Text('${appLocal.acepto2puntos}  ', style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5))),
              Text(form.agree.toUpperCase()),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Text('${appLocal.fecha}  ', style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5))),
              Text('${DateTime.parse(form.createdAt).day}-${DateTime.parse(form.createdAt).month}-${DateTime.parse(form.createdAt).year}'),
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
                color: azulText,
              )),
          IconButton(
              onPressed: () {
                final dialog = AlertDialog(
                  title: Text(appLocal.borrarForm),
                  content: Text('${appLocal.borrarFormDef} "${form.email}"'),
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
                          NotifServ.showSnackbarError('Lead "${form.email}" ${appLocal.eliminado}', Colors.green);
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
  int get rowCount => forms.length;

  @override
  int get selectedRowCount => 0;
}













// 
