import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jp_director/models/curso.dart';
import 'package:jp_director/providers/all_cursos_provider.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';

import '../../../generated/l10n.dart';
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
    Provider.of<AllCursosProvider>(context, listen: false).getAllCursos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<AllCursosProvider>(context, listen: false).getAllCursos();
    final appLocal = AppLocalizations.of(context);
    final List<Curso> cursos = Provider.of<AllCursosProvider>(context).allCursos;
    final List<Curso> listCursos = cursos.where((element) => element.publicado).toList();
    final wScreen = MediaQuery.of(context).size.width;
    if (listCursos.isEmpty) {
      setState(() {});
    }
    return Stack(children: [
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
                appLocal.aprendeTodoAds,
                style: GoogleFonts.roboto(fontSize: (wScreen > 580) ? 36 : 22, fontWeight: FontWeight.w900, color: blancoText),
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
            Row(
              children: [
                const SizedBox(width: 20),
                Text(
                  appLocal.cursos,
                  style: DashboardLabel.h1,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Stack(
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 1200, minHeight: 250),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        if (listCursos.isEmpty)
                          Center(
                              child: SizedBox(
                                  width: 200,
                                  height: 40,
                                  child: Text(
                                    appLocal.noTienesCursos,
                                    textAlign: TextAlign.center,
                                    style: DashboardLabel.mini.copyWith(color: blancoText.withOpacity(0.5)),
                                  ))),
                        if (listCursos.isNotEmpty)
                          ...listCursos.map(
                            (e) => CursoImagen(
                              curso: e,
                            ),
                          )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: -1,
                  child: Container(
                      width: 60,

                      height: 250,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                        bgColor,
                        Colors.transparent,
                      ], stops: [
                        0,
                        1
                      ])),
                    ),),
                Positioned(
                  right: -1,
                  child: Container(
                      width: 60,

                      height: 250,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                        Colors.transparent,
                        bgColor,
                      ], stops: [
                        0,
                        1
                      ])),
                    ),)
                
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 796,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  appLocal.consigueClientesQueQuieran,
                  textAlign: TextAlign.center,
                  style: DashboardLabel.h4.copyWith(color: blancoText.withOpacity(0.5)),
                ),
              ),
            )
          ],
        ),
      ),
    ]);
  }
}
