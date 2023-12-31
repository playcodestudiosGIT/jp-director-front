import 'package:flutter/material.dart';
import 'package:jp_director/providers/export_all_providers.dart';

import '../../../constant.dart';

import '../../shared/botones/custom_button.dart';
import '../../shared/labels/dashboard_label.dart';
import '../../shared/labels/inputs_decorations.dart';

class EmailModalLead extends StatefulWidget {
  final String correo;
  const EmailModalLead({super.key, required this.correo});

  @override
  State<EmailModalLead> createState() => _EmailModalLeadState();
}

class _EmailModalLeadState extends State<EmailModalLead> {
  GlobalKey<FormState> formKeyModalEmail = GlobalKey<FormState>();
  bool enviado = false;

  bool isLoading = false;

  @override
  void dispose() {
    formKeyModalEmail.currentState!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String mensaje = '';

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return SizedBox(
      width: 340,
      height: 400,
      child: Stack(
        // alignment: Alignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // alignment: Alignment.center,
                constraints: const BoxConstraints(maxWidth: 340),
                child: Column(
                  children: [
                    Container(
                      constraints: const BoxConstraints(maxWidth: 335),
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: Form(
                        key: formKeyModalEmail,
                        child: Column(
                          children: [
                            Text(
                              'Enviar email a:',
                              style: DashboardLabel.azulTextH1,
                            ),
                            Text(
                              widget.correo,
                              style: DashboardLabel.mini,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            
                            if (!enviado)
                              Column(
                                children: [
                            
                                  TextFormField(
                                    initialValue: mensaje,
                                    cursorColor: azulText,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (value) => (value!.isNotEmpty) ? null : 'Escribe tu comentario',
                                    maxLines: 5,
                                    onChanged: (value) => mensaje = value,
                                    style: DashboardLabel.paragraph,
                                    decoration:
                                        InputDecor.formFieldInputDecoration(icon: Icons.contact_support_rounded, label: 'continua el mensaje...'),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      
                                      
                                      CustomButton(
                                        width: 100,
                                        text: 'CANCELAR',
                                        color: Colors.red,
                                        onPress: ()=> Navigator.pop(context, false)
                                      ),
                                      const SizedBox(width: 10),
                                      CustomButton(
                                        width: 100,
                                        color: Colors.green,
                                        text: 'ENVIAR',
                                        onPress: (isLoading)
                                            ? null
                                            : () async {
                                                isLoading = true;
                                                final isValid = formKeyModalEmail.currentState!.validate();
                                                if (!isValid) return;
                                                final isOk = await authProvider.sendEmailToUser(
                                                  nombre: '',
                                                  apellido: '',
                                                  correo: widget.correo,
                                                  mensaje: mensaje,
                                                );
                                                if (isOk) {
                                                  setState(() {
                                                    enviado = true;
                                                    formKeyModalEmail.currentState!.reset();
                                                    mensaje = '';

                                                  });
                                                }
                                              },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            if (enviado)
                              Container(
                                constraints: const BoxConstraints(maxWidth: 340, maxHeight: 200),
                                width: double.infinity,
                                height: double.infinity,
                                child: Center(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.check, color: Colors.green),
                                    Text(
                                      'Mensaje enviado con exito',
                                      style: DashboardLabel.mini,
                                    ),
                                    const SizedBox(height: 30),
                                    CustomButton(text: 'CERRAR', onPress: ()=> Navigator.pop(context, false), width: 100, color: Colors.red,)
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
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
