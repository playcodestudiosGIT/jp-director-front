import 'package:flutter/material.dart';
import 'package:jpdirector_frontend/providers/all_cursos_provider.dart';
import 'package:jpdirector_frontend/providers/auth_provider.dart';
import 'package:jpdirector_frontend/ui/shared/labels/title_label.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
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
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    List<Widget> cursoDestruct = [];
    for (var curso in Provider.of<AllCursosProvider>(context, listen: false).allCursos) {
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
              const TitleLabel(texto: 'Mis Cursos'),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: Wrap(alignment: WrapAlignment.center, children: [
                    if (destruct.isEmpty)
                      Text(
                        'No tienes ningun curso',
                        style: DashboardLabel.paragraph,
                      ),
                    if (destruct.isNotEmpty) ...destruct
                  ]

                      //  ,
                      ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const TitleLabel(texto: 'Cursos Disponibles'),
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
                              'Ya tienes todos los cursos',
                              style: DashboardLabel.paragraph,
                            ),
                          ),
                        if (cursoDestruct.isNotEmpty) ...cursoDestruct
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
