import 'package:flutter/material.dart';

import 'package:jp_director/constant.dart';


import 'package:jp_director/ui/shared/labels/dashboard_label.dart';
import 'package:jp_director/ui/shared/widgets/acordion.dart';

import '../../../generated/l10n.dart';
import '../../../models/curso.dart';
import '../../../models/usuario_model.dart';
import '../../../providers/export_all_providers.dart';

import '../../../services/navigator_service.dart';

import '../../shared/widgets/boton_quiero_ya.dart';
import '../../shared/widgets/curso_baner.dart';
import '../../shared/widgets/curso_landing_slider.dart';
import '../../shared/widgets/list_testimonios.dart';
import '../../shared/widgets/soy_jpdirector_landing.dart';

class LandingCurso extends StatefulWidget {
  final String cursoID;
  const LandingCurso({super.key, required this.cursoID});

  @override
  State<LandingCurso> createState() => _LandingCursoState();
}

class _LandingCursoState extends State<LandingCurso> {
  @override
  void initState() {
    Provider.of<AllCursosProvider>(context, listen: false).getCursosById(widget.cursoID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Curso curso = Provider.of<AllCursosProvider>(context).cursoView;

    return SingleChildScrollView(
      child: WebBody(
        curso: curso,
      ),
    );
  }
}

class WebBody extends StatefulWidget {
  final Curso curso;

  const WebBody({super.key, required this.curso});

  @override
  State<WebBody> createState() => _WebBodyState();
}

class _WebBodyState extends State<WebBody> {
  bool esMio = false;
  int currIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    Provider.of<AllCursosProvider>(context, listen: false).getCursosById(widget.curso.id);
    pageController = PageController(initialPage: currIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final Usuario user = Provider.of<AuthProvider>(context).user ?? usuarioDummy;

    if (user.nombre == '') {
      esMio = false;
    }

    if (user.nombre != '' && user.cursos.contains(widget.curso.id)) {
      esMio = true;
    }

    final List<Widget> modulos = widget.curso.modulos.map((e) {
      return Acordeon(title: e.nombre, content: e.descripcion);
    }).toList();

    return Column(
      children: [
        const SizedBox(height: 80),
        Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              constraints: const BoxConstraints(maxWidth: 800),
              child: IconButton(
                  onPressed: () {
                    NavigatorService.navigateTo('/cursos');
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: azulText,
                    size: 30,
                  )),
            ),
            CursoBanerView(curso: widget.curso, esMio: esMio)
          ],
        ),
        const SizedBox(height: 30),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          constraints: const BoxConstraints(maxWidth: 800),
          width: double.infinity,
          child: Text(
            appLocal.actualizado2023,
            style: DashboardLabel.h4.copyWith(color: const Color(0xffFFEF98), fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 15),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          constraints: const BoxConstraints(maxWidth: 800),
          child: Text(
            widget.curso.descripcion,
            textAlign: TextAlign.start,
            style: DashboardLabel.h4.copyWith(height: 1.4, color: blancoText.withOpacity(0.5)),
          ),
        ),
        const SizedBox(height: 80),
        Container(
          constraints: const BoxConstraints(maxWidth: 800, maxHeight: 400),
          child: Stack(
            children: [
              CursoLandingSlider(pageController: pageController),
              Column(
                children: [
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                                onTap: () {
                                  if (currIndex == 0) {
                                    currIndex = 5;

                                    pageController.animateToPage(5, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                                  } else {
                                    currIndex = currIndex - 1;
                                    pageController.animateToPage(currIndex, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                                  }
                                },
                                child: const SizedBox(width: 30, height: 30, child: Icon(Icons.arrow_circle_left_outlined, color: azulText))),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                                onTap: () {
                                  if (currIndex == 5) {
                                    currIndex = 0;
                                    pageController.animateToPage(
                                      0,
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.ease,
                                    );
                                  } else {
                                    currIndex = currIndex + 1;
                                    pageController.animateToPage(
                                      currIndex,
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.ease,
                                    );
                                  }
                                },
                                child: const SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Icon(Icons.arrow_circle_right_outlined, color: azulText),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 60),
        Text(appLocal.conoceloQue, style: DashboardLabel.h1),
        const SizedBox(height: 30),
        Container(constraints: const BoxConstraints(maxWidth: 800), child: Column(children: modulos)),
        const SizedBox(height: 100),
        const ListTestimonios(),
        const SizedBox(height: 60),
        const SoyJpdirectorLanding(),
        BotonQuieroYa(curso: widget.curso),
        const SizedBox(height: 100),
      ],
    );
  }
}
