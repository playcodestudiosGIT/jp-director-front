import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../constant.dart';
import '../../../../providers/form_provider.dart';


class FormSVid extends StatefulWidget {
  const FormSVid({super.key});

  @override
  State<FormSVid> createState() => _FormSVidState();
}

class _FormSVidState extends State<FormSVid> {
  @override
  Widget build(BuildContext context) {
    final wScreen = MediaQuery.of(context).size.width;
    final hScreen = MediaQuery.of(context).size.height;
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
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: GoogleFonts.roboto(fontSize: (wScreen < 500) ? 30 : 40, fontWeight: FontWeight.w900, color: blancoText)),
                  Container(
                    width: (wScreen < 500) ? 320 : 370,
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
              if (wScreen > 980)
                const Image(
                  image: logoGrande,
                  width: 200,
                ),
              Container(
                  // height: 510,
                  constraints: const BoxConstraints(maxWidth: 350),
                  child: Form(
                    key: formProvider.keyForm,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (wScreen < 980 && hScreen > 800)
                            const Image(
                              image: logoGrande,
                              width: 200,
                            ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) => EmailValidator.validate(value!) ? null : 'Ingrese un correo valido',
                            // initialValue: formProvider.email,
                            onChanged: (value) => formProvider.setEmail(value),
                            style: GoogleFonts.roboto(color: blancoText, fontSize: 14),
                            decoration: buildInputDecoration(icon: Icons.email, label: 'Correo Electrónico'),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) => (value!.isNotEmpty) ? null : 'Ingrese su nombre',
                            // initialValue: formProvider.nombre,
                            onChanged: (value) => formProvider.setNombre(value),
                            style: GoogleFonts.roboto(color: blancoText, fontSize: 14),
                            decoration: buildInputDecoration(icon: Icons.supervised_user_circle_sharp, label: 'Nombre y Apellido'),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            // validator: (value) => (value!.length == 8)
                            //     ? null
                            //     : 'El telefono debe contener 8 digitos',
                            // initialValue: formProvider.telefono,
                            onChanged: (value) => formProvider.setTelefono(value),
                            style: GoogleFonts.roboto(color: blancoText, fontSize: 14),
                            decoration: buildInputDecoration(icon: Icons.local_phone, label: 'Teléfono'),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) => (value!.isNotEmpty) ? null : 'Requerido',
                            // initialValue: formProvider.nombre,
                            onChanged: (value) => formProvider.setNegocio(value),
                            style: GoogleFonts.roboto(color: blancoText, fontSize: 14),
                            decoration: buildInputDecoration(icon: Icons.business, label: '¿De qué sector o ciudad es tu negocio?'),
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          )
        ],
      ),
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
