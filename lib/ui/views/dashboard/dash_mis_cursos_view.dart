import 'package:flutter/material.dart';
import 'package:jpdirector_frontend/providers/all_cursos_provider.dart';
import 'package:jpdirector_frontend/providers/auth_provider.dart';
import 'package:jpdirector_frontend/providers/baners_provider.dart';
import 'package:jpdirector_frontend/ui/shared/widgets/cursos_botones.dart';
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
    Provider.of<BanersProvider>(context, listen: false).getBaners();
    Provider.of<AllCursosProvider>(context, listen: false).obtenerMisCursos(authProvider.user!);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    List<Widget> banerDestruct = [];
    for (var baner in Provider.of<BanersProvider>(context, listen: false).baners) {
      if (!authProvider.user!.cursos.contains(baner.cursoId)) {
        banerDestruct.add(CursoImagen(priceId: baner.priceId, img: baner.img, cursoId: baner.cursoId));
        continue;
      }
    }
    final destruct = Provider.of<AllCursosProvider>(context).misCursos.map((e) => CourseCard(
          uid: e.id,
          name: e.nombre,
          subtitle: e.subtitle,
          description: e.descripcion,
          image: e.img,
          duration: e.duracion,
          modulos: e.modulos.length.toString(),
        ));
    final wScreen = MediaQuery.of(context).size.width;
    return Container(
        color: bgColor,
        padding: (wScreen < 715) ? const EdgeInsets.only(left: 45) : const EdgeInsets.only(left: 10),
        child: Stack(
          children: [
            const Positioned(
                bottom: -400,
                left: -450,
                child: SizedBox(
                  height: 900,
                  child: Image(
                    image: circulo,
                  ),
                )),
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
            const Positioned(
                bottom: -400,
                right: -450,
                child: SizedBox(
                  height: 700,
                  child: Image(
                    image: circulo,
                  ),
                )),
            ListView(physics: const ClampingScrollPhysics(), children: [
              const SizedBox(
                height: 80,
              ),
              SizedBox(
                height: 40,
                child: Text(
                  'Cursos Disponibles',
                  style: DashboardLabel.h1.copyWith(color: blancoText),
                ),
              ),
              SizedBox(
                height: 100,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...banerDestruct
                    ],
                  ),
                )
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                'Mis Cursos',
                style: DashboardLabel.h1.copyWith(color: blancoText),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [if (destruct.isEmpty) const CircularProgressIndicator(), if (destruct.isNotEmpty) ...destruct]

                      //  ,
                      ),
                ),
              ),
            ]),
          ],
        ));
  }
}
