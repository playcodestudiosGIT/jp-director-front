import 'package:flutter/material.dart';
import 'package:jp_director/constant.dart';
import 'package:jp_director/providers/auth_provider.dart';
import 'package:jp_director/router/router.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';
import 'package:jp_director/ui/shared/widgets/progreso.dart';
import 'package:jp_director/ui/shared/widgets/progress_ind.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../models/curso.dart';
import '../../providers/all_cursos_provider.dart';
import '../../providers/meta_event_provider.dart';
import '../../services/navigator_service.dart';
import 'white_card_border.dart';

class CourseCard extends StatelessWidget {
  final Curso curso;
  final bool esMio;

  const CourseCard({Key? key, required this.esMio, required this.curso})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: (!esMio)
            ? () {
                Provider.of<MetaEventProvider>(context, listen: false).clickEvent(
                    email: authProvider.user!.correo,
                    source: 'user/dashboard/miscursos',
                    description:
                        'user: ${authProvider.user!.uid} Curso ID: ${curso.id}, Nombre Curso: ${curso.nombre}, precio: ${curso.precio}',
                    title: 'Click Tarjeta de curso: ${curso.nombre}');
                NavigatorService.replaceTo(
                    '${Flurorouter.cursoLanding}/${curso.id}');
              }
            : () async {
                await Provider.of<AllCursosProvider>(context, listen: false)
                    .getAllCursos();

                if (authProvider.authStatus == AuthStatus.authenticated &&
                    context.mounted) {
                      Provider.of<MetaEventProvider>(context, listen: false).clickEvent(
                    email: authProvider.user!.correo,
                    source: 'user/dashboard/miscursos',
                    description:
                        'user: ${authProvider.user!.uid} Curso ID: ${curso.id}, Nombre Curso: ${curso.nombre}, precio: ${curso.precio}',
                    title: '${authProvider.user!.nombre} Entro a ver el curso: ${curso.nombre}');
                  NavigatorService.replaceTo(
                    
                      '${Flurorouter.curso}/${curso.id}/0');
                } else {
                  Provider.of<MetaEventProvider>(context, listen: false).clickEvent(
                    email: authProvider.user!.correo,
                    source: 'user/dashboard/miscursos',
                    description:
                        'user: ${authProvider.user!.uid} Curso ID: ${curso.id}, Nombre Curso: ${curso.nombre}, precio: ${curso.precio}',
                    title: '${authProvider.user!.nombre} le intereza el curso ${curso.nombre}');
                  NavigatorService.replaceTo(
                      '${Flurorouter.cursoLanding}/${curso.id}');
                }
              },
        child: SizedBox(
          width: 250,
          height: (esMio) ? 325 : 440,
          child: (curso.nombre == 'nombre')
              ? const ProgressInd()
              : WhiteCardBorder(
                  border: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            decoration: _cardDecoration(curso.img),
                            width: 250,
                            height: 230,
                          ),
                          Container(
                            width: 250,
                            height: 230,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      bgColor.withOpacity(1)
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: const [0.6, 1])),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                blancoText.withOpacity(0.1))),
                                    onPressed: () {
                                      Provider.of<MetaEventProvider>(context,
                                              listen: false)
                                          .clickEvent(
                                              email: authProvider.user!.correo,
                                              source:
                                                  'user/dashboard/miscursos',
                                              description:
                                                  'usuario: ${authProvider.user?.uid} Click en curso ${curso.id}',
                                              title:
                                                  'Click en Terminos de uso');
                                      NavigatorService.replaceTo(
                                          '${Flurorouter.curso}/${curso.id}/0');
                                    },
                                    child: (esMio)
                                        ? Text(appLocal.continuar,
                                            style: DashboardLabel.mini
                                                .copyWith(color: azulText))
                                        : Text(appLocal.verMas,
                                            style: DashboardLabel.mini
                                                .copyWith(color: azulText)))
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                          margin:
                              const EdgeInsets.only(left: 5, right: 5, top: 0),
                          child: Text(
                            curso.nombre,
                            style: DashboardLabel.h4,
                          )),
                      if (!esMio) ...[
                        const SizedBox(height: 5),
                        Container(
                            margin: const EdgeInsets.only(
                                left: 5, right: 5, top: 0),
                            child: Text(
                              '\$ ${curso.precio}.00',
                              style: DashboardLabel.h4,
                            )),
                        Container(
                            height: 90,
                            margin: const EdgeInsets.only(
                                left: 5, right: 5, top: 5),
                            child: Text(curso.descripcion,
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: DashboardLabel.paragraph.copyWith(
                                    color: blancoText.withOpacity(0.5)))),
                      ],
                      const SizedBox(height: 10),
                      if (esMio) ...[
                        SizedBox(
                            width: 220,
                            height: 30,
                            child: MiProgreso(curso: curso))
                      ],
                      if (!esMio) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Icon(Icons.view_module,
                                  color: blancoText.withOpacity(0.5), size: 18),
                              const SizedBox(width: 3),
                              Text(curso.modulos.length.toString(),
                                  style: DashboardLabel.paragraph),
                              const SizedBox(width: 30),
                              Icon(Icons.timer_outlined,
                                  color: blancoText.withOpacity(0.5), size: 18),
                              Text(curso.duracion,
                                  style: DashboardLabel.paragraph)
                            ],
                          ),
                        )
                      ]
                    ],
                  )),
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration(String img) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        image: DecorationImage(
          image: NetworkImage(img),
          fit: BoxFit.cover,
        ));
  }
}
