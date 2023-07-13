import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/constant.dart';
import 'package:jpdirector_frontend/models/baner.dart';
import 'package:jpdirector_frontend/providers/baners_provider.dart';
import 'package:provider/provider.dart';

import '../botones/custom_button.dart';

class BanersModal extends StatefulWidget {
  final Baner? baner;
  const BanersModal({Key? key, this.baner}) : super(key: key);

  @override
  State<BanersModal> createState() => _BanersModalState();
}

class _BanersModalState extends State<BanersModal> {
  String? id;
  String? nombre;
  String? img;
  String? priceId;
  String? cursoId;

  @override
  void initState() {
    super.initState();
    id = widget.baner?.id;
    nombre = widget.baner?.nombre;
    img = widget.baner?.img;
    priceId = widget.baner?.priceId;
    cursoId = widget.baner?.cursoId;
  }

  @override
  Widget build(BuildContext context) {
    final banersProvider = Provider.of<BanersProvider>(context);
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
                  (id != null) ? 'Editar: ${widget.baner?.nombre}' : 'Nuevo Baner',
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
                    initialValue: widget.baner?.nombre ?? '',
                    onChanged: (value) => nombre = value,
                    decoration: buildInputDecoration(label: 'Nombre Baner', icon: Icons.title_outlined),
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: (size.width > 580) ? const EdgeInsets.only(left: 25) : const EdgeInsets.only(left: 0),
              child: Wrap(alignment: WrapAlignment.center, spacing: 15 / 2, runSpacing: 15 / 2, children: [
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    style: GoogleFonts.roboto(color: Colors.white),
                    initialValue: widget.baner?.priceId ?? '',
                    onChanged: (value) => priceId = value,
                    decoration: buildInputDecoration(label: 'Price Id de Stripe', icon: Icons.price_change),
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: (size.width > 580) ? const EdgeInsets.only(left: 25) : const EdgeInsets.only(left: 0),
              child: Wrap(alignment: WrapAlignment.center, spacing: 15 / 2, runSpacing: 15 / 2, children: [
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    style: GoogleFonts.roboto(color: Colors.white),
                    initialValue: widget.baner?.cursoId ?? '',
                    onChanged: (value) => cursoId = value,
                    decoration: buildInputDecoration(label: 'Curso ID', icon: Icons.code_outlined),
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
                        await banersProvider.createBaner(nombre: nombre!, priceId: priceId!, cursoId: cursoId!);

                      } else {
                        // Actualizar
                        await banersProvider.updateBaner( uid: id! , nombreBaner: nombre!, priceId: priceId!, cursoId: cursoId!);

                      }

                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                    text: (widget.baner != null) ? 'Actualizar' : 'Crear',
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
