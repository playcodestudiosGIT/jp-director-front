import 'package:flutter/material.dart';
import 'package:jp_director/providers/all_cursos_provider.dart';
import 'package:jp_director/providers/auth_provider.dart';
import 'package:jp_director/ui/shared/labels/title_label.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../cards/curso_card.dart';
import '../../shared/labels/dashboard_label.dart';

class DashMisCursosView extends StatefulWidget {
  const DashMisCursosView({super.key});

  @override
  State<DashMisCursosView> createState() => _DashMisCursosViewState();
}

class _DashMisCursosViewState extends State<DashMisCursosView> {
  @override
  void initState() {
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).isAutenticated();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    Provider.of<AllCursosProvider>(context, listen: false).getAllCursos();
    Provider.of<AllCursosProvider>(context, listen: false).obtenerMisCursos(authProvider.user!);
  }

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final wSize = MediaQuery.of(context).size.width;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    List<Widget> cursoDestruct = [];
    for (var curso in Provider.of<AllCursosProvider>(context).allCursos) {
      if (!authProvider.user!.cursos.contains(curso.id)) {
        cursoDestruct.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CourseCard(
            curso: curso,
            esMio: false,
          ),
        ));
        continue;
      }
    }
    final destruct = Provider.of<AllCursosProvider>(context).misCursos.map((e) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: CourseCard(
            curso: e,
            esMio: true,
          ),
        ));
    return Container(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
                top: 90,
                right: 230,
                child: Transform.rotate(
                  angle: 16,
                  child: const Opacity(
                    opacity: 0.1,
                    child: Image(
                      image: rocketGif,
                      width: 280,
                    ),
                  ),
                )),
            ListView(physics: const ClampingScrollPhysics(), children: [
              const SizedBox(
                height: 80,
              ),
              TitleLabel(texto: appLocal.misCursosLabel),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center, children: [
                    if (destruct.isEmpty)
                      Text(
                        appLocal.noTienesCursos,
                        style: DashboardLabel.paragraph,
                      ),
                    if (destruct.isNotEmpty) ...destruct,
                    if (wSize > 500)
                    const SizedBox(width: 85, height: 10),
                  ]

                      //  ,
                      ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TitleLabel(texto: appLocal.cursosDisponibles),
              SizedBox(
                  height: 435,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (cursoDestruct.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 60),
                            child: Text(
                              appLocal.yaTienesTodos,
                              style: DashboardLabel.paragraph,
                            ),
                          ),
                        if (cursoDestruct.isNotEmpty) ...cursoDestruct,
                        const SizedBox(width: 85, height: 10)
                      ],
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
            ]),
          ],
        ));
  }
}
