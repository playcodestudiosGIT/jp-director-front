import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../constant.dart';
import '../../../../providers/forms/agendar_provider.dart';

class AgendarForm extends StatefulWidget {
  const AgendarForm({super.key});

  @override
  State<AgendarForm> createState() => _AgendarFormState();
}

class _AgendarFormState extends State<AgendarForm> {
  @override
  Widget build(BuildContext context) {
    final agendarProvider = Provider.of<AgendarProvider>(context);
    final wScreen = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 370),
        child: Form(
          key: agendarProvider.keyForm,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ASESORIA 1:1',
                style: GoogleFonts.roboto(fontSize: (wScreen < 450) ? 32 : 40, fontWeight: FontWeight.w900, color: blancoText),
              ),
              Container(
                width: 300,
                height: 5,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  bgColor,
                  azulText,
                  bgColor,
                ])),
              ),
              const SizedBox(
                height: 20,
              ),
              const Image(
                image: logoGrande,
                width: 200,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) => (value!.isNotEmpty) ? null : 'Ingrese su nombre',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.name,
                initialValue: '',
                onChanged: (value) => agendarProvider.nombre = value,
                style: GoogleFonts.roboto(color: blancoText, fontSize: 14),
                decoration: buildInputDecoration(icon: Icons.supervised_user_circle_sharp, label: 'Nombre y Apellido'),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                // validator: (value) => (value!.length > 5)
                //     ? null
                //     : 'Debe ',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                initialValue: '',
                onChanged: (value) => agendarProvider.telefono = value,
                style: GoogleFonts.roboto(color: blancoText, fontSize: 14),
                decoration: buildInputDecoration(icon: Icons.local_phone, label: 'Teléfono'),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) => EmailValidator.validate(value!) ? null : 'Ingrese un correo valido',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                initialValue: '',
                onChanged: (value) {
                  agendarProvider.email = value;
                },
                style: GoogleFonts.roboto(color: blancoText, fontSize: 14),
                decoration: buildInputDecoration(icon: Icons.email, label: 'Correo Electrónico'),
              ),
            ],
          ),
        ),
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
