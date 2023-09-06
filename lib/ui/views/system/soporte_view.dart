import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:jp_director/providers/export_all_providers.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import '../../shared/botones/custom_button.dart';
import '../../shared/labels/dashboard_label.dart';
import '../../shared/labels/inputs_decorations.dart';

class SoporteView extends StatefulWidget {
  const SoporteView({super.key});

  @override
  State<SoporteView> createState() => _SoporteViewState();
}

class _SoporteViewState extends State<SoporteView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool enviado = false;

  bool isLoading = false;

  @override
  void dispose() {
    formKey.currentState!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String nombre = '';
    String apellido = '';
    String correo = '';
    String mensaje = '';

    final appLocal = AppLocalizations.of(context);
    double hScreen = MediaQuery.of(context).size.height;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Container(
                  alignment: Alignment.center,
                  constraints: BoxConstraints(maxWidth: 1200, minHeight: hScreen),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 200, child: Image(image: logoGrande)),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 400),
                            width: double.infinity,
                            padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  Text(
                                    'AYUDA Y SOPORTE',
                                    style: DashboardLabel.azulTextH1,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  if (!enviado)
                                    Column(
                                      children: [
                                        Text(
                                          'Envianos tus comentarios, en menos de 48h te brindaremos una respuesta',
                                          style: DashboardLabel.mini,
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        TextFormField(
                                          cursorColor: azulText,
                                          keyboardType: TextInputType.emailAddress,
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          validator: (value) => (EmailValidator.validate(value.toString())) ? null : appLocal.ingreseCorreoValido,
                                          initialValue: correo,
                                          onChanged: (value) => correo = value.toString(),
                                          style: DashboardLabel.paragraph,
                                          decoration: InputDecor.formFieldInputDecoration(icon: Icons.email, label: appLocal.correoTextFiel),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          initialValue: nombre,
                                          cursorColor: azulText,
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          validator: (value) => (value!.isNotEmpty) ? null : appLocal.nombreTextField,
                                          onChanged: (value) => nombre = value,
                                          style: DashboardLabel.paragraph,
                                          decoration: InputDecor.formFieldInputDecoration(icon: Icons.perm_identity, label: appLocal.nombreTextField),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          initialValue: apellido,
                                          cursorColor: azulText,
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          validator: (value) => (value!.isNotEmpty) ? null : appLocal.apellidoTextFiel,
                                          onChanged: (value) => apellido = value,
                                          style: DashboardLabel.paragraph,
                                          decoration: InputDecor.formFieldInputDecoration(
                                              icon: Icons.supervised_user_circle_rounded, label: appLocal.apellidoTextFiel),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          initialValue: mensaje,
                                          cursorColor: azulText,
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          validator: (value) => (value!.isNotEmpty) ? null : 'Escribe tu comentario',
                                          maxLines: 5,
                                          onChanged: (value) => mensaje = value,
                                          style: DashboardLabel.paragraph,
                                          decoration: InputDecor.formFieldInputDecoration(
                                              icon: Icons.contact_support_rounded, label: 'En que podemos ayudarte'),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            CustomButton(
                                              width: 140,
                                              text: 'ENVIAR',
                                              onPress: (isLoading)
                                                  ? null
                                                  : () async {
                                                      isLoading = true;
                                                      final isValid = formKey.currentState!.validate();
                                                      if (!isValid) return;
                                                      final isOk = await authProvider.sendEmailSupport(
                                                        nombre: nombre,
                                                        apellido: apellido,
                                                        correo: correo,
                                                        mensaje: mensaje,
                                                      );
                                                      if (isOk) {
                                                        setState(() {
                                                          enviado = true;
                                                          formKey.currentState!.reset();
                                                          nombre = '';
                                                          apellido = '';
                                                          correo = '';
                                                          mensaje = '';
                                                        });
                                                      }
                                                    },
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  if (enviado)
                                    Container(
                                      constraints: const BoxConstraints(maxWidth: 340, maxHeight: 408),
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: Center(
                                          child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.check, color: Colors.green),
                                          Text(
                                            'Gracias por comunicarte, en menos de 48 horas te brindaremos una respuesta a tu correo electrónico',
                                            style: DashboardLabel.mini,
                                          ),
                                        ],
                                      )),
                                    ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 400),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Spacer(),
                                TextButton(
                                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(blancoText.withOpacity(0.1))),
                                  onPressed: () {
                                    NavigatorService.replaceTo(Flurorouter.loginRoute);
                                  }, // Navigate to register page
                                  child: Text(
                                    'ir a Mis Cursos',
                                    style: DashboardLabel.botonText.copyWith(color: azulText),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}
