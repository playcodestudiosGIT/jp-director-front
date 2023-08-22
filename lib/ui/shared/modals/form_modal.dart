import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/constant.dart';
import 'package:jpdirector_frontend/models/formulario.dart';
import 'package:jpdirector_frontend/providers/form_provider.dart';
import 'package:jpdirector_frontend/ui/shared/labels/dashboard_label.dart';
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
    final formProvider = Provider.of<FormProvider>(context);
    final size = MediaQuery.of(context).size;
    return Container(
      padding: (size.width < 500) ? const EdgeInsets.only(left: 40, top: 15, right: 15, bottom: 15) : const EdgeInsets.all(15),
      height: 500,
      width: 300, // expande
      decoration: buildBoxDecoration(),
      child: ListView(children: [
        Column(
          children: [
            Row(
              children: [
                if (size.width < 715)
                  const SizedBox(
                    width: 40,
                  ),
                Text(
                  (id != '') ? 'Editar: ${widget.form?.email}' : 'Nuevo Formulario',
                  style: DashboardLabel.h4
                ),
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
                SizedBox(
                    width: 300,
                    child: DropdownButton(
                        isExpanded: true,
                        dropdownColor: bgColor,
                        value: formTipo,
                        items: [
                          DropdownMenuItem(
                              value: 'mentoria',
                              child: Text(
                                'Mentoria',
                                style: GoogleFonts.roboto(color: Colors.white),
                              )),
                          DropdownMenuItem(
                              value: 'encargado',
                              child: Text(
                                'Encargado',
                                style: GoogleFonts.roboto(color: Colors.white),
                              )),
                          DropdownMenuItem(
                              value: 'conferencia',
                              child: Text(
                                'Conferencia',
                                style: GoogleFonts.roboto(color: Colors.white),
                              )),
                        ],
                        onChanged: (value) => setState(() {
                              formTipo = value.toString();
                              formProvider.rootForm = value.toString();
                            }))),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    cursorColor: azulText,
                    style: GoogleFonts.roboto(color: Colors.white),
                    initialValue: nombre,
                    onChanged: (value) {
                      nombre = value;
                      formProvider.nombre = value;
                    },
                    decoration: buildInputDecoration(label: 'Nombre', icon: Icons.person_outline),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    cursorColor: azulText,
                    style: GoogleFonts.roboto(color: Colors.white),
                    initialValue: email,
                    onChanged: (value) {
                      email = value;
                      formProvider.email = value;
                    },
                    decoration: buildInputDecoration(label: 'Correo electrónico', icon: Icons.email_outlined),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    cursorColor: azulText,
                    style: GoogleFonts.roboto(color: Colors.white),
                    initialValue: telefono,
                    onChanged: (value) {
                      telefono = value;
                      formProvider.telefono = value;
                    },
                    decoration: buildInputDecoration(label: 'Teléfono', icon: Icons.phone_outlined),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    cursorColor: azulText,
                    style: GoogleFonts.roboto(color: Colors.white),
                    initialValue: negocio,
                    onChanged: (value) {
                      negocio = value;
                      formProvider.negocio = value;
                    },
                    decoration: buildInputDecoration(label: 'Tipo de negocio', icon: Icons.business_center_outlined),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    cursorColor: azulText,
                    style: GoogleFonts.roboto(color: Colors.white),
                    initialValue: yearsOp,
                    onChanged: (value) {
                      yearsOp = value;
                      formProvider.opYear = value;
                    },
                    decoration: buildInputDecoration(label: 'Años de Operaciones', icon: Icons.work_history_outlined),
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
                    text: (widget.form != null) ? 'Actualizar' : 'Crear',
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
                    text: 'Cancelar',
                  ),
                ),
              ],
            )
          ],
        ),
      ]),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      color: bgColor,
      boxShadow: [BoxShadow(color: Colors.black)]);
}

InputDecoration buildInputDecoration({required String label, required IconData icon, IconData? suffIcon, Function? onPrs}) => InputDecoration(
    fillColor: blancoText.withOpacity(0.03),
    filled: true,
    border: const OutlineInputBorder(
      borderSide: BorderSide(color: azulText),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: azulText),
    ),
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: azulText.withOpacity(0.3))),
    labelText: label,
    labelStyle: GoogleFonts.roboto(color: blancoText, fontSize: 14),
    prefixIcon: Icon(icon, color: azulText.withOpacity(0.3)),
    suffixIconColor: azulText.withOpacity(0.3));
