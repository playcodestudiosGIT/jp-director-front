import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/providers/auth_provider.dart';
import 'package:jpdirector_frontend/providers/pay_provider.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constant.dart';
import '../../../models/curso.dart';
import '../../../providers/all_cursos_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import '../../shared/labels/dashboard_label.dart';

class CheckoutThxView extends StatefulWidget {
  final String cursoId;

  const CheckoutThxView({Key? key, this.cursoId = ''}) : super(key: key);
  @override
  State<CheckoutThxView> createState() => _CheckoutThxViewState();
}

class _CheckoutThxViewState extends State<CheckoutThxView> {
  @override
  void initState() {
    super.initState();
    Provider.of<AllCursosProvider>(context, listen: false).getCursosById(widget.cursoId);
    Provider.of<AllCursosProvider>(context, listen: false).cursoSelected = widget.cursoId;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final payProvider = Provider.of<PayProvider>(context, listen: false);
    final curso = Provider.of<AllCursosProvider>(context).cursoView;
    return FutureBuilder(
      future: payProvider.checkPayAndAddCurso(cursoId: widget.cursoId, userId: authProvider.user!.uid, sessionId: authProvider.user!.sessionId),
      builder: (context, snapshot) {
        print(' snapshoot ${snapshot.data}');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: SizedBox(width: 30, height: 30, child: CircularProgressIndicator()));
        }

        if (snapshot.data == true) {
          Provider.of<AllCursosProvider>(context, listen: false).addCursoToUser(context: context, userId: authProvider.user!.uid);
        }
        return Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: LetrasAsesoria(curso: curso),
              ),
            ],
          ),
        );
      },
    );
  }
}

class LetrasAsesoria extends StatelessWidget {
  final Curso curso;

  const LetrasAsesoria({Key? key, required this.curso}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final wScreen = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Nuevo curso: ${curso.nombre}',
            style: GoogleFonts.roboto(fontSize: (wScreen < 500) ? 30 : 40, fontWeight: FontWeight.w900, color: blancoText),
          ),
          Container(
            width: 400,
            height: 5,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              bgColor,
              azulText,
              bgColor,
            ])),
          ),
          const SizedBox(
            height: 70,
          ),
          Text('¡Estás a un paso del éxito para marcar la diferencia, bienvenido a esta misión!', style: DashboardLabel.h2),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Sígueme en todas las redes para conocer TIPS y actualizaciones ADS',
            textAlign: TextAlign.center,
            style: DashboardLabel.azulTextH1,
          ),
          const SizedBox(
            height: 30,
          ),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: (wScreen < 550) ? WrapAlignment.center : WrapAlignment.spaceBetween,
            children: const [
              ButtomRrss(
                route: 'Instagram',
                text: '@jpdirector',
                icon: iconInsta,
              ),
              ButtomRrss(
                route: 'Facebook',
                text: '@jpdirector',
                icon: iconFb,
              ),
              ButtomRrss(
                route: 'Tiktok',
                text: '@jpdirector',
                icon: iconTiktok,
              ),
            ],
          ),
          Container(
            child: Image.asset(
              'images/base.gif',
              colorBlendMode: BlendMode.modulate,
              color: blancoText.withOpacity(0.4),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    NavigatorService.replaceTo(Flurorouter.homeRoute);
                  },
                  child: Text('FINALIZAR', style: DashboardLabel.paragraph)),
            ],
          ),
        ],
      ),
    );
  }
}

class ButtomRrss extends StatelessWidget {
  final String text;
  final String route;
  final NetworkImage icon;

  const ButtomRrss({Key? key, required this.text, required this.route, required this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future<void> _launchUrlInstagram() async {
      final Uri url = Uri.parse('https://www.instagram.com/jpdirector/');
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }

    Future<void> _launchUrlFacebook() async {
      final Uri url = Uri.parse('https://www.facebook.com/jpdirector/');
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }

    Future<void> _launchUrlTikTok() async {
      final Uri url = Uri.parse('https://www.tiktok.com/@jpdirectorr');
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }

    return GestureDetector(
      onTap: () {
        if (route == 'Instagram') {
          _launchUrlInstagram();
        }
        if (route == 'Facebook') {
          _launchUrlFacebook();
        }
        if (route == 'Tiktok') {
          _launchUrlTikTok();
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.all(10),
          width: 170,
          height: 50,
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(14), border: Border.all(color: verdeBorde, width: 4, style: BorderStyle.solid)),
          child: Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              Image(image: icon),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: GoogleFonts.roboto(fontSize: 16, color: blancoText, fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ),
    );
  }
}
