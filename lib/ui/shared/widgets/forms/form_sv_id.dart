import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';
import 'package:jp_director/ui/shared/labels/inputs_decorations.dart';
import 'package:provider/provider.dart';

import '../../../../constant.dart';
import '../../../../generated/l10n.dart';
import '../../../../providers/form_provider.dart';
import '../../../../router/router.dart';
import '../../../../services/navigator_service.dart';
import '../../botones/botonverde.dart';

class FormSVid extends StatefulWidget {
  const FormSVid({super.key});

  @override
  State<FormSVid> createState() => _FormSVidState();
}

class _FormSVidState extends State<FormSVid> {
  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final wScreen = MediaQuery.of(context).size.width;
    final hScreen = MediaQuery.of(context).size.height;
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

    late String botonText;

    if (formProvider.getPageIndex() == 0) {
      botonText = appLocal.siguienteBtn;
    }
    if (formProvider.getPageIndex() == 1) {
      botonText = appLocal.siguienteBtn;
    }
    if (formProvider.getPageIndex() == 2) {
      botonText = appLocal.enviarBtn;
    }
    if (formProvider.getPageIndex() == 3) {
      botonText = appLocal.finalizarBtn;
    }

    onPressed() async {
      if (formProvider.getPageIndex() == 0 && formProvider.keyForm.currentState!.validate()) formProvider.formScrollController.nextPage();

      if (formProvider.getPageIndex() == 1 && formProvider.keyForm2.currentState!.validate()) formProvider.formScrollController.nextPage();

      if (formProvider.getPageIndex() == 2 && formProvider.keyForm3.currentState!.validate()) {
        formProvider.sendForm();
        formProvider.keyForm.currentState?.dispose();
        formProvider.keyForm2.currentState?.dispose();
        formProvider.keyForm3.currentState?.dispose();
        formProvider.formScrollController.nextPage();
      }

      if (formProvider.getPageIndex() == 3) {
        NavigatorService.replaceTo(Flurorouter.homeRoute);
        formProvider.setCurrentIndex(0);
      }
    }

    return Container(
      constraints: const BoxConstraints(maxWidth: 800),
      width: double.infinity,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: (wScreen < 500) ? DashboardLabel.h1 : DashboardLabel.gigant),
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
                  height: 200,
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
                            initialValue: formProvider.email,
                            cursorColor: azulText,
                            keyboardType: TextInputType.emailAddress,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) => EmailValidator.validate(value!) ? null : appLocal.ingreseCorreoValido,
                            onChanged: (value) => formProvider.setEmail(value),
                            style: DashboardLabel.paragraph,
                            decoration: InputDecor.formFieldInputDecoration(icon: Icons.email, label: appLocal.correoTextFiel),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            initialValue: formProvider.nombre,
                            cursorColor: azulText,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) => (value!.isNotEmpty) ? null : appLocal.nombreyapellidoForm,
                            onChanged: (value) => formProvider.setNombre(value),
                            style: DashboardLabel.paragraph,
                            decoration:
                                InputDecor.formFieldInputDecoration(icon: Icons.supervised_user_circle_sharp, label: appLocal.nombreyapellidoForm),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            initialValue: formProvider.telefono,
                            cursorColor: azulText,
                            keyboardType: TextInputType.phone,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            onChanged: (value) => formProvider.setTelefono(value),
                            style: DashboardLabel.paragraph,
                            decoration: InputDecor.formFieldInputDecoration(icon: Icons.local_phone, label: appLocal.telefonoForm),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            initialValue: formProvider.negocio,
                            cursorColor: azulText,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) => (value!.isNotEmpty) ? null : appLocal.requerido,
                            onChanged: (value) => formProvider.setNegocio(value),
                            style: DashboardLabel.paragraph,
                            decoration: InputDecor.formFieldInputDecoration(icon: Icons.business, label: appLocal.deQueSector),
                          ),
                        ],
                      ),
                    ),
                  )),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  
                  BotonVerde(text: botonText, width: 100, onPressed: () => onPressed()),
                  const SizedBox(width: 40)
                ],
              ),
                  const SizedBox(height: 100)
             
            ],
          ),
        ),
      ),
    );
  }
}
