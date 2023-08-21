import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/models/certificado.dart';
import 'package:jpdirector_frontend/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import '../../../constant.dart';
import '../../../models/curso.dart';
import '../../../models/progress.dart';
import '../../../providers/all_cursos_provider.dart';
import '../../../providers/users_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import '../../../services/user_services.dart';
import '../../cards/white_card.dart';
import '../../shared/botones/boton_icon_redondo.dart';
import '../../shared/botones/custom_button.dart';
import '../../shared/labels/dashboard_label.dart';
import '../../shared/respuesta_widget.dart';

class CourseView extends StatefulWidget {
  final int videoIndex;
  final Curso cursoTmp;
  const CourseView({
    Key? key,
    required this.cursoTmp,
    this.videoIndex = 0,
  }) : super(key: key);

  @override
  State<CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  late Curso curso;
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  late Progress prog;
  bool isLoading = true;

  int videotime = 0;

  @override
  void initState() {
    curso = Provider.of<AllCursosProvider>(context, listen: false).cursoView;
    final user = Provider.of<AuthProvider>(context, listen: false).user;
    prog = user!.progress.where((element) => element.moduloId == curso.modulos[widget.videoIndex].id).first;
    Provider.of<AuthProvider>(context, listen: false).isAutenticated();
    videoPlayerController = VideoPlayerController.network(curso.modulos[widget.videoIndex].video)
      ..initialize().then((_) {
        isLoading = false;
        setState(() {});
      });
    chewieController = ChewieController(
      startAt: Duration(seconds: prog.marker),
      placeholder: Container(decoration: const BoxDecoration(image: DecorationImage(image: logoGrande))),
      hideControlsTimer: const Duration(milliseconds: 1000),
      materialProgressColors: ChewieProgressColors(bufferedColor: azulText.withOpacity(0.3), playedColor: azulText, backgroundColor: bgColor),
      cupertinoProgressColors: ChewieProgressColors(bufferedColor: bgColor, backgroundColor: bgColor),
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: false,
      aspectRatio: 16 / 9,
    );

    videoPlayerController.addListener(() async {
      if (videotime > videoPlayerController.value.duration.inSeconds - 15) {
        videotime = 0;
        int index = widget.videoIndex;
        if (index >= widget.cursoTmp.modulos.length - 1) {
          index = 0;
        } else {
          index++;
        }
      }
      if (videotime == videoPlayerController.value.duration.inSeconds && !prog.isComplete) {
        await Provider.of<AuthProvider>(context, listen: false).updateProg(moduloId: prog.moduloId, marker: videotime, isComplete: true);
      }
      if (videotime == prog.marker + 15) {
        if (context.mounted) {
          await Provider.of<AuthProvider>(context, listen: false).updateProg(moduloId: prog.moduloId, marker: videotime, isComplete: prog.isComplete);
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() async {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wScreen = MediaQuery.of(context).size.width;
    final hScreen = MediaQuery.of(context).size.height;
    videoPlayerController.addListener(() {
      setState(() {
        videotime = videoPlayerController.value.position.inSeconds;
      });
    });
    final authProvider = Provider.of<AuthProvider>(context);
    final ids = [];
    final List<Progress> progresses = [];

    for (var i in curso.modulos) {
      ids.add(i.id);
    }

    for (var i in ids) {
      progresses.add(authProvider.user!.progress.where((element) => element.moduloId == i).first);
    }

    final total = progresses.length;
    final pont = progresses.where((element) => element.isComplete).length;

    final percent = pont / total * 100;

    final Certificado cert = authProvider.user!.certificados.firstWhere(
      (element) => element.cursoId == curso.id,
      orElse: () => certDummy,
    );

    return (curso.nombre == '')
        ? const Center(child: SizedBox(width: 35, height: 35, child: CircularProgressIndicator()))
        : Scaffold(
            backgroundColor: Colors.transparent,
            endDrawer: CustomEndDrawer(
              cursoID: widget.cursoTmp.id,
              videoIndex: widget.videoIndex,
            ),
            body: Container(
                width: wScreen,
                height: hScreen,
                // color: bgColor,
                padding: (wScreen < 715) ? const EdgeInsets.only(left: 0) : const EdgeInsets.only(left: 10),
                child: ListView(children: [
                  Column(children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Stack(children: [
                      Row(
                        children: [
                          if (wScreen > 325) const SizedBox(width: 10),
                          if (wScreen <= 325) const SizedBox(width: 5),
                          IconButton(
                              onPressed: () {
                                NavigatorService.replaceTo(Flurorouter.clienteMisCursosDash);
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: blancoText,
                              )),
                          const SizedBox(width: 10),
                          Text(
                            curso.nombre,
                            style: (wScreen <= 400) ? DashboardLabel.h4.copyWith(color: blancoText) : DashboardLabel.h1.copyWith(color: blancoText),
                          ),
                          const Spacer(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(width: 8),
                              if (percent == 100.0 && cert.urlPdf == 'urlPdf')
                                TextButton(
                                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(blancoText.withOpacity(0.1))),
                                    onPressed: () async {
                                      final dialog = AlertDialog(
                                          backgroundColor: Colors.transparent,
                                          content: FutureBuilder(
                                            future: Provider.of<AllCursosProvider>(context, listen: false)
                                                .generarCert(userId: authProvider.user!.uid, cursoId: curso.id),
                                            builder: (context, snapshot) {
                                              late final Certificado? newCert;

                                              if (snapshot.hasData) {
                                                newCert = snapshot.data;
                                              }
                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                return Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(
                                                      width: 35,
                                                      height: 35,
                                                      child: CircularProgressIndicator(),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Text(
                                                      'Generando Certificado',
                                                      style: DashboardLabel.h3,
                                                    )
                                                  ],
                                                );
                                              } else {
                                                return Container(
                                                  padding: const EdgeInsets.all(5),
                                                  color: bgColor,
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  constraints: const BoxConstraints(maxWidth: 300, maxHeight: 350),
                                                  child: Center(
                                                    child: Stack(
                                                      alignment: Alignment.topCenter,
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              children: [
                                                                MouseRegion(
                                                                  cursor: SystemMouseCursors.click,
                                                                  child: GestureDetector(
                                                                      onTap: () {
                                                                        Navigator.pop(context, true);
                                                                      },
                                                                      child: const CircleAvatar(
                                                                        backgroundColor: Colors.red,
                                                                        radius: 15,
                                                                        child: Center(
                                                                            child: Icon(
                                                                          Icons.clear,
                                                                          color: blancoText,
                                                                        )),
                                                                      )),
                                                                ),
                                                              ],
                                                            ),
                                                            const Icon(
                                                              Icons.check_circle_outline_outlined,
                                                              color: Colors.green,
                                                              size: 200,
                                                            ),
                                                            SizedBox(
                                                              width: 280,
                                                              child: Text(
                                                                'Felicidades, tu certificado esta listo!',
                                                                textAlign: TextAlign.center,
                                                                style: DashboardLabel.h4,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 15,
                                                            ),
                                                            Row(
                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              children: [
                                                                TextButton.icon(
                                                                  style: ButtonStyle(
                                                                      backgroundColor: MaterialStatePropertyAll(azulText.withOpacity(0.1))),
                                                                  onPressed: () {
                                                                    final Uri url = Uri.parse(newCert!.urlPdf);
                                                                    launchUrl(url);
                                                                  },
                                                                  icon: const Icon(
                                                                    Icons.remove_red_eye,
                                                                    color: azulText,
                                                                  ),
                                                                  label: Text(
                                                                    'VER',
                                                                    style: DashboardLabel.h4.copyWith(color: azulText),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          ));

                                      await showDialog(context: context, builder: (context) => dialog);
                                      authProvider.isAutenticated();
                                    },
                                    child: (wScreen < 500)
                                        ? const Icon(Icons.workspace_premium_outlined)
                                        : Text(
                                            'CERTIFICADO',
                                            style: DashboardLabel.paragraph.copyWith(color: azulText),
                                          )),
                              if (percent == 100.0 && cert.urlPdf != 'urlPdf') ...[
                                if (wScreen >= 400)
                                  TextButton(
                                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(blancoText.withOpacity(0.1))),
                                      onPressed: () {
                                        final Uri url = Uri.parse(cert.urlPdf);
                                        launchUrl(url);
                                      },
                                      child: Text(
                                        'VER CERTIFICADO',
                                        style: DashboardLabel.paragraph.copyWith(color: azulText),
                                      )),
                                if (wScreen < 400)
                                  BotonRedondoIcono(
                                    fillColor: azulText,
                                    iconColor: bgColor,
                                    icon: Icons.workspace_premium_outlined,
                                    onTap: () {
                                      final Uri url = Uri.parse(cert.urlPdf);
                                      launchUrl(url);
                                    },
                                  )
                              ],
                              const SizedBox(width: 8),
                              Stack(
                                children: [
                                  if (wScreen > 325)
                                    Positioned(
                                        top: (percent == 100.0) ? 7 : 11,
                                        left: 7,
                                        child: (percent == 100.0)
                                            ? const Icon(
                                                Icons.check,
                                                color: Colors.green,
                                                size: 20,
                                              )
                                            : Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  const SizedBox(width: 20),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Text(percent.toStringAsFixed(0),
                                                          textAlign: TextAlign.center,
                                                          style: DashboardLabel.mini.copyWith(color: blancoText, fontSize: 10)),
                                                      Text('%', textAlign: TextAlign.center, style: DashboardLabel.mini.copyWith(color: blancoText)),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                  Container(
                                    margin: const EdgeInsets.all(2),
                                    width: (wScreen < 325) ? 20 : 30,
                                    height: (wScreen < 325) ? 20 : 30,
                                    child: CircularProgressIndicator(
                                      value: pont / total,

                                      color: (percent == 100.0) ? Colors.green : azulText,
                                      backgroundColor: Colors.white.withOpacity(0.3),

                                      // valueColor: ,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 30,
                          )
                        ],
                      ),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    if (wScreen > 1210)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            constraints: const BoxConstraints(maxWidth: 1200, minWidth: 1000),
                            height: hScreen - 150,
                            child: SingleChildScrollView(
                              child: WhiteCard(
                                  title: curso.modulos[widget.videoIndex].nombre,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          AspectRatio(
                                              aspectRatio: 16 / 9,
                                              child: Container(
                                                  margin: const EdgeInsets.symmetric(horizontal: 15),
                                                  width: double.infinity,
                                                  // height: 400,                                          // color: Colors.black,
                                                  child: Builder(
                                                    builder: (context) {
                                                      return Chewie(
                                                        controller: chewieController,
                                                      );
                                                    },
                                                  ))),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 15),
                                              child: Row(
                                                children: [
                                                  CustomButton(
                                                    text: 'Ver Material',
                                                    onPress: () {
                                                      final url = Uri.parse(
                                                          'https://drive.google.com/drive/folders/${curso.modulos[widget.videoIndex].idDriveFolder}?usp=sharing');
                                                      launchUrl(url);
                                                    },
                                                    width: 200,
                                                    icon: Icons.download_outlined,
                                                  ),
                                                  const SizedBox(width: 15),
                                                  BotonRedondoIcono(
                                                      fillColor: azulText,
                                                      iconColor: bgColor,
                                                      icon: Icons.file_download,
                                                      onTap: () {
                                                        final url = Uri.parse(
                                                            'https://drive.google.com/uc?id=${curso.modulos[widget.videoIndex].idDriveZip}&export=download');
                                                        launchUrl(url);
                                                      }),
                                                ],
                                              )),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                        ],
                                      )),
                                      SizedBox(
                                        // constraints: const BoxConstraints(minWidth: 250),
                                        width: wScreen * 0.16,

                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              ...curso.modulos.map((e) {
                                                final user = Provider.of<AuthProvider>(context).user;
                                                int i = curso.modulos.indexOf(e);

                                                final Progress prog = user!.progress.where((element) => element.moduloId == e.id).first;
                                                return Column(
                                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    ListTile(
                                                      minLeadingWidth: 20,
                                                      leading: SizedBox(
                                                          width: 35,
                                                          height: 35,
                                                          child: Checkbox(
                                                            fillColor: MaterialStateProperty.all(azulText),
                                                            checkColor: bgColor,
                                                            value: prog.isComplete,
                                                            onChanged: (value) async {
                                                              await Provider.of<AuthProvider>(context, listen: false)
                                                                  .updateProg(moduloId: e.id, marker: videotime, isComplete: !prog.isComplete);
                                                              if (context.mounted) {
                                                                setState(() {});
                                                              }
                                                            },
                                                          )),
                                                      title: Text(
                                                        e.nombre,
                                                        style: DashboardLabel.paragraph,
                                                      ),
                                                      subtitle: Text(
                                                        e.descripcion,
                                                        style: DashboardLabel.mini.copyWith(color: blancoText.withOpacity(0.5)),
                                                      ),
                                                      onTap: () {
                                                        chewieController.togglePause();
                                                        NavigatorService.replaceTo('${Flurorouter.curso}${curso.id}/$i');
                                                      },
                                                    ),
                                                    // Row(
                                                    //   mainAxisAlignment: MainAxisAlignment.end,
                                                    //   children: [
                                                    //     Row(children: [
                                                    //       const Icon(Icons.ondemand_video_outlined, size: 15, color: Colors.black38),
                                                    //       const SizedBox(width: 10),
                                                    //       Text('2hr', style: DashboardLabel.mini.copyWith(color: Colors.black38))
                                                    //     ]),
                                                    //   ],
                                                    // ),
                                                    Divider(
                                                      color: blancoText.withOpacity(0.5),
                                                    ),
                                                  ],
                                                );
                                              }),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      ),
                    if (wScreen <= 1210)
                      WhiteCard(
                          title: curso.modulos[widget.videoIndex].nombre,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: (wScreen < 390) ? const EdgeInsets.only(left: 0) : const EdgeInsets.symmetric(horizontal: 15),
                                        width: double.infinity,
                                        height: 400,
                                        // color: Colors.black,
                                        child: (isLoading)
                                            ? const Center(child: SizedBox(width: 35, height: 35, child: CircularProgressIndicator()))
                                            : Chewie(
                                                controller: chewieController,
                                              )),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        child: Row(
                                          children: [
                                            CustomButton(
                                              text: 'Ver Material',
                                              onPress: () {
                                                final url = Uri.parse(
                                                    'https://drive.google.com/drive/folders/${curso.modulos[widget.videoIndex].idDriveFolder}?usp=sharing');
                                                launchUrl(url);
                                              },
                                              width: 200,
                                              icon: Icons.download_outlined,
                                            ),
                                            const SizedBox(width: 15),
                                            BotonRedondoIcono(
                                                fillColor: azulText,
                                                iconColor: bgColor,
                                                icon: Icons.file_download,
                                                onTap: () {
                                                  final url = Uri.parse(
                                                      'https://drive.google.com/uc?id=${curso.modulos[widget.videoIndex].idDriveZip}&export=download');
                                                  launchUrl(url);
                                                }),
                                          ],
                                        )),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                // height: 500,
                                child: Column(
                                  children: [
                                    ...curso.modulos.map((e) {
                                      final user = Provider.of<AuthProvider>(context).user;
                                      int i = curso.modulos.indexOf(e);
                                      final Progress prog = user!.progress.where((element) => element.moduloId == e.id).first;
                                      Provider.of<AllCursosProvider>(context).videoIndex = i;

                                      return Column(
                                        children: [
                                          ListTile(
                                            minLeadingWidth: 20,
                                            leading: SizedBox(
                                                width: 35,
                                                height: 35,
                                                child: Checkbox(
                                                  fillColor: MaterialStateProperty.all(azulText),
                                                  checkColor: bgColor,
                                                  value: prog.isComplete,
                                                  onChanged: (value) async {
                                                    await Provider.of<AuthProvider>(context, listen: false)
                                                        .updateProg(moduloId: e.id, marker: videotime, isComplete: !prog.isComplete);
                                                    if (context.mounted) {
                                                      setState(() {});
                                                    }
                                                  },
                                                )),
                                            title: Text(
                                              e.nombre,
                                              style: DashboardLabel.paragraph,
                                            ),
                                            subtitle: Text(e.descripcion, style: DashboardLabel.mini.copyWith(color: blancoText.withOpacity(0.5))),
                                            onTap: () {
                                              chewieController.pause();
                                              NavigatorService.replaceTo('${Flurorouter.curso}/${curso.id}/$i');
                                            },
                                          ),
                                          Divider(
                                            color: blancoText.withOpacity(0.5),
                                          ),
                                        ],
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ],
                          )),
                  ]),
                ])),
          );
  }
}

class CustomEndDrawer extends StatefulWidget {
  final int videoIndex;
  final String cursoID;
  const CustomEndDrawer({super.key, required this.videoIndex, required this.cursoID});

  @override
  State<CustomEndDrawer> createState() => _CustomEndDrawerState();
}

class _CustomEndDrawerState extends State<CustomEndDrawer> {
  String comentario = '';
  final GlobalKey<FormState> keyform = GlobalKey();

  @override
  void initState() {
    super.initState();
    Provider.of<AllCursosProvider>(context, listen: false).getAllCursos();
    Provider.of<AllCursosProvider>(context, listen: false).getCursosById(widget.cursoID);
    Provider.of<UsersProvider>(context, listen: false).getPaginatedUsers();
  }

  @override
  Widget build(BuildContext context) {
    final curso = Provider.of<AllCursosProvider>(context).cursoView;
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          width: 250,
          height: double.infinity,
          color: bgColor,
          child: ListView(
            children: [
              const SizedBox(height: 70),
              Text('Lista de comentarios', style: DashboardLabel.mini),
              const SizedBox(height: 10),
              Divider(color: Colors.white.withOpacity(0.5)),
              const SizedBox(height: 15),
              ...curso.modulos[widget.videoIndex].coments.map((comentario) {
                final userComent = UserServices.getUserInfo(context, comentario.usuario);
                return ListTile(
                  title: Column(
                    children: [
                      if (userComent != null)
                        Row(children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(userComent.img),
                            radius: 10,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '${userComent.nombre} ${userComent.apellido}', // e.id
                            style: DashboardLabel.paragraph,
                          ),
                          if (userComent.rol == 'ADMIN_ROLE') ...[
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.star,
                              color: Colors.amberAccent,
                              size: 15,
                            )
                          ]
                        ]),
                      const SizedBox(height: 10),
                      if (userComent == null)
                        const Center(
                            child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))),
                      Container(
                        padding: const EdgeInsets.all(4),
                        width: double.infinity,
                        constraints: const BoxConstraints(minHeight: 25),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.white.withOpacity(0.1)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            comentario.comentario,
                            style: DashboardLabel.mini,
                          ),
                        ),
                      ),
                      if (comentario.resp.isNotEmpty)
                        ...comentario.resp.map(
                          (resp) {
                            final userResp = UserServices.getUserInfo(context, resp.usuario);

                            return ListTile(
                              title: RespuestaWidget(
                                img: userResp?.img ?? '',
                                nombre: userResp?.nombre ?? '',
                                apellido: userResp?.apellido ?? '',
                                rol: userResp?.rol ?? 'USER_ROLE',
                                respuesta: resp.respuesta,
                              ),
                            );
                          },
                        ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Row(
                          //   children: [
                          //     // IconButton(
                          //     //     onPressed: () {},
                          //     //     icon: const Icon(
                          //     //       Icons.arrow_circle_up_outlined,
                          //     //       color: azulText,
                          //     //       size: 20,
                          //     //     )),
                          //     // Text(
                          //     //   '26',
                          //     //   style: DashboardLabel.mini,
                          //     // ),
                          //   ],
                          // ),

                          if (Provider.of<AuthProvider>(context, listen: false).user!.rol == 'ADMIN_ROLE') ...[
                            IconButton(
                              onPressed: () async {
                                final isOk = await showDialog(
                                    context: context,
                                    builder: (context) {
                                      final moduloId = curso.modulos[widget.videoIndex].id;
                                      return AlertDialog(
                                        actionsPadding: const EdgeInsets.only(bottom: 20),
                                        backgroundColor: bgColor,
                                        content: Container(
                                            constraints: const BoxConstraints(maxWidth: 320, maxHeight: 140),
                                            child: DialogResp(comentId: comentario.id, moduloId: moduloId)),
                                      );
                                    });
                                if (isOk && context.mounted) {
                                  Provider.of<AllCursosProvider>(context, listen: false).getCursosById(widget.cursoID);
                                }
                              },
                              icon: const Icon(
                                Icons.question_answer_outlined,
                                size: 15,
                              ),
                              color: Colors.green,
                            ),
                            IconButton(
                              onPressed: () async {
                                final dialog = AlertDialog(
                                  backgroundColor: bgColor,
                                  content: Container(
                                    constraints: const BoxConstraints(maxHeight: 90),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Seguro que desea borrar el comentario?',
                                          style: DashboardLabel.h4,
                                        ),
                                        const SizedBox(height: 30),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            CustomButton(
                                              text: 'Borrar',
                                              onPress: () {
                                                final moduloId = curso.modulos[widget.videoIndex].id;
                                                Provider.of<AllCursosProvider>(context, listen: false)
                                                    .deleteComent(comentId: comentario.id, moduloId: moduloId);
                                                Navigator.pop(context, true);
                                              },
                                              width: 100,
                                              color: Colors.red,
                                            ),
                                            const SizedBox(width: 10),
                                            CustomButton(
                                                text: 'Cancelar',
                                                onPress: () {
                                                  Navigator.pop(context, false);
                                                },
                                                width: 100)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );

                                final isOk = await showDialog(
                                  context: context,
                                  builder: (context) => dialog,
                                );

                                if (isOk && context.mounted) {
                                  Provider.of<AllCursosProvider>(context, listen: false).getCursosById(widget.cursoID);
                                }
                              },
                              icon: const Icon(
                                Icons.delete_outline,
                                size: 15,
                              ),
                              color: Colors.red,
                            )
                          ]
                        ],
                      ),
                      const SizedBox(height: 5),
                      Divider(
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 15),
              Center(child: Text('Fin de los comentarios', style: DashboardLabel.mini)),
              const SizedBox(height: 250)
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            child: Container(
              color: bgColor,
              width: 250,
              height: 170,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: keyform,
                    child: Container(
                        width: double.infinity,
                        // constraints: const BoxConstraints(minHeight: 90),

                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        // decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(25)),
                        child: TextFormField(
                          initialValue: comentario,
                          style: DashboardLabel.mini,
                          validator: (value) {
                            if (value == null || value.isEmpty || value.length < 3) return 'Comentario Invalido';
                            return null;
                          },
                          decoration: buildInputDecoration(label: 'Agrega un comentario', icon: Icons.comment_outlined),
                          maxLines: 3,
                          onChanged: (value) {
                            setState(() {
                              comentario = value;
                            });
                          },
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        text: 'Comentar',
                        onPress: () => setState(() {
                          if (keyform.currentState!.validate()) {
                            Provider.of<AllCursosProvider>(context, listen: false)
                                .createComent(comentario: comentario, cursoId: curso.id, moduloId: curso.modulos[widget.videoIndex].id);
                            comentario = '';
                            Navigator.pop(context);
                          }
                        }),
                        width: 100,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 5)
                    ],
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text('Un administrador respondera tu pregunta', style: DashboardLabel.mini.copyWith(color: blancoText.withOpacity(0.5))),
                  ),
                  const SizedBox(height: 10)
                ],
              ),
            )),
      ],
    );
  }

  InputDecoration buildInputDecoration({required String label, required IconData icon, IconData? suffIcon, Function? onPrs}) => InputDecoration(
      fillColor: blancoText.withOpacity(0.03),
      filled: true,
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: azulText),
      ),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: azulText.withOpacity(0.3))),
      labelText: label,
      labelStyle: GoogleFonts.roboto(color: blancoText, fontSize: 14),
      prefixIcon: Icon(icon, color: azulText.withOpacity(0.3)),
      suffixIconColor: azulText.withOpacity(0.3));
}

class DialogResp extends StatefulWidget {
  final String comentId;
  const DialogResp({super.key, required this.comentId, required String moduloId});

  @override
  State<DialogResp> createState() => _DialogRespState();
}

class _DialogRespState extends State<DialogResp> {
  String textValue = '';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 380, minWidth: 380),
            child: TextFormField(
              maxLines: 5,
              style: GoogleFonts.roboto(color: Colors.white.withOpacity(0.3), fontSize: 12),
              initialValue: textValue,
              onChanged: (value) => {textValue = value}, //descripcion = value,
              decoration: buildInputDecoration(
                label: 'Respuesta',
                icon: Icons.question_answer,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                text: 'Responder',
                onPress: () {
                  Provider.of<AllCursosProvider>(context, listen: false).createResp(id: widget.comentId, respuesta: textValue);
                  Navigator.pop(context, true);
                },
                width: 100,
                color: Colors.green,
              ),
              const SizedBox(width: 10),
              CustomButton(
                text: 'Cancelar',
                onPress: () {
                  Navigator.pop(context, false);
                },
                width: 100,
                color: Colors.red,
              ),
            ],
          )
        ],
      ),
    );
  }
}

InputDecoration buildInputDecoration({required String label, required IconData icon, IconData? suffIcon, Function? onPrs}) => InputDecoration(
    fillColor: blancoText.withOpacity(0.03),
    filled: true,
    border: const OutlineInputBorder(
      borderSide: BorderSide(color: azulText),
    ),
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: azulText.withOpacity(0.3))),
    labelText: label,
    labelStyle: GoogleFonts.roboto(color: blancoText, fontSize: 14),
    prefixIcon: Icon(icon, color: azulText.withOpacity(0.3)),
    suffixIconColor: azulText.withOpacity(0.3));
