import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../constant.dart';
import '../../../../providers/form_provider.dart';

class FormSVrrss extends StatefulWidget {
  const FormSVrrss({super.key});

  @override
  State<FormSVrrss> createState() => _FormSVrrssState();
}

class _FormSVrrssState extends State<FormSVrrss> {
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
                  width: (wScreen < 500) ? 320 : 400,
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
            if (wScreen > 980)
              const SizedBox(
                height: 30,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (wScreen > 980) const Image(image: logoGrande),
                Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 500,
                    constraints: const BoxConstraints(maxWidth: 350),
                    child: Form(
                      key: formProvider.keyForm3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (wScreen < 980)
                            const Image(
                              image: logoGrande,
                              width: 200,
                            ),
                          if (formProvider.rootForm == 'conferencias')
                            TextFormField(
                              style: GoogleFonts.roboto(color: blancoText, fontSize: 14),
                              maxLines: 5,
                              decoration:
                                  buildInputDecoration(const Text('Escribe todas tus expectativas y temas que quieres que exponga para tu empresa')),
                            ),
                          SizedBox(
                            height: (wScreen < 980) ? 10 : 30,
                          ),
                          Text('¿Cómo te puedo buscar en redes sociales?', style: GoogleFonts.roboto(color: blancoText)),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              const Image(
                                image: iconFb,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ConstrainedBox(
                                constraints: const BoxConstraints(maxWidth: 250),
                                child: TextFormField(
                                  // validator: ,
                                  // initialValue: formProvider.facebook,
                                  onChanged: (value) => formProvider.setFacebook(value),
                                  style: GoogleFonts.roboto(color: blancoText, fontSize: 14),
                                  decoration: buildInputDecoration(const Text('facebook.com/')),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15
                          ),
                          Row(
                            children: [
                              const Image(
                                width: 35,
                                image: iconTiktok,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ConstrainedBox(
                                constraints: const BoxConstraints(maxWidth: 250),
                                child: TextFormField(
                                  onChanged: (value) => formProvider.setTiktok(value),
                                  style: GoogleFonts.roboto(color: blancoText, fontSize: 14),
                                  decoration: buildInputDecoration(const Text('tiktok.com/')),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15
                          ),
                          Row(
                            children: [
                              const Image(
                                width: 35,
                                image: iconInsta,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ConstrainedBox(
                                constraints: const BoxConstraints(maxWidth: 250),
                                child: TextFormField(
                                  onChanged: (value) => formProvider.setInstagram(value),
                                  style: GoogleFonts.roboto(color: blancoText, fontSize: 14),
                                  decoration: buildInputDecoration(const Text('instagram.com/')),
                                ),
                              ),
                            ],
                          ),
                          if (formProvider.rootForm != 'conferencias')
                            const SizedBox(
                              height: 20,
                            ),
                          if (formProvider.rootForm != 'conferencias')
                            Text(
                                '¿Entiendes que esto es un proceso en el que debes estarcomprometido y tener un modelo de negocio establecido con diferentes requerimientos?',
                                style: GoogleFonts.roboto(color: blancoText)),
                          if (formProvider.rootForm != 'conferencias')
                            const SizedBox(
                              height: 20,
                            ),
                          if (formProvider.rootForm != 'conferencias')
                            DropdownButtonFormField(
                              validator: (value) => (value != '') ? null : 'Seleccione una opción',
                              value: '',
                              dropdownColor: bgColor,
                              items: [
                                DropdownMenuItem(value: '', child: Text('Seleccione una opción', style: GoogleFonts.roboto(color: blancoText))),
                                DropdownMenuItem(value: 'si', child: Text('Si, estoy preparado', style: GoogleFonts.roboto(color: blancoText))),
                                DropdownMenuItem(
                                    value: 'no',
                                    child: Text('No, no sé cuales son los requerimientos', style: GoogleFonts.roboto(color: blancoText))),
                              ],
                              onChanged: (value) => formProvider.setAgree(value),
                            )
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

  InputDecoration buildInputDecoration(label) => InputDecoration(
        label: label,
        fillColor: blancoText.withOpacity(0.03),
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: azulText),
        ),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: azulText.withOpacity(0.3))),
        labelStyle: GoogleFonts.roboto(color: blancoText, fontSize: 14),
      );
}
