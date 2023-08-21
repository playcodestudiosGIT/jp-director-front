import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/models/curso.dart';
import 'package:jpdirector_frontend/providers/all_cursos_provider.dart';
import 'package:jpdirector_frontend/ui/shared/labels/dashboard_label.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';

import '../../../providers/auth_provider.dart';

import '../../shared/widgets/cursos_botones.dart';

class AdsView extends StatefulWidget {
  const AdsView({super.key});

  @override
  State<AdsView> createState() => _AdsViewState();
}

class _AdsViewState extends State<AdsView> {
  @override
  void initState() {
    super.initState();
    Provider.of<AllCursosProvider>(context, listen: false).getAllCursos();
  }

  @override
  Widget build(BuildContext context) {
    final List<Curso> cursos = Provider.of<AllCursosProvider>(context).allCursos;

    final List<Curso> listCursos = cursos.where((element) => element.publicado).toList();
    final wScreen = MediaQuery.of(context).size.width;
    final authProvider = Provider.of<AuthProvider>(context);
    if(listCursos.isEmpty){setState(() {});}
    return Padding(
      padding:
          (wScreen < 715 && authProvider.authStatus == AuthStatus.authenticated) ? const EdgeInsets.only(left: 0) : const EdgeInsets.only(left: 0),
      child: Stack(children: [
        Positioned(
            top: 90,
            right: 330,
            child: Transform.rotate(
              angle: 6,
              child: Opacity(
                opacity: 0.1,
                child: SlideInUp(
                  from: 100,
                  duration: const Duration(seconds: 10),
                  child: const Image(
                    image: rocketGif,
                    width: 200,
                  ),
                ),
              ),
            )),
        Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'APRENDE TODO SOBRE ADS',
                  style: GoogleFonts.roboto(fontSize: (wScreen > 580) ? 40 : 22, fontWeight: FontWeight.w900, color: blancoText),
                ),
              ),
              Container(
                width: (wScreen > 580) ? 548 : 400,
                height: 5,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  bgColor,
                  azulText,
                  bgColor,
                ])),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Cursos',
                style: DashboardLabel.h1,
              ),
              const SizedBox(
                height: 15,
              ),
              FutureBuilder(
                future: Provider.of<AllCursosProvider>(context, listen: false).getAllCursos(),
                builder: (context, snapshot) {
                  return Container(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Wrap(
                      spacing: 15,
                      runSpacing: 15,
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.center,
                      children: [
                        if (listCursos.isEmpty) const Center(child: SizedBox(width: 40, height: 40, child: CircularProgressIndicator())),
                        if (listCursos.isNotEmpty)
                          ...listCursos.map(
                            (e) => CursoImagen(
                              curso: e,
                            ),
                          )
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 60,
              ),
              SizedBox(
                width: 796,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Consigue clientes que quieran comprar tu producto o servicio utilizando la herramienta por la que llegaste aqui: Instagram - Facebook - Tik Tok',
                    textAlign: TextAlign.center,
                    style: DashboardLabel.h4.copyWith(color: blancoText.withOpacity(0.5)),
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
