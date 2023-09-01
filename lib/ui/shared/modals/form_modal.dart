import 'package:flutter/material.dart';
import 'package:jp_director/constant.dart';
import 'package:jp_director/generated/l10n.dart';
import 'package:jp_director/models/formulario.dart';
import 'package:jp_director/providers/form_provider.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';
import 'package:jp_director/ui/shared/labels/inputs_decorations.dart';
import 'package:provider/provider.dart';

import '../botones/custom_button.dart';

class FormsModal extends StatefulWidget {
  final Formulario? form;
  const FormsModal({Key? key, this.form}) : super(key: key);

  @override
  State<FormsModal> createState() => _FormsModalState();
}

class _FormsModalState extends State<FormsModal> {
  late String id;
  late String formTipo;
  late String nombre;
  late String email;
  late String telefono;
  late String negocio;
  late String yearsOp;
  late String publvl;
  late bool pubBefore;
  late String acepto;

  @override
  void initState() {
    super.initState();
    id = widget.form?.uid ?? '';
    formTipo = widget.form?.rootform ?? 'mentoria';
    nombre = widget.form?.nombre ?? '';
    email = widget.form?.email ?? '';
    telefono = widget.form?.phone ?? '';
    negocio = widget.form?.business ?? '';
    yearsOp = widget.form?.operationyears ?? '0';
    publvl = widget.form?.advertisinglevel ?? '0';
    pubBefore = widget.form?.advertisingbefore ?? false;
    acepto = widget.form?.agree ?? 'No';
  }

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final formProvider = Provider.of<FormProvider>(context);
    return Container(
      constraints: const BoxConstraints(maxWidth: 800),
      decoration: InputDecor.buildBoxDecoration(),
      child: ListView(children: [
        Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 20),
                Text((id != '') ? '${appLocal.editar2puntos} ${widget.form?.email}' : appLocal.nuevoForm, style: DashboardLabel.h4),
                const Spacer(),
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 16
                    ))
              ],
            ),
            Divider(
              color: bgColor.withOpacity(0.3),
            ),
            const SizedBox(
              height: 15 / 2,
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 830),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 15,
                runSpacing: 15,
                children: [
                  Container(
                      height: 50,
                      decoration: BoxDecoration(border: Border.all(color: azulText.withOpacity(0.3), strokeAlign: 1)),
                      constraints: const BoxConstraints(maxWidth: 400, minWidth: 315),
                      child: Center(
                        child: DropdownButton(
                            underline: Container(),
                            isExpanded: true,
                            dropdownColor: bgColor,
                            value: formTipo,
                            items: [
                              DropdownMenuItem(
                                  value: 'mentoria',
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(appLocal.mentoria, style: DashboardLabel.paragraph),
                                  )),
                              DropdownMenuItem(
                                  value: 'encargado',
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(appLocal.serElEncargado, style: DashboardLabel.paragraph),
                                  )),
                              DropdownMenuItem(
                                  value: 'conferencias',
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(appLocal.conferencias, style: DashboardLabel.paragraph),
                                  )),
                            ],
                            onChanged: (value) => setState(() {
                                  formTipo = value.toString();
                                  formProvider.rootForm = value.toString();
                                })),
                      )),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: TextFormField(
                      cursorColor: azulText,
                      style: DashboardLabel.paragraph,
                      initialValue: nombre,
                      onChanged: (value) {
                        nombre = value;
                        formProvider.nombre = value;
                      },
                      decoration: InputDecor.formFieldInputDecoration(label: appLocal.nombreyapellidoForm, icon: Icons.person_outline),
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: TextFormField(
                      cursorColor: azulText,
                      style: DashboardLabel.paragraph,
                      initialValue: email,
                      onChanged: (value) {
                        email = value;
                        formProvider.email = value;
                      },
                      decoration: InputDecor.formFieldInputDecoration(label: appLocal.correoTextFiel, icon: Icons.email_outlined),
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: TextFormField(
                      cursorColor: azulText,
                      style: DashboardLabel.paragraph,
                      initialValue: telefono,
                      onChanged: (value) {
                        telefono = value;
                        formProvider.telefono = value;
                      },
                      decoration: InputDecor.formFieldInputDecoration(label: appLocal.telefonoForm, icon: Icons.phone_outlined),
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: TextFormField(
                      cursorColor: azulText,
                      style: DashboardLabel.paragraph,
                      initialValue: negocio,
                      onChanged: (value) {
                        negocio = value;
                        formProvider.negocio = value;
                      },
                      decoration: InputDecor.formFieldInputDecoration(label: appLocal.negocio2puntos, icon: Icons.business_center_outlined),
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: TextFormField(
                      cursorColor: azulText,
                      style: DashboardLabel.paragraph,
                      initialValue: yearsOp,
                      onChanged: (value) {
                        yearsOp = value;
                        formProvider.opYear = value;
                      },
                      decoration: InputDecor.formFieldInputDecoration(label: appLocal.cuantosAnosNegAct, icon: Icons.work_history_outlined),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child: CustomButton(
                    color: Colors.green,
                    width: 100,
                    onPress: () async {
                      if (id == '') {
                        // Crear
                        await formProvider.sendForm();
                      } else {
                        // Actualizar
                        await formProvider.updateForm(id);
                      }

                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                    text: (widget.form != null) ? appLocal.actualizarBtn : appLocal.crearBtn,
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
            ),
            const SizedBox(height: 100)
          ],
        ),
      ]),
    );
  }
}
