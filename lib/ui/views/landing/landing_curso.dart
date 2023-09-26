import 'package:flutter/material.dart';

import 'package:jp_director/constant.dart';

import 'package:jp_director/ui/shared/labels/dashboard_label.dart';
import 'package:jp_director/ui/shared/widgets/acordion.dart';
import 'package:jp_director/ui/shared/widgets/top_area_back.dart';

import '../../../generated/l10n.dart';
import '../../../models/curso.dart';
import '../../../models/usuario_model.dart';
import '../../../providers/export_all_providers.dart';

import '../../../services/navigator_service.dart';

import '../../shared/botones/custom_button.dart';
import '../../shared/widgets/boton_quiero_ya.dart';
import '../../shared/widgets/list_testimonios.dart';
import '../../shared/widgets/soy_jpdirector_landing.dart';
import 'curso_info_top_area.dart';
import 'slider_curso.dart';

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
  
  

  @override
  Widget build(BuildContext context) {
    bool esMio = false;
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
        TopAreaBack(onPress: () => NavigatorService.navigateTo('/cursos')),
        CursoInfoTopArea(curso: widget.curso, esMio: esMio),
        const SizedBox(height: 80),
        SliderCurso(curso: widget.curso),
        const SizedBox(height: 60),
        Text(appLocal.conoceloQue, style: DashboardLabel.h1),
        const SizedBox(height: 30),
        Container(constraints: const BoxConstraints(maxWidth: 800), child: Column(children: modulos)),
        const SizedBox(height: 100),
        ListTestimonios(numeroEst: widget.curso.totalEstudiantes, testimonios: widget.curso.testimonios),
        const SizedBox(height: 60),
        const SoyJpdirectorLanding(),
        const SizedBox(height: 15),
        if(!widget.curso.preorder)
        BotonQuieroYa(curso: widget.curso),
        if(widget.curso.preorder)
        const CustomButton(
                    text: 'PROXIMAMENTE',
                    onPress: null,
                    width: 250,
                    color: Colors.orange,
                  ),
        const SizedBox(height: 100),
      ],
    );
  }
}
