import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';

import 'package:provider/provider.dart';

import '../../../../constant.dart';
import '../../../../generated/l10n.dart';
import '../../../../providers/form_provider.dart';
import '../../../../router/router.dart';
import '../../../../services/navigator_service.dart';
import '../../botones/botonverde.dart';
import '../../labels/inputs_decorations.dart';

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
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: (wScreen < 500) ? DashboardLabel.h1 : DashboardLabel.especialT2.copyWith(color: Colors.white)),
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
                  // if (wScreen > 980) const Image(image: logoGrande),
                  Container(
                      constraints: const BoxConstraints(maxWidth: 350),
                      child: Form(
                        key: formProvider.keyForm2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (formProvider.rootForm != 'conferencias')
                              DropdownButtonFormField(
                                validator: (value) => (value != '') ? null : appLocal.requerido,
                                value: formProvider.opYear,
                                decoration: InputDecor.formFieldInputDecoration(label: appLocal.cuantosAnosNegAct, icon: Icons.calendar_month),
                                dropdownColor: bgColor,
                                items: [
                                  DropdownMenuItem(value: '', child: Text(appLocal.seleccioneOpcion, style: DashboardLabel.h4)),
                                  DropdownMenuItem(value: '-6', child: Text(appLocal.menosde6meses, style: DashboardLabel.h4)),
                                  DropdownMenuItem(value: '1y', child: Text(appLocal.uny, style: DashboardLabel.h4)),
                                  DropdownMenuItem(value: '2y', child: Text(appLocal.dosy, style: DashboardLabel.h4)),
                                  DropdownMenuItem(value: '3y', child: Text(appLocal.tresy, style: DashboardLabel.h4)),
                                  DropdownMenuItem(value: '+4y', child: Text(appLocal.cuatroy, style: DashboardLabel.h4)),
                                ],
                                onChanged: (value) => formProvider.setOpYear(value),
                              ),
                            if (formProvider.rootForm == 'conferencias')
                              DropdownButtonFormField(
                                validator: (value) => (value != '') ? null : appLocal.requerido,
                                value: formProvider.lvlpub,
                                decoration: InputDecor.formFieldInputDecoration(label: appLocal.enQueNivel, icon: Icons.live_help_sharp),
                                dropdownColor: bgColor,
                                items: [
                                  DropdownMenuItem(value: '', child: Text(appLocal.seleccioneOpcion, style: DashboardLabel.h4)),
                                  DropdownMenuItem(value: 'cero', child: Text(appLocal.cero, style: DashboardLabel.h4)),
                                  DropdownMenuItem(value: 'basico', child: Text(appLocal.basico, style: DashboardLabel.h4)),
                                  DropdownMenuItem(value: 'intermedio', child: Text(appLocal.intermedio, style: DashboardLabel.h4)),
                                  DropdownMenuItem(value: 'avanzado', child: Text(appLocal.avanzado, style: DashboardLabel.h4)),
                                ],
                                onChanged: (value) => formProvider.setLvlPub(value),
                              ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (formProvider.rootForm != 'conferencias')
                              DropdownButtonFormField(
                                value: formProvider.pubBefore,
                                decoration: InputDecor.formFieldInputDecoration(label: appLocal.advisoryBefore, icon: Icons.abc_outlined),
                                dropdownColor: bgColor,
                                items: [
                                  DropdownMenuItem(value: true, child: Text(appLocal.si, style: DashboardLabel.h4)),
                                  DropdownMenuItem(value: false, child: Text('No', style: DashboardLabel.h4)),
                                ],
                                onChanged: (value) => formProvider.setPubBefore(value),
                              ),
                            if (formProvider.rootForm == 'conferencias')
                              DropdownButtonFormField(
                                value: formProvider.isOnlineConference,
                                decoration: InputDecor.formFieldInputDecoration(label: appLocal.deseasQueLaConf, icon: Icons.abc_outlined),
                                dropdownColor: bgColor,
                                items: [
                                  DropdownMenuItem(value: true, child: Text(appLocal.confOnline, style: DashboardLabel.h4)),
                                  DropdownMenuItem(value: false, child: Text(appLocal.confPresenc, style: DashboardLabel.h4)),
                                ],
                                onChanged: (value) => formProvider.setIsOnlineConference(value),
                              ),
                          ],
                        ),
                      ))
                ],
              ),
              const SizedBox(height: 30),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(width: 40),
                  IconButton(
                      splashRadius: 18,
                      onPressed: () {
                        if (formProvider.currentIndex != 0) {
                          formProvider.formScrollController.previousPage();
                          setState(() {});
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_circle_left_outlined,
                        color: azulText,
                        size: 18,
                      )),
                  const Spacer(),
                  BotonVerde(text: botonText, width: 100, onPressed: () => onPressed()),
                  const SizedBox(width: 40)
                ],
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
