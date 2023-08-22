import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../constant.dart';
import '../../../../providers/auth_provider.dart';
import '../../../../providers/forms/register_form_provider.dart';
import '../../botones/custom_button.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    final registerFormProvider = Provider.of<RegisterFormProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
      child: Form(
        key: registerFormProvider.registerKey,
        child: Column(
          children: [
            Text(
              'CREAR CUENTA',
              style: GoogleFonts.roboto(fontSize: 28, color: azulText, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              cursorColor: azulText,
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => (EmailValidator.validate(value.toString())) ? null : 'Ingrese su correo',
              initialValue: registerFormProvider.email,
              onChanged: (value) => registerFormProvider.email = value,
              style: GoogleFonts.roboto(color: blancoText, fontSize: 14),
              decoration: buildInputDecoration(icon: Icons.email, label: 'Correo Electrónico'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              cursorColor: azulText,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => (value!.isNotEmpty) ? null : 'Ingrese su nombre',
              initialValue: registerFormProvider.nombre,
              onChanged: (value) => registerFormProvider.setNombre(value),
              style: GoogleFonts.roboto(color: blancoText, fontSize: 14),
              decoration: buildInputDecoration(icon: Icons.perm_identity, label: 'Nombre'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              cursorColor: azulText,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => (value!.isNotEmpty) ? null : 'Ingrese su apellido',
              initialValue: registerFormProvider.apellido,
              onChanged: (value) => registerFormProvider.setApellido(value),
              style: GoogleFonts.roboto(color: blancoText, fontSize: 14),
              decoration: buildInputDecoration(icon: Icons.supervised_user_circle_rounded, label: 'Apellido'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              cursorColor: azulText,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) return 'Ingrese una contraseña valida';
                if (value.length < 6) return 'La contraseña debe contener mas de 6 caracteres';
                if (value != registerFormProvider.password2) return 'Las contraseñas no coinciden';
                return null;
              },
              initialValue: registerFormProvider.password1,
              onChanged: (value) => registerFormProvider.password1 = value,
              style: GoogleFonts.roboto(color: blancoText, fontSize: 14),
              decoration: buildInputDecoration(icon: Icons.password, label: 'Contraseña'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              cursorColor: azulText,
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) return 'Ingrese una contraseña valida';
                if (value.length < 6) return 'La contraseña debe contener mas de 6 caracteres';
                if (value != registerFormProvider.password1) return 'Las contraseñas no coinciden';
                return null;
              },
              initialValue: registerFormProvider.password2,
              onChanged: (value) => registerFormProvider.password2 = value,
              style: GoogleFonts.roboto(color: blancoText, fontSize: 14),
              decoration: buildInputDecoration(icon: Icons.password, label: 'Repita la contraseña'),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  width: 140,
                  text: 'REGISTRAR',
                  onPress: () {
                    final isValid = registerFormProvider.validateForm();
                    if (!isValid) return;
                    authProvider.register(
                      nombre: registerFormProvider.nombre,
                      apellido: registerFormProvider.apellido,
                      correo: registerFormProvider.email,
                      password: registerFormProvider.password1,
                    );
                  },
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
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
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: azulText),
        ),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: azulText.withOpacity(0.3))),
        labelText: label,
        labelStyle: GoogleFonts.roboto(color: blancoText, fontSize: 14),
        prefixIcon: Icon(icon, color: azulText.withOpacity(0.3)),
      );
}
