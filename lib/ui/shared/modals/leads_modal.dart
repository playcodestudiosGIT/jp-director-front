import 'package:flutter/material.dart';
import 'package:jp_director/constant.dart';
import 'package:jp_director/generated/l10n.dart';
import 'package:jp_director/models/lead.dart';
import 'package:jp_director/providers/leads_provider.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';
import 'package:jp_director/ui/shared/labels/inputs_decorations.dart';
import 'package:provider/provider.dart';

import '../../../services/notificacion_service.dart';
import '../botones/custom_button.dart';

class LeadsModal extends StatefulWidget {
  final Lead? lead;
  const LeadsModal({Key? key, this.lead}) : super(key: key);

  @override
  State<LeadsModal> createState() => _LeadsModalState();
}

class _LeadsModalState extends State<LeadsModal> {
  String? email;
  String? telf;
  String? id;

  @override
  void initState() {
    super.initState();
    id = widget.lead?.uid;
    email = widget.lead?.email;
    telf = widget.lead?.telf;
  }

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final leadsProvider = Provider.of<LeadsProvider>(context);
    final size = MediaQuery.of(context).size;
    return Container(
      height: 500,
      width: 300, // expande
      decoration: InputDecor.buildBoxDecoration(),
      child: ListView(children: [
        Column(
          children: [
            Row(
              children: [

                  const SizedBox(
                    width: 20,
                  ),
                Text((id != null) ? '${appLocal.editar2puntos} ${widget.lead?.email}' : appLocal.nuevoLead, style: DashboardLabel.h4),
                const Spacer(),
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ))
              ],
            ),
            Divider(
              color: bgColor.withOpacity(0.3),
            ),
            const SizedBox(
              height: 15 / 2,
            ),
            Padding(
              padding: (size.width > 580) ? const EdgeInsets.only(left: 25) : const EdgeInsets.only(left: 0),
              child: Wrap(alignment: WrapAlignment.center, spacing: 15 / 2, runSpacing: 15 / 2, children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: TextFormField(
                    cursorColor: azulText,
                    style: DashboardLabel.h4,
                    initialValue: widget.lead?.email ?? '',
                    onChanged: (value) => email = value,
                    decoration: InputDecor.formFieldInputDecoration(label: appLocal.correoTextFiel, icon: Icons.email_outlined),
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: TextFormField(
                    cursorColor: azulText,
                    style: DashboardLabel.h4,
                    initialValue: widget.lead?.telf ?? '',
                    onChanged: (value) => telf = value,
                    decoration: InputDecor.formFieldInputDecoration(label: appLocal.telefonoForm, icon: Icons.phone_outlined),
                  ),
                ),
              ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child: CustomButton(
                    width: 100,
                    color: Colors.green,
                    onPress: () async {
                      if (id == null) {
                        // Crear
                        await leadsProvider.createLead(email: email!, telf: telf!);
                        NotifServ.showSnackbarError(appLocal.leadCreadoConExito, Colors.green);
                      } else {
                        // Actualizar
                        await leadsProvider.updateLead(id: id, email: email!, telf: telf!);
                        NotifServ.showSnackbarError(appLocal.leadActualizadoConExito, Colors.green);
                      }

                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                    text: (widget.lead != null) ? appLocal.actualizarBtn : appLocal.crearBtn,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child: CustomButton(
                    width: 100,
                    color: Colors.red.withOpacity(0.5),
                    onPress: () {
                      Navigator.of(context).pop();
                    },
                    text: appLocal.cancelarBtn,
                  ),
                ),
              ],
            )
          ],
        ),
      ]),
    );
  }
}
