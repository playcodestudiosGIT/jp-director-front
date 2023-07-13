import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/constant.dart';
import 'package:jpdirector_frontend/models/lead.dart';
import 'package:jpdirector_frontend/providers/leads_provider.dart';
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
    final leadsProvider = Provider.of<LeadsProvider>(context);
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
                  (id != null) ? 'Editar: ${widget.lead?.email}' : 'Nuevo Lead',
                  style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
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
                  width: 200,
                  child: TextFormField(
                    style: GoogleFonts.roboto(color: Colors.white),
                    initialValue: widget.lead?.email ?? '',
                    onChanged: (value) => email = value,
                    decoration: buildInputDecoration(label: 'Correo electrónico', icon: Icons.email_outlined),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    style: GoogleFonts.roboto(color: Colors.white),
                    initialValue: widget.lead?.telf ?? '',
                    onChanged: (value) => telf = value,
                    decoration: buildInputDecoration(label: 'Teléfono', icon: Icons.phone_outlined),
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
                    width: 80,
                    onPress: () async {
                      if (id == null) {
                        // Crear
                        await leadsProvider.createLead(email: email!, telf: telf!);
                        NotificationServices.showSnackbarError('Lead Creado con exito', Colors.green);
                      } else {
                        // Actualizar
                        await leadsProvider.updateLead(id: id, email: email!, telf: telf!);
                        NotificationServices.showSnackbarError('Lead actualizado con exito', Colors.green);
                      }

                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                    text: (widget.lead != null) ? 'Actualizar' : 'Crear',
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child: CustomButton(
                    width: 80,
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
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: azulText.withOpacity(0.3))),
    labelText: label,
    labelStyle: GoogleFonts.roboto(color: blancoText, fontSize: 14),
    prefixIcon: Icon(icon, color: azulText.withOpacity(0.3)),
    suffixIconColor: azulText.withOpacity(0.3));
