import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import '../../../../constant.dart';
import '../../../../providers/form_provider.dart';

class FormSVknow extends StatefulWidget {
  const FormSVknow({super.key});

  @override
  State<FormSVknow> createState() => _FormSVknowState();
}

class _FormSVknowState extends State<FormSVknow> {
  @override
  Widget build(BuildContext context) {
    final wScreen = MediaQuery.of(context).size.width;
    final formProvider = Provider.of<FormProvider>(context);
    late String title = formProvider.rootForm;

    if (formProvider.rootForm == 'mentoria') {
      title = 'MENTORÍA INTENSIVA';
    }
    if (formProvider.rootForm == 'encargado') {
      title = 'SER EL ENCARGADO';
    }
    if (formProvider.rootForm == 'conferencias') {
      title = 'CONFERENCIAS';
    }
    return SizedBox(
      width: double.infinity,
      child: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: GoogleFonts.roboto(fontSize: (wScreen < 500) ? 30 : 40, fontWeight: FontWeight.w900, color: blancoText)),
                Container(
                  width: 400,
                  height: 5,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                    bgColor,
                    azulText,
                    bgColor,
                  ])),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (wScreen > 980) const Image(image: logoGrande),
                Container(
                    constraints: const BoxConstraints(maxWidth: 350),
                    child: Form(
                      key: formProvider.keyForm2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (wScreen < 980)
                            const Image(
                              image: logoGrande,
                              width: 200,
                            ),
                          if (formProvider.rootForm != 'conferencias')
                            DropdownButtonFormField(
                              validator: (value) => (value != '') ? null : 'Campo requerido',
                              value: formProvider.opYear,
                              decoration: buildInputDecoration(label: '¿Cuántos años tiene tu negocio operativo?', icon: Icons.calendar_month),
                              dropdownColor: bgColor,
                              items: [
                                DropdownMenuItem(value: '', child: Text('Seleccione una opción', style: GoogleFonts.roboto(color: blancoText))),
                                DropdownMenuItem(value: '-6m', child: Text('Menos de 6 meses', style: GoogleFonts.roboto(color: blancoText))),
                                DropdownMenuItem(value: '1a', child: Text('1 Año', style: GoogleFonts.roboto(color: blancoText))),
                                DropdownMenuItem(value: '2a', child: Text('2 Años', style: GoogleFonts.roboto(color: blancoText))),
                                DropdownMenuItem(value: '3a', child: Text('3 Años', style: GoogleFonts.roboto(color: blancoText))),
                                DropdownMenuItem(value: '+4a', child: Text('+4 Años', style: GoogleFonts.roboto(color: blancoText))),
                              ],
                              onChanged: (value) => formProvider.setOpYear(value),
                            ),
                          if (formProvider.rootForm == 'conferencias')
                            DropdownButtonFormField(
                              validator: (value) => (value != '') ? null : 'Campo requerido',
                              value: formProvider.lvlpub,
                              decoration: buildInputDecoration(
                                  label: '¿En qué nivel de conocimiento se encuentra tu equipo referente a la publicidad digital?',
                                  icon: Icons.live_help_sharp),
                              dropdownColor: bgColor,
                              items: [
                                DropdownMenuItem(value: '', child: Text('Seleccione una opción', style: GoogleFonts.roboto(color: blancoText))),
                                DropdownMenuItem(value: 'cero', child: Text('Cero', style: GoogleFonts.roboto(color: blancoText))),
                                DropdownMenuItem(value: 'basico', child: Text('Básico', style: GoogleFonts.roboto(color: blancoText))),
                                DropdownMenuItem(value: 'intermedio', child: Text('Intermedio', style: GoogleFonts.roboto(color: blancoText))),
                                DropdownMenuItem(value: 'avanzado', child: Text('Anvanzado', style: GoogleFonts.roboto(color: blancoText))),
                              ],
                              onChanged: (value) => formProvider.setLvlPub(value),
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (formProvider.rootForm != 'conferencias')
                            DropdownButtonFormField(
                              value: formProvider.pubBefore,
                              decoration: buildInputDecoration(label: '¿Has hecho publicidad antes?', icon: Icons.abc_outlined),
                              dropdownColor: bgColor,
                              items: [
                                DropdownMenuItem(value: true, child: Text('Si', style: GoogleFonts.roboto(color: blancoText))),
                                DropdownMenuItem(value: false, child: Text('No', style: GoogleFonts.roboto(color: blancoText))),
                              ],
                              onChanged: (value) => formProvider.setPubBefore(value),
                            ),
                          if (formProvider.rootForm == 'conferencias')
                            DropdownButtonFormField(
                              value: formProvider.isOnlineConference,
                              decoration: buildInputDecoration(
                                  label: '¿Deseas que la conferencia sea presencial o prefieres online?', icon: Icons.abc_outlined),
                              dropdownColor: bgColor,
                              items: [
                                DropdownMenuItem(value: true, child: Text('Conferencia Online', style: GoogleFonts.roboto(color: blancoText))),
                                DropdownMenuItem(value: false, child: Text('Conferencia Presencial', style: GoogleFonts.roboto(color: blancoText))),
                              ],
                              onChanged: (value) => formProvider.setIsOnlineConference(value),
                            ),
                        ],
                      ),
                    ))
              ],
            )
          ],
        )
      ]),
    );
  }

  InputDecoration buildInputDecoration({
    required String label,
    required IconData icon,
  }) =>
      InputDecoration(
        fillColor: blancoText.withOpacity(0.03),
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: azulText),
        ),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: azulText.withOpacity(0.3))),
        labelText: label,
        labelStyle: GoogleFonts.roboto(color: blancoText, fontSize: 14),
        prefixIcon: Icon(icon, color: azulText.withOpacity(0.3)),
      );
}
