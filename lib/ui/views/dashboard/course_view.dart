import 'package:animate_do/animate_do.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:jp_director/models/certificado.dart';
import 'package:jp_director/providers/auth_provider.dart';
import 'package:jp_director/ui/shared/labels/inputs_decorations.dart';
import 'package:jp_director/ui/shared/widgets/progress_ind.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart';
import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../models/curso.dart';
import '../../../models/progress.dart';
import '../../../providers/all_cursos_provider.dart';
import '../../../providers/events_provider.dart';
import '../../../providers/users_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import '../../../services/user_services.dart';
import '../../cards/white_card.dart';
import '../../shared/botones/boton_icon_redondo.dart';
import '../../shared/botones/custom_button.dart';
import '../../shared/labels/dashboard_label.dart';
import '../../shared/widgets/gen_cert_dialog.dart';
import '../../shared/widgets/respuesta_widget.dart';

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
  bool isComplete = false;
  double percent = 0;
  bool isLoading = false;

  int videotime = 0;

  @override
  void initState() {
    curso = Provider.of<AllCursosProvider>(context, listen: false).cursoView;
    final user = Provider.of<AuthProvider>(context, listen: false).user;
    prog = user!.progress
        .where((element) =>
            element.moduloId == curso.modulos[widget.videoIndex].id)
        .first;
    // isComplete = prog.isComplete;
    Provider.of<AuthProvider>(context, listen: false).isAutenticated();
    final Uri url = Uri.parse(curso.modulos[widget.videoIndex].video);
    videoPlayerController = VideoPlayerController.networkUrl(url,
        videoPlayerOptions: VideoPlayerOptions(
            webOptions: const VideoPlayerWebOptions(
                allowContextMenu: false, allowRemotePlayback: true)));

    chewieController = ChewieController(
        startAt: Duration(seconds: prog.marker),
        placeholder: Container(
            decoration:
                const BoxDecoration(image: DecorationImage(image: logoGrande))),
        hideControlsTimer: const Duration(milliseconds: 1000),
        materialProgressColors: ChewieProgressColors(
            bufferedColor: azulText.withOpacity(0.3),
            playedColor: azulText,
            backgroundColor: bgColor),
        cupertinoProgressColors: ChewieProgressColors(
            bufferedColor: bgColor, backgroundColor: bgColor),
        videoPlayerController: videoPlayerController,
        autoPlay: false,
        looping: false,
        aspectRatio: 16 / 9,
        autoInitialize: true);

    videoPlayerController.addListener(() async {
      if (videotime == videoPlayerController.value.duration.inSeconds &&
          isComplete == false) {
        isComplete = true;
        Provider.of<AuthProvider>(context, listen: false).updateProg(
            moduloId: curso.modulos[widget.videoIndex].id,
            marker: 0,
            isComplete: true);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
              barrierColor: Colors.transparent,
              context: context,
              builder: (context) => CongratDialog(cursoNombre: curso.nombre));
        });
      }
    });

    videoPlayerController.addListener(() async {
      if (videotime == prog.marker + 30) {
        Provider.of<AuthProvider>(context, listen: false).updateProg(
            moduloId: prog.moduloId,
            marker: videotime - 1,
            isComplete: prog.isComplete);
        prog.marker = videotime;
      }
    });
    videoPlayerController.addListener(() async {
      if (videotime == prog.marker + 30) {
        Provider.of<AuthProvider>(context, listen: false).updateProg(
            moduloId: prog.moduloId,
            marker: videotime - 1,
            isComplete: prog.isComplete);
        prog.marker = videotime;
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isComplete) {
        showDialog(
            barrierColor: Colors.transparent,
            context: context,
            builder: (context) => CongratDialog(cursoNombre: curso.nombre));
      }
      setState(() {
        isComplete = false;
      });
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
    curso = Provider.of<AllCursosProvider>(context).cursoView;
    final appLocal = AppLocalizations.of(context);
    final wScreen = MediaQuery.of(context).size.width;
    final hScreen = MediaQuery.of(context).size.height;
    final authProvider = Provider.of<AuthProvider>(context);
    late double percent;
    final ids = [];
    final List<Progress> progresses = [];

    for (var i in curso.modulos) {
      ids.add(i.id);
    }

    for (var i in ids) {
      progresses.add(authProvider.user!.progress
          .where((element) => element.moduloId == i)
          .first);
    }

    final total = progresses.length;
    final pont = progresses.where((element) => element.isComplete).length;
    percent = pont / total * 100;
    final Certificado cert = authProvider.user!.certificados.firstWhere(
      (element) => element.cursoId == curso.id,
      orElse: () => certDummy,
    );
    final modulos = curso.modulos.where((m) => m.estado).toList();
    videoPlayerController.addListener(() {
      setState(() {
        videotime = videoPlayerController.value.position.inSeconds;
      });
    });

    if (percent == 100) isComplete = true;

    return (curso.nombre == '')
        ? const ProgressInd()
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
                padding: (wScreen < 715)
                    ? const EdgeInsets.only(left: 0)
                    : const EdgeInsets.only(left: 10),
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
                              splashRadius: 18,
                              onPressed: () {
                                NavigatorService.replaceTo(
                                    Flurorouter.clienteMisCursosDash);
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: azulText,
                                size: 18,
                              )),
                          const SizedBox(width: 10),
                          Text(
                            curso.nombre,
                            style: (wScreen <= 500)
                                ? DashboardLabel.h4.copyWith(color: blancoText)
                                : DashboardLabel.h1.copyWith(color: blancoText),
                          ),
                          const Spacer(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(width: 8),
                              if (percent == 100.0 && cert.urlPdf == 'urlPdf')
                                TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                blancoText.withOpacity(0.1))),
                                    onPressed: () async {
                                      await showDialog(
                                          context: context,
                                          builder: (context) =>
                                              const GenCertDialog());
                                      authProvider.isAutenticated();
                                    },
                                    child: (wScreen < 500)
                                        ? const Icon(
                                            Icons.workspace_premium_outlined,
                                            size: 18,
                                          )
                                        : Text(
                                            appLocal.certificadoBtn,
                                            style: DashboardLabel.paragraph
                                                .copyWith(color: azulText),
                                          )),
                              if (percent == 100.0 &&
                                  cert.urlPdf != 'urlPdf') ...[
                                if (wScreen >= 400)
                                  TextButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  blancoText.withOpacity(0.1))),
                                      onPressed: () {
                                        Provider.of<EventsProvider>(context,
                                                listen: false)
                                            .clickEvent(
                                                uid: authProvider.user!.uid,
                                                email:
                                                    authProvider.user!.correo,
                                                source:
                                                    'user/dashboard/${curso.id}',
                                                description:
                                                    'Click en Certificado',
                                                title:
                                                    'Generó Certificado ${curso.nombre} - ${curso.modulos[widget.videoIndex].nombre}');
                                        final Uri url = Uri.parse(cert.urlPdf);
                                        launchUrl(url);
                                      },
                                      child: Text(
                                        appLocal.certificadoBtn,
                                        style: DashboardLabel.paragraph
                                            .copyWith(color: azulText),
                                      )),
                                if (wScreen < 400)
                                  BotonRedondoIcono(
                                    fillColor: azulText,
                                    iconColor: bgColor,
                                    icon: Icons.workspace_premium_outlined,
                                    onTap: () {
                                      Provider.of<EventsProvider>(context,
                                              listen: false)
                                          .clickEvent(
                                              uid: authProvider.user!.uid,
                                              email: authProvider.user!.correo,
                                              source:
                                                  'user/dashboard/${curso.id}',
                                              description:
                                                  'Click en Certificado',
                                              title:
                                                  'Generó Certificado ${curso.nombre} - ${curso.modulos[widget.videoIndex].nombre}');
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const SizedBox(width: 20),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          percent
                                                              .toStringAsFixed(
                                                                  0),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: DashboardLabel
                                                              .mini
                                                              .copyWith(
                                                                  color:
                                                                      blancoText,
                                                                  fontSize:
                                                                      10)),
                                                      Text('%',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: DashboardLabel
                                                              .mini
                                                              .copyWith(
                                                                  color:
                                                                      blancoText)),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                  Container(
                                    margin: const EdgeInsets.all(2),
                                    width: (wScreen < 325) ? 20 : 30,
                                    height: (wScreen < 325) ? 20 : 30,
                                    child: CircularProgressIndicator(
                                      value: percent / 100,

                                      color: (percent == 100.0)
                                          ? Colors.green
                                          : azulText,
                                      backgroundColor:
                                          Colors.white.withOpacity(0.3),

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
                            constraints: const BoxConstraints(
                                maxWidth: 1200, minWidth: 1000),
                            height: hScreen - 150,
                            child: SingleChildScrollView(
                              child: WhiteCard(
                                  title:
                                      curso.modulos[widget.videoIndex].nombre,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AspectRatio(
                                              aspectRatio: 16 / 9,
                                              child: Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 15),
                                                  width: double.infinity,
                                                  // height: 400,                                          // color: Colors.black,
                                                  child: Builder(
                                                    builder: (context) {
                                                      return Chewie(
                                                        controller:
                                                            chewieController,
                                                      );
                                                    },
                                                  ))),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15),
                                              child: Row(
                                                children: [
                                                  if (curso
                                                          .modulos[
                                                              widget.videoIndex]
                                                          .idDriveFolder !=
                                                      '')
                                                    CustomButton(
                                                      text: appLocal
                                                          .verMaterialBtn,
                                                      onPress: () {
                                                        final url = Uri.parse(
                                                            'https://drive.google.com/drive/folders/${curso.modulos[widget.videoIndex].idDriveFolder}?usp=sharing');
                                                        launchUrl(url);
                                                      },
                                                      width: 200,
                                                      icon: Icons
                                                          .download_outlined,
                                                    ),
                                                  const SizedBox(width: 15),
                                                  if (curso
                                                          .modulos[
                                                              widget.videoIndex]
                                                          .idDriveZip !=
                                                      '')
                                                    BotonRedondoIcono(
                                                        fillColor: azulText,
                                                        iconColor: bgColor,
                                                        icon:
                                                            Icons.file_download,
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
                                        width: wScreen * 0.2,

                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              ...modulos.map((e) {
                                                final user =
                                                    Provider.of<AuthProvider>(
                                                            context)
                                                        .user;
                                                int i =
                                                    curso.modulos.indexOf(e);

                                                final Progress prog = user!
                                                    .progress
                                                    .where((element) =>
                                                        element.moduloId ==
                                                        e.id)
                                                    .first;
                                                return Column(
                                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    ListTile(
                                                      minLeadingWidth: 0,
                                                      leading: SizedBox(
                                                          width: 35,
                                                          height: 35,
                                                          child: Checkbox(
                                                            fillColor: MaterialStateProperty
                                                                .all(azulText
                                                                    .withOpacity(
                                                                        0.1)),
                                                            checkColor:
                                                                azulText,
                                                            value:
                                                                prog.isComplete,
                                                            onChanged:
                                                                (value) async {
                                                              await Provider.of<
                                                                          AuthProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .updateProg(
                                                                      moduloId:
                                                                          e.id,
                                                                      marker:
                                                                          videotime,
                                                                      isComplete:
                                                                          !prog
                                                                              .isComplete);

                                                              if (context
                                                                  .mounted) {
                                                                setState(() {});
                                                              }
                                                            },
                                                          )),
                                                      title: Text(
                                                        e.nombre,
                                                        style: DashboardLabel
                                                            .paragraph,
                                                      ),
                                                      subtitle: Text(
                                                        e.descripcion,
                                                        style: DashboardLabel
                                                            .mini
                                                            .copyWith(
                                                                color: blancoText
                                                                    .withOpacity(
                                                                        0.5)),
                                                      ),
                                                      onTap: () {
                                                        chewieController
                                                            .togglePause();
                                                        Provider.of<EventsProvider>(
                                                                context,
                                                                listen: false)
                                                            .clickEvent(
                                                                uid: authProvider
                                                                    .user!.uid,
                                                                email:
                                                                    authProvider
                                                                        .user!
                                                                        .correo,
                                                                source:
                                                                    'user/dashboard/${curso.id}',
                                                                description:
                                                                    'Click en Modulo ${curso.modulos[i].nombre} de ${curso.nombre}',
                                                                title:
                                                                    'Click en Modulo ${curso.nombre} - ${curso.modulos[i].nombre}');
                                                        NavigatorService.replaceTo(
                                                            '${Flurorouter.curso}/${curso.id}/$i');
                                                      },
                                                    ),
                                                    Divider(
                                                      color: blancoText
                                                          .withOpacity(0.5),
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
                                    GestureDetector(
                                      onSecondaryTap: () {},
                                      child: Container(
                                          margin: (wScreen < 390)
                                              ? const EdgeInsets.only(left: 0)
                                              : const EdgeInsets.symmetric(
                                                  horizontal: 15),
                                          width: double.infinity,
                                          height: 400,
                                          // color: Colors.black,
                                          child: (isLoading)
                                              ? const ProgressInd()
                                              : Chewie(
                                                  controller: chewieController,
                                                )),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          children: [
                                            if (curso.modulos[widget.videoIndex]
                                                    .idDriveFolder !=
                                                '')
                                              CustomButton(
                                                text: appLocal.verMaterialBtn,
                                                onPress: () {
                                                  Provider.of<EventsProvider>(
                                                          context,
                                                          listen: false)
                                                      .clickEvent(
                                                          uid: authProvider
                                                              .user!.uid,
                                                          email: authProvider
                                                              .user!.correo,
                                                          source:
                                                              'user/dashboard/${curso.id}',
                                                          description:
                                                              'Click en Ver Material',
                                                          title:
                                                              'Vió Material ${curso.nombre} - ${curso.modulos[widget.videoIndex].nombre}');
                                                  final url = Uri.parse(
                                                      'https://drive.google.com/drive/folders/${curso.modulos[widget.videoIndex].idDriveFolder}?usp=sharing');
                                                  launchUrl(url);
                                                },
                                                width: 200,
                                                icon: Icons.download_outlined,
                                              ),
                                            const SizedBox(width: 15),
                                            if (curso.modulos[widget.videoIndex]
                                                    .idDriveZip !=
                                                '')
                                              BotonRedondoIcono(
                                                  fillColor: azulText,
                                                  iconColor: bgColor,
                                                  icon: Icons.file_download,
                                                  onTap: () {
                                                    Provider.of<EventsProvider>(
                                                            context,
                                                            listen: false)
                                                        .clickEvent(
                                                            uid: authProvider
                                                                .user!.uid,
                                                            email: authProvider
                                                                .user!.correo,
                                                            source:
                                                                'user/dashboard/${curso.id}',
                                                            description:
                                                                'Click en Descargar Material',
                                                            title:
                                                                'Descargó Material ${curso.nombre} - ${curso.modulos[widget.videoIndex].nombre}');
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
                                    ...modulos.map((e) {
                                      final user =
                                          Provider.of<AuthProvider>(context)
                                              .user;
                                      int i = curso.modulos.indexOf(e);
                                      final Progress prog = user!.progress
                                          .where((element) =>
                                              element.moduloId == e.id)
                                          .first;
                                      Provider.of<AllCursosProvider>(context)
                                          .videoIndex = i;

                                      return (!e.estado)
                                          ? Container()
                                          : Column(
                                              children: [
                                                ListTile(
                                                  minLeadingWidth: 20,
                                                  leading: SizedBox(
                                                      width: 50,
                                                      height: 50,
                                                      child: Checkbox(
                                                        fillColor:
                                                            MaterialStateProperty
                                                                .all(azulText
                                                                    .withOpacity(
                                                                        0.1)),
                                                        checkColor: azulText,
                                                        value: prog.isComplete,
                                                        onChanged:
                                                            (value) async {
                                                          await Provider.of<
                                                                      AuthProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .updateProg(
                                                                  moduloId:
                                                                      e.id,
                                                                  marker:
                                                                      videotime,
                                                                  isComplete: !prog
                                                                      .isComplete);
                                                          if (context.mounted) {
                                                            setState(() {});
                                                          }
                                                        },
                                                      )),
                                                  title: Text(
                                                    e.nombre,
                                                    style: DashboardLabel
                                                        .paragraph,
                                                  ),
                                                  subtitle: Text(e.descripcion,
                                                      style: DashboardLabel.mini
                                                          .copyWith(
                                                              color: blancoText
                                                                  .withOpacity(
                                                                      0.5))),
                                                  onTap: () {
                                                    chewieController.pause();
                                                    Provider.of<EventsProvider>(
                                                            context,
                                                            listen: false)
                                                        .clickEvent(
                                                            uid: authProvider
                                                                .user!.uid,
                                                            email: authProvider
                                                                .user!.correo,
                                                            source:
                                                                'user/dashboard/${curso.id}',
                                                            description:
                                                                'Click en Modulo ${curso.modulos[i].nombre} de ${curso.nombre}',
                                                            title:
                                                                'Click en Modulo ${curso.nombre} - ${curso.modulos[i].nombre}');
                                                    NavigatorService.replaceTo(
                                                        '${Flurorouter.curso}/${curso.id}/$i');
                                                  },
                                                ),
                                                Divider(
                                                  color: blancoText
                                                      .withOpacity(0.5),
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
  const CustomEndDrawer(
      {super.key, required this.videoIndex, required this.cursoID});

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
    Provider.of<AllCursosProvider>(context, listen: false)
        .getCursosById(widget.cursoID);
    Provider.of<UsersProvider>(context, listen: false).getPaginatedUsers();
  }

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
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
              Text(appLocal.listaDeComentarios, style: DashboardLabel.mini),
              const SizedBox(height: 10),
              Divider(color: Colors.white.withOpacity(0.5)),
              const SizedBox(height: 15),
              ...curso.modulos[widget.videoIndex].coments.map((comentario) {
                final userComent =
                    UserServices.getUserInfo(context, comentario.usuario);
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
                      if (userComent == null) const ProgressInd(),
                      Container(
                        padding: const EdgeInsets.all(4),
                        width: double.infinity,
                        constraints: const BoxConstraints(minHeight: 25),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white.withOpacity(0.1)),
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
                            final userResp =
                                UserServices.getUserInfo(context, resp.usuario);

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
                          if (Provider.of<AuthProvider>(context, listen: false)
                                  .user!
                                  .rol ==
                              'ADMIN_ROLE') ...[
                            IconButton(
                              onPressed: () async {
                                final isOk = await showDialog(
                                    context: context,
                                    builder: (context) {
                                      final moduloId =
                                          curso.modulos[widget.videoIndex].id;
                                      return AlertDialog(
                                        actionsPadding:
                                            const EdgeInsets.only(bottom: 20),
                                        backgroundColor: bgColor,
                                        content: Container(
                                            constraints: const BoxConstraints(
                                                maxWidth: 320, maxHeight: 140),
                                            child: DialogResp(
                                                comentId: comentario.id,
                                                moduloId: moduloId)),
                                      );
                                    });
                                if (isOk && context.mounted) {
                                  Provider.of<AllCursosProvider>(context,
                                          listen: false)
                                      .getCursosById(widget.cursoID);
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
                                    constraints:
                                        const BoxConstraints(maxHeight: 90),
                                    child: Column(
                                      children: [
                                        Text(
                                          appLocal.seguroBorrarComent,
                                          style: DashboardLabel.h4,
                                        ),
                                        const SizedBox(height: 30),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            CustomButton(
                                              text: appLocal.siBorrar,
                                              onPress: () {
                                                final moduloId = curso
                                                    .modulos[widget.videoIndex]
                                                    .id;
                                                Provider.of<AllCursosProvider>(
                                                        context,
                                                        listen: false)
                                                    .deleteComent(
                                                        comentId: comentario.id,
                                                        moduloId: moduloId);
                                                Navigator.pop(context, true);
                                              },
                                              width: 100,
                                              color: Colors.red,
                                            ),
                                            const SizedBox(width: 10),
                                            CustomButton(
                                                text: appLocal.cancelarBtn,
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
                                  Provider.of<AllCursosProvider>(context,
                                          listen: false)
                                      .getCursosById(widget.cursoID);
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
              Center(
                  child: Text(appLocal.finDeLosComentarios,
                      style: DashboardLabel.mini)),
              const SizedBox(height: 250)
            ],
          ),
        ),
        Positioned(
            bottom: 100,
            child: Container(
              color: bgColor,
              width: 250,
              height: 190,
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

                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        // decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(25)),
                        child: TextFormField(
                          cursorColor: azulText,
                          initialValue: comentario,
                          style: DashboardLabel.mini,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 3) {
                              return appLocal.comentarioInvalido;
                            }
                            return null;
                          },
                          decoration: InputDecor.formFieldInputDecorationSimple(
                              label: appLocal.agregarUnComentario,
                              icon: Icons.comment_outlined),
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
                        text: appLocal.comentar,
                        onPress: () => setState(() {
                          if (keyform.currentState!.validate()) {
                            Provider.of<AllCursosProvider>(context,
                                    listen: false)
                                .createComent(
                                    context: context,
                                    comentario: comentario,
                                    cursoId: curso.id,
                                    moduloId:
                                        curso.modulos[widget.videoIndex].id);
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
                    child: Text(appLocal.unAdmRespondera,
                        style: DashboardLabel.mini
                            .copyWith(color: blancoText.withOpacity(0.5))),
                  ),
                  const SizedBox(height: 10)
                ],
              ),
            )),
      ],
    );
  }
}

class DialogResp extends StatefulWidget {
  final String comentId;
  const DialogResp(
      {super.key, required this.comentId, required String moduloId});

  @override
  State<DialogResp> createState() => _DialogRespState();
}

class _DialogRespState extends State<DialogResp> {
  String textValue = '';
  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    return Center(
      child: Column(
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 380, minWidth: 380),
            child: TextFormField(
              cursorColor: azulText,
              maxLines: 5,
              style: DashboardLabel.mini
                  .copyWith(color: Colors.white.withOpacity(0.3)),
              initialValue: textValue,
              onChanged: (value) => {textValue = value}, //descripcion = value,
              decoration: InputDecor.formFieldInputDecoration(
                label: appLocal.respuesta,
                icon: Icons.question_answer,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                text: appLocal.responder,
                onPress: () {
                  Provider.of<AllCursosProvider>(context, listen: false)
                      .createResp(id: widget.comentId, respuesta: textValue);
                  Navigator.pop(context, true);
                },
                width: 100,
                color: Colors.green,
              ),
              const SizedBox(width: 10),
              CustomButton(
                text: appLocal.cancelarBtn,
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

class CongratDialog extends StatelessWidget {
  final String cursoNombre;
  const CongratDialog({super.key, required this.cursoNombre});

  @override
  Widget build(BuildContext context) {
    final wSize = MediaQuery.of(context).size.width;
    final hSize = MediaQuery.of(context).size.height;
    return AlertDialog(
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      content: Stack(
        children: [
          if (wSize > 500)
            Positioned(
                top: 30,
                right: 0,
                child: FadeInDown(
                    child: Container(
                  width: 120,
                  height: 50,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.amber)),
                ))),
          if (wSize < 500)
            Positioned(
                top: 30,
                right: 0,
                child: FadeInDown(
                    child: Container(
                  width: 45,
                  height: 50,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.amber)),
                ))),
          SizedBox(
            width: wSize,
            height: hSize,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: 300,
                height: 400,
                color: bgColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      FontAwesomeIcons.trophy,
                      size: 40,
                      color: Colors.amber,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Felicidades por terminar tu curso de.',
                      textAlign: TextAlign.center,
                      style: DashboardLabel.h4,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      cursoNombre,
                      style: DashboardLabel.h2,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Puedes ver tu certificado en el boton de arriba',
                      textAlign: TextAlign.center,
                      style: DashboardLabel.mini,
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                        text: 'OK',
                        onPress: () {
                          Navigator.pop(context, true);
                        },
                        width: 100)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
