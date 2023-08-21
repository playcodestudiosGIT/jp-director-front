import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/constant.dart';
import 'package:jpdirector_frontend/ui/shared/botones/custom_button.dart';
import 'package:jpdirector_frontend/ui/shared/labels/dashboard_label.dart';
import 'package:jpdirector_frontend/ui/shared/widgets/acordion.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/curso.dart';
import '../../../models/usuario_model.dart';
import '../../../providers/all_cursos_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/pay_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import '../../shared/widgets/testimonio.dart';

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
    List<Widget> listSliders = [
      const DiapoItem(
        bigText: 'Emprendedor o Freelancer',
        bigIcon: Icons.laptop,
        text:
            'Si eres emprendedor, tienes un negocio o quieres una formación que verdaderamente capacite a tu equipo a lanzar campañas de manera correcta',
      ),
      const DiapoItem(
        bigText: 'Dueños de Negocios',
        bigIcon: Icons.person_pin_outlined,
        text:
            'Ves publicidad todo el tiempo en tu teléfono y sabes que tu negocio lo necesita para darse a conocer y vender más. Esta formación te ayudará a entender como hacerlo y su importancia.',
      ),
      const DiapoItem(
        bigText: 'Negocio (Local o físico)',
        bigIcon: Icons.home_outlined,
        text:
            'Tienda de ropa, restaurante, gimnasio, bar o cualquier negocio que necesita tráfico en su tienda para consumir su producto o servicio.',
      ),
      const DiapoItem(
        bigText: 'Profesionales en Marketing y Comunicación',
        bigIcon: Icons.people_alt_outlined,
        text:
            'Si estás estudiando o trabajando en una empresa esto será muy valioso para desarrollarlo dentro de la compañía u ofrecerlo como uno de tus servicios.',
      ),
      const DiapoItem(
        bigText: 'Consultores o Especialistas',
        bigIcon: Icons.lightbulb_outline,
        text:
            'Eres médico, coach, realtor, abogado o nutricionista y tus servicios son altamente buscados en las redes sociales, por lo que solo falta exponerte de la manera correcta en publicidad.',
      ),
      const DiapoItem(
        bigText: 'Inhabilitados, Resagados o Bloqueados',
        bigIcon: Icons.visibility_off_outlined,
        text:
            'Si estás estudiando o trabajando en una empresa esto será muy valioso para desarrollarlo dentro de la compañía u ofrecerlo como uno de tus servicios.',
      ),
    ];

    final List<Widget> listTestimonio = [
      const Testimonio(
        img:
            'https://static.wixstatic.com/media/b69ab8_f97ce7c31e2d4208a8c6a3bc7a34f661~mv2.png/v1/fill/w_200,h_200,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/image%204.png',
        nombre: 'Saylin Vazquez de Alltech',
        testimonio: '“Me ha encantado, es muy completo y un mundo de conocimiento. Para mi negocio este curso logró un antes y un después”.',
      ),
      const Testimonio(
        img:
            'https://static.wixstatic.com/media/b69ab8_bfb7361501fa4e6cab4a6e7335f5aff5~mv2.png/v1/fill/w_200,h_200,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/image%206.png',
        nombre: 'Anier Cruz',
        testimonio:
            '“Estudié informática y un montón de educación. Luego de ver el curso no solo recuperé mi inversión sino que además puedo correr mis propia publicidad, gracias JP”.',
      ),
      const Testimonio(
        img:
            'https://static.wixstatic.com/media/b69ab8_cd0d5d47774a490095e8f7fd9243b853~mv2.png/v1/fill/w_200,h_200,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/image%207.png',
        nombre: 'Tania Crespo',
        testimonio: '“Tengo ideas y planes para desarrollar por 6 meses gracias a este curso. Todo el que lo vea entenderá luego de aprender con JP”',
      ),
      const Testimonio(
        img:
            'https://static.wixstatic.com/media/b69ab8_ce68c5011d4f41a08e14db52ebad8c05~mv2.png/v1/fill/w_200,h_200,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/image%205.png',
        nombre: 'German Gamboa',
        testimonio:
            '“En 1 mes logré tener más de 100 clientes potenciales con mis campañas de publicidad. A todo el que quiera aprender le recomiendo este curso.”',
      ),
    ];
    final wSize = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: (wSize < 615)
          ? MobileBody(
              curso: curso,
              listSliders: listSliders,
              listTestimonio: listTestimonio,
            )
          : WebBody(
              curso: curso,
              listSliders: listSliders,
              listTestimonio: listTestimonio,
            ),
    );
  }
}

class WebBody extends StatefulWidget {
  final List<Widget> listSliders;
  final List<Widget> listTestimonio;
  final Curso curso;

  const WebBody({super.key, required this.curso, required this.listSliders, required this.listTestimonio});

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

    pageController = PageController(initialPage: currIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Usuario user = Provider.of<AuthProvider>(context).user ?? usuarioDummy;

    if (user.nombre == '') {
      esMio = false;
    }

    if (user.nombre != '' && user.cursos.contains(widget.curso.id)) {
      esMio = true;
    }
    final authProvider = Provider.of<AuthProvider>(context);
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
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 800, minHeight: 280),
                  child: (widget.curso.baner == '')
                      ? const Center(
                          child: SizedBox(
                            width: 35,
                            height: 35,
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Image(
                          image: NetworkImage(widget.curso.baner),
                        ),
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 800, minHeight: 280),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [bgColor, Colors.transparent],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      stops: [0.1, 0.6],
                    ),
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 800, minHeight: 280),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        width: 200,
                        height: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Spacer(),
                            if (!esMio)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '\$ ',
                                    style: DashboardLabel.gigant.copyWith(color: const Color(0xffFFEF98), fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    widget.curso.precio,
                                    style: DashboardLabel.gigant.copyWith(color: const Color(0xffFFEF98), fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '.00',
                                    style: DashboardLabel.h2.copyWith(color: const Color(0xffFFEF98), fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            if (esMio)
                              Text(
                                'Ya tienes este curso',
                                style: DashboardLabel.mini,
                              ),
                            const SizedBox(height: 10),
                            if (esMio)
                              CustomButton(
                                  text: 'Continuar',
                                  onPress: () {
                                    NavigatorService.replaceTo('${Flurorouter.curso}/${widget.curso.id}/0');
                                  },
                                  width: 250),
                            if (!esMio)
                              CustomButton(
                                  text: 'Comprar',
                                  onPress: () async {
                                    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
                                      NavigatorService.replaceTo('${Flurorouter.payNewUserRouteAlt}/${widget.curso.id}/login');
                                    }
                                    if (authProvider.authStatus == AuthStatus.authenticated) {
                                      final resp = await Provider.of<PayProvider>(context, listen: false).createSession(
                                          price: int.parse(widget.curso.precio), cursoId: widget.curso.id, userEmail: authProvider.user!.correo);
                                      if (resp != '') {
                                        final Uri urluri = Uri.parse(resp);
                                        if (!await launchUrl(urluri)) {
                                          throw Exception('Could not launch $urluri');
                                        }
                                      }
                                    }
                                  },
                                  width: 250),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 30),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          constraints: const BoxConstraints(maxWidth: 800),
          width: double.infinity,
          child: Text(
            'Actualizado 2023',
            style: DashboardLabel.h4.copyWith(color: const Color(0xffFFEF98), fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 15),
        Container(
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
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Esta misión es para ti', style: DashboardLabel.h1),
                    ],
                  ),
                  Expanded(
                      child: PageView(
                    controller: pageController,
                    scrollDirection: Axis.horizontal,
                    children: widget.listSliders,
                  )),
                ],
              ),
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
        Text('Conoce lo que aprenderas', style: DashboardLabel.h1),
        const SizedBox(height: 30),
        Container(constraints: const BoxConstraints(maxWidth: 800), child: Column(children: modulos)),
        const SizedBox(height: 100),
        Text('Ellos vivieron la misión', style: DashboardLabel.h1),
        Text('Quiero Ads', style: DashboardLabel.h1),
        Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('+', style: DashboardLabel.gigant.copyWith(fontSize: 80, color: const Color(0xffFFEF98))),
                Text(
                  '250',
                  style: GoogleFonts.raleway(fontSize: 85, fontWeight: FontWeight.bold, color: blancoText),
                )
              ])
            ])),
        Text('estudiantes', style: DashboardLabel.h1.copyWith(color: const Color(0xffFFEF98))),
        const SizedBox(height: 60),
        Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.listTestimonio,
              )),
        ),
        const SizedBox(height: 60),
        Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Wrap(children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 400, minWidth: 300),
              child: Column(
                children: [
                  Text('Soy JP Director', style: DashboardLabel.h1.copyWith(color: const Color(0xffFFEF98))),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Desde hace 4 años me dedico a potenciar marcas y negocios con estrategias efectivas en ads que dan en el punto. \n\nEn todo el proceso he manejado una cantidad de \$1.000.000 USD en campañas publicitarias, logrando \$15.000.000 USD en ventas por internet. Luego de innumerables pruebas, análisis y educación, decidí realizar esta experiencia grupal para enseñarle a emprendedores, dueños de negocio o equipos de marketing a entender el motor que es realizar campañas publicitarias.',
                    style: DashboardLabel.h4.copyWith(height: 1.4, color: blancoText.withOpacity(0.5)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Container(
                constraints: const BoxConstraints(maxWidth: 400, minWidth: 300),
                child: const Image(
                    image: NetworkImage(
                        'https://static.wixstatic.com/media/b69ab8_f5760d9dc3e54e7497e4c4d419c95cd2~mv2.png/v1/fill/w_508,h_674,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/DSC032987.png')))
          ]),
        ),
        const SizedBox(height: 60),
        Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                  text: 'QUIERO ESTE CURSO YA',
                  onPress: () async {
                    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
                      NavigatorService.replaceTo('${Flurorouter.payNewUserRouteAlt}/${widget.curso.id}/login');
                    }
                    if (authProvider.authStatus == AuthStatus.authenticated) {
                      final resp = await Provider.of<PayProvider>(context, listen: false)
                          .createSession(price: int.parse(widget.curso.precio), cursoId: widget.curso.id, userEmail: authProvider.user!.correo);
                      if (resp != '') {
                        final Uri urluri = Uri.parse(resp);
                        if (!await launchUrl(urluri)) {
                          throw Exception('Could not launch $urluri');
                        }
                      }
                    }
                  },
                  width: 250)
            ],
          ),
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}

class MobileBody extends StatefulWidget {
  final Curso curso;
  final List<Widget> listSliders;
  final List<Widget> listTestimonio;
  const MobileBody({super.key, required this.curso, required this.listSliders, required this.listTestimonio});

  @override
  State<MobileBody> createState() => _MobileBodyState();
}

class _MobileBodyState extends State<MobileBody> {
  bool esMio = false;
  int currIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Usuario user = Provider.of<AuthProvider>(context).user ?? usuarioDummy;
    if (user.nombre == '') {
      esMio = false;
    }

    if (user.nombre != '' && user.cursos.contains(widget.curso.id)) {
      esMio = true;
    }
    final authProvider = Provider.of<AuthProvider>(context);

    final List<Widget> modulos = widget.curso.modulos.map((e) {
      return Acordeon(title: e.nombre, content: e.descripcion);
    }).toList();
    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              children: [
                const SizedBox(height: 70),
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
                Container(
                  constraints: const BoxConstraints(maxWidth: 250),
                  child: (widget.curso.img == '') ? const CircularProgressIndicator() : Image(image: NetworkImage(widget.curso.img)),
                ),
              ],
            ),
            Positioned(
                top: 120,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    colors: [bgColor, Colors.transparent],
                    end: Alignment.topCenter,
                    begin: Alignment.bottomCenter,
                  )),
                )),
            Positioned(
              bottom: 0,
              child: Container(
                width: 250,
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Spacer(),
                        Text(
                          widget.curso.precio,
                          style: DashboardLabel.gigant.copyWith(color: const Color(0xffFFEF98), fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        if (esMio) ...[
          Text(
            'Ya tienes este curso',
            style: DashboardLabel.mini,
          ),
          CustomButton(
              text: 'continuar',
              onPress: () async {
                NavigatorService.replaceTo('${Flurorouter.curso}/${widget.curso.id}/0');
              },
              width: 250),
        ],
        if (!esMio) ...[
          CustomButton(
              text: 'Comprar',
              onPress: () async {
                if (authProvider.authStatus == AuthStatus.notAuthenticated) {
                  NavigatorService.replaceTo('${Flurorouter.payNewUserRouteAlt}/${widget.curso.id}/login');
                }
                if (authProvider.authStatus == AuthStatus.authenticated) {
                  final resp = await Provider.of<PayProvider>(context, listen: false)
                      .createSession(price: int.parse(widget.curso.precio), cursoId: widget.curso.id, userEmail: authProvider.user!.correo);
                  if (resp != '') {
                    final Uri urluri = Uri.parse(resp);
                    if (!await launchUrl(urluri)) {
                      throw Exception('Could not launch $urluri');
                    }
                  }
                }
              },
              width: 250),
        ],
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Text(
                'Actualizado 2023',
                style: DashboardLabel.h4.copyWith(color: const Color(0xffFFEF98), fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          constraints: const BoxConstraints(maxWidth: 800),
          child: Text(
            widget.curso.descripcion,
            textAlign: TextAlign.start,
            style: DashboardLabel.h4.copyWith(height: 1.4),
          ),
        ),
        const SizedBox(height: 80),
        Container(
          constraints: const BoxConstraints(maxWidth: 800, maxHeight: 500),
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Esta misión es para ti', style: DashboardLabel.h1),
                    ],
                  ),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 800, maxHeight: 450),
                    child: Expanded(
                        child: PageView(
                      controller: pageController,
                      scrollDirection: Axis.horizontal,
                      children: widget.listSliders,
                    )),
                  ),
                ],
              ),
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
                                    pageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                                  } else {
                                    currIndex = currIndex + 1;
                                    pageController.animateToPage(currIndex, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                                  }
                                },
                                child: const SizedBox(width: 30, height: 30, child: Icon(Icons.arrow_circle_right_outlined, color: azulText))),
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
        Text('Conoce lo que aprenderas', style: DashboardLabel.h1),
        const SizedBox(height: 30),
        Container(constraints: const BoxConstraints(maxWidth: 800), child: Column(children: modulos)),
        const SizedBox(height: 100),
        Text('Ellos vivieron la misión', style: DashboardLabel.h1),
        Text('Quiero Ads', style: DashboardLabel.h1),
        Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('+', style: DashboardLabel.gigant.copyWith(fontSize: 80, color: const Color(0xffFFEF98))),
                Text(
                  '250',
                  style: GoogleFonts.raleway(fontSize: 85, fontWeight: FontWeight.bold, color: blancoText),
                )
              ])
            ])),
        Text('estudiantes', style: DashboardLabel.h1.copyWith(color: const Color(0xffFFEF98))),
        const SizedBox(height: 60),
        Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: widget.listTestimonio)),
        ),
        const SizedBox(height: 60),
        Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Wrap(children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 400, minWidth: 300),
              child: Column(
                children: [
                  Text('Soy JP Director', style: DashboardLabel.h1.copyWith(color: const Color(0xffFFEF98))),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Desde hace 4 años me dedico a potenciar marcas y negocios con estrategias efectivas en ads que dan en el punto. \n\nEn todo el proceso he manejado una cantidad de \$1.000.000 USD en campañas publicitarias, logrando \$15.000.000 USD en ventas por internet. Luego de innumerables pruebas, análisis y educación, decidí realizar esta experiencia grupal para enseñarle a emprendedores, dueños de negocio o equipos de marketing a entender el motor que es realizar campañas publicitarias.',
                      style: DashboardLabel.h4.copyWith(height: 1.4, color: blancoText.withOpacity(0.5)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Container(
                constraints: const BoxConstraints(maxWidth: 400, minWidth: 300),
                child: const Image(
                    image: NetworkImage(
                        'https://static.wixstatic.com/media/b69ab8_f5760d9dc3e54e7497e4c4d419c95cd2~mv2.png/v1/fill/w_508,h_674,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/DSC032987.png')))
          ]),
        ),
        const SizedBox(height: 60),
        Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (esMio) ...[
          Text(
            'Ya tienes este curso',
            style: DashboardLabel.mini,
          ),
          CustomButton(
              text: 'continuar',
              onPress: () async {
                NavigatorService.replaceTo('${Flurorouter.curso}/${widget.curso.id}/0');
              },
              width: 250),
        ],
        if (!esMio) ...[
          CustomButton(
              text: 'Quiero este curso YA!',
              onPress: () async {
                if (authProvider.authStatus == AuthStatus.notAuthenticated) {
                  NavigatorService.replaceTo('${Flurorouter.payNewUserRouteAlt}/${widget.curso.id}/login');
                }
                if (authProvider.authStatus == AuthStatus.authenticated) {
                  final resp = await Provider.of<PayProvider>(context, listen: false)
                      .createSession(price: int.parse(widget.curso.precio), cursoId: widget.curso.id, userEmail: authProvider.user!.correo);
                  if (resp != '') {
                    final Uri urluri = Uri.parse(resp);
                    if (!await launchUrl(urluri)) {
                      throw Exception('Could not launch $urluri');
                    }
                  }
                }
              },
              width: 250),
        ],
            ],
          ),
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}

class DiapoItem extends StatelessWidget {
  final IconData bigIcon;
  final String bigText;
  final String text;
  const DiapoItem({super.key, required this.bigIcon, required this.bigText, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(bigIcon, size: 120, color: blancoText),
            const SizedBox(height: 15),
            Text(bigText, style: DashboardLabel.h2),
            const SizedBox(height: 15),
            Container(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Text(text, style: DashboardLabel.h4.copyWith(color: blancoText.withOpacity(0.5))))
          ],
        ),
      ),
    );
  }
}
