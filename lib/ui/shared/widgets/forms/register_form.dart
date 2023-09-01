import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';
import 'package:jp_director/ui/shared/labels/inputs_decorations.dart';
import 'package:provider/provider.dart';

import '../../../../constant.dart';
import '../../../../generated/l10n.dart';
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
    final appLocal = AppLocalizations.of(context);
    final registerFormProvider = Provider.of<RegisterFormProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
      child: Form(
        key: registerFormProvider.registerKey,
        child: Column(
          children: [
            Text(
              appLocal.crearCuenta,
              style: DashboardLabel.azulTextH1,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              cursorColor: azulText,
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => (EmailValidator.validate(value.toString())) ? null : appLocal.ingreseSuCorreo,
              initialValue: registerFormProvider.email,
              onChanged: (value) => registerFormProvider.email = value,
              style: DashboardLabel.paragraph,
              decoration: InputDecor.formFieldInputDecoration(icon: Icons.email, label: appLocal.correoTextFiel),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              cursorColor: azulText,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => (value!.isNotEmpty) ? null : appLocal.ingreseNombreTextField,
              initialValue: registerFormProvider.nombre,
              onChanged: (value) => registerFormProvider.setNombre(value),
              style: DashboardLabel.paragraph,
              decoration: InputDecor.formFieldInputDecoration(icon: Icons.perm_identity, label: appLocal.nombreTextField),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              cursorColor: azulText,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => (value!.isNotEmpty) ? null : appLocal.ingreseApellidoTextFiel,
              initialValue: registerFormProvider.apellido,
              onChanged: (value) => registerFormProvider.setApellido(value),
              style: DashboardLabel.paragraph,
              decoration: InputDecor.formFieldInputDecoration(icon: Icons.supervised_user_circle_rounded, label: appLocal.apellidoTextFiel),
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
                if (value!.isEmpty) return appLocal.ingreseUnaPassValida;
                if (value.length < 6) return appLocal.laContraDebe6Caracteres;
                if (value != registerFormProvider.password2) return appLocal.passNoCoinciden;
                return null;
              },
              initialValue: registerFormProvider.password1,
              onChanged: (value) => registerFormProvider.password1 = value,
              style: DashboardLabel.paragraph,
              decoration: InputDecor.formFieldInputDecoration(icon: Icons.password, label: appLocal.contrasenaTextFiel),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              cursorColor: azulText,
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) return appLocal.ingreseUnaPassValida;
                if (value.length < 6) return appLocal.laContraDebe6Caracteres;
                if (value != registerFormProvider.password1) return appLocal.passNoCoinciden;
                return null;
              },
              initialValue: registerFormProvider.password2,
              onChanged: (value) => registerFormProvider.password2 = value,
              style: DashboardLabel.paragraph,
              decoration: InputDecor.formFieldInputDecoration(icon: Icons.password, label: appLocal.repitaContrasenaTextFiel),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  width: 140,
                  text: appLocal.registrarBtn,
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
}
