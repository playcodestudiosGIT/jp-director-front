import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';
import 'package:provider/provider.dart';

import '../../../../constant.dart';
import '../../../../generated/l10n.dart';
import '../../../../providers/form_provider.dart';
import '../../../../router/router.dart';
import '../../../../services/navigator_service.dart';
import '../../botones/botonverde.dart';
import '../../labels/inputs_decorations.dart';

class FormSVrrss extends StatefulWidget {
  const FormSVrrss({super.key});

  @override
  State<FormSVrrss> createState() => _FormSVrrssState();
}

class _FormSVrrssState extends State<FormSVrrss> {
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
      if (formProvider.getPageIndex() == 0 &&
          formProvider.keyForm.currentState!.validate()) {
        formProvider.formScrollController.nextPage();
      }

      if (formProvider.getPageIndex() == 1 &&
          formProvider.keyForm2.currentState!.validate()) {
        formProvider.formScrollController.nextPage();
      }

      if (formProvider.getPageIndex() == 2 &&
          formProvider.keyForm3.currentState!.validate()) {
        formProvider.sendForm(context);
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title,
                        style: (wScreen < 500)
                            ? DashboardLabel.h1
                            : DashboardLabel.especialT2
                                .copyWith(color: Colors.white)),
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
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        // height: 510,
                        constraints: const BoxConstraints(maxWidth: 350),
                        child: Form(
                          key: formProvider.keyForm3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (formProvider.rootForm == 'conferencias')
                                TextFormField(
                                  initialValue: formProvider.espectativas,
                                  onChanged: (value) =>
                                      formProvider.setespectativas(value),
                                  cursorColor: azulText,
                                  style: DashboardLabel.paragraph,
                                  maxLines: 5,
                                  decoration:
                                      InputDecor.formFieldInputDecoration(
                                          label: appLocal
                                              .escribeTodasTusEspectativas),
                                ),
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                appLocal.comoPuedoBuscarteRRSS,
                                style: DashboardLabel.h4,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 250),
                                child: TextFormField(
                                  initialValue: formProvider.facebook,
                                  cursorColor: azulText,
                                  onChanged: (value) =>
                                      formProvider.setFacebook(value),
                                  style: DashboardLabel.h4,
                                  decoration:
                                      InputDecor.formFieldInputDecoration(
                                          label: 'facebook.com/',
                                          icon: FontAwesomeIcons.facebook),
                                ),
                              ),
                              const SizedBox(height: 15),
                              ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 250),
                                child: TextFormField(
                                  initialValue: formProvider.tiktok,
                                  cursorColor: azulText,
                                  onChanged: (value) =>
                                      formProvider.setTiktok(value),
                                  style: DashboardLabel.h4,
                                  decoration:
                                      InputDecor.formFieldInputDecoration(
                                          label: 'tiktok.com/',
                                          icon: FontAwesomeIcons.tiktok),
                                ),
                              ),
                              const SizedBox(height: 15),
                              ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 250),
                                child: TextFormField(
                                  initialValue: formProvider.instagram,
                                  cursorColor: azulText,
                                  onChanged: (value) =>
                                      formProvider.setInstagram(value),
                                  style: DashboardLabel.h4,
                                  decoration:
                                      InputDecor.formFieldInputDecoration(
                                          label: 'instagram.com/',
                                          icon: FontAwesomeIcons.instagram),
                                ),
                              ),
                              if (formProvider.rootForm != 'conferencias')
                                const SizedBox(
                                  height: 20,
                                ),
                              if (formProvider.rootForm != 'conferencias')
                                Text(appLocal.entiendesQueEsto,
                                    style: DashboardLabel.mini),
                              if (formProvider.rootForm != 'conferencias')
                                const SizedBox(
                                  height: 20,
                                ),
                              if (formProvider.rootForm != 'conferencias')
                                DropdownButtonFormField(
                                  validator: (value) => (value != '')
                                      ? null
                                      : appLocal.seleccioneOpcion,
                                  value: '',
                                  dropdownColor: bgColor,
                                  items: [
                                    DropdownMenuItem(
                                        value: '',
                                        child: Text(appLocal.seleccioneOpcion,
                                            style: DashboardLabel.paragraph)),
                                    DropdownMenuItem(
                                        value: appLocal.si,
                                        child: Text(appLocal.siEstoyPreparado,
                                            style: DashboardLabel.paragraph)),
                                    DropdownMenuItem(
                                        value: 'NO',
                                        child: Text(appLocal.noEstoyPreparado,
                                            style: DashboardLabel.paragraph)),
                                  ],
                                  onChanged: (value) =>
                                      formProvider.setAgree(value),
                                )
                            ],
                          ),
                        ))
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        splashRadius: 18,
                        onPressed: () {
                          if (formProvider.getPageIndex() != 0) {
                            formProvider.formScrollController.previousPage();
                            setState(() {});
                          }
                        },
                        icon: const Icon(
                          Icons.arrow_circle_left_outlined,
                          color: azulText,
                          size: 18,
                        )),
                    BotonVerde(
                        text: botonText,
                        width: 100,
                        onPressed: () {
                          onPressed();
                        }),
                  ],
                ),
                const SizedBox(height: 100)
              ],
            ),
          ),
        ));
  }
}
