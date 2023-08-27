import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import '../../../../constant.dart';
import '../../../../generated/l10n.dart';
import '../../../../providers/form_provider.dart';

class FormSVknow extends StatefulWidget {
  const FormSVknow({super.key});

  @override
  State<FormSVknow> createState() => _FormSVknowState();
}

class _FormSVknowState extends State<FormSVknow> {
  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final wScreen = MediaQuery.of(context).size.width;
    final formProvider = Provider.of<FormProvider>(context);
    late String title = formProvider.rootForm;

    if (formProvider.rootForm == 'mentoria') {
      title = appLocal.mentoriaIntensiva;
    }
    if (formProvider.rootForm == 'encargado') {
      title = appLocal.serElEncargado;
    }
    if (formProvider.rootForm == 'conferencias') {
      title = appLocal.conferencias;
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
                              validator: (value) => (value != '') ? null : appLocal.requerido,
                              value: formProvider.opYear,
                              decoration: buildInputDecoration(label: appLocal.cuantosAnosNegAct, icon: Icons.calendar_month),
                              dropdownColor: bgColor,
                              items: [
                                DropdownMenuItem(value: '', child: Text(appLocal.seleccioneOpcion, style: GoogleFonts.roboto(color: blancoText))),
                                DropdownMenuItem(value: '-6m', child: Text(appLocal.menosde6meses, style: GoogleFonts.roboto(color: blancoText))),
                                DropdownMenuItem(value: '1a', child: Text(appLocal.uny, style: GoogleFonts.roboto(color: blancoText))),
                                DropdownMenuItem(value: '2a', child: Text(appLocal.dosy, style: GoogleFonts.roboto(color: blancoText))),
                                DropdownMenuItem(value: '3a', child: Text(appLocal.tresy, style: GoogleFonts.roboto(color: blancoText))),
                                DropdownMenuItem(value: '+4a', child: Text(appLocal.cuatroy, style: GoogleFonts.roboto(color: blancoText))),
                              ],
                              onChanged: (value) => formProvider.setOpYear(value),
                            ),
                          if (formProvider.rootForm == 'conferencias')
                            DropdownButtonFormField(
                              validator: (value) => (value != '') ? null : appLocal.requerido,
                              value: formProvider.lvlpub,
                              decoration: buildInputDecoration(label: appLocal.enQueNivel, icon: Icons.live_help_sharp),
                              dropdownColor: bgColor,
                              items: [
                                DropdownMenuItem(value: '', child: Text(appLocal.seleccioneOpcion, style: GoogleFonts.roboto(color: blancoText))),
                                DropdownMenuItem(value: 'cero', child: Text(appLocal.cero, style: GoogleFonts.roboto(color: blancoText))),
                                DropdownMenuItem(value: 'basico', child: Text(appLocal.basico, style: GoogleFonts.roboto(color: blancoText))),
                                DropdownMenuItem(value: 'intermedio', child: Text(appLocal.intermedio, style: GoogleFonts.roboto(color: blancoText))),
                                DropdownMenuItem(value: 'avanzado', child: Text(appLocal.avanzado, style: GoogleFonts.roboto(color: blancoText))),
                              ],
                              onChanged: (value) => formProvider.setLvlPub(value),
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (formProvider.rootForm != 'conferencias')
                            DropdownButtonFormField(
                              value: formProvider.pubBefore,
                              decoration: buildInputDecoration(label: appLocal.advisoryBefore, icon: Icons.abc_outlined),
                              dropdownColor: bgColor,
                              items: [
                                DropdownMenuItem(value: true, child: Text(appLocal.si, style: GoogleFonts.roboto(color: blancoText))),
                                DropdownMenuItem(value: false, child: Text('No', style: GoogleFonts.roboto(color: blancoText))),
                              ],
                              onChanged: (value) => formProvider.setPubBefore(value),
                            ),
                          if (formProvider.rootForm == 'conferencias')
                            DropdownButtonFormField(
                              value: formProvider.isOnlineConference,
                              decoration: buildInputDecoration(label: appLocal.deseasQueLaConf, icon: Icons.abc_outlined),
                              dropdownColor: bgColor,
                              items: [
                                DropdownMenuItem(value: true, child: Text(appLocal.confOnline, style: GoogleFonts.roboto(color: blancoText))),
                                DropdownMenuItem(value: false, child: Text(appLocal.confPresenc, style: GoogleFonts.roboto(color: blancoText))),
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
