import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constant.dart';
import '../../../providers/form_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';

class AgendaThxView extends StatefulWidget {
  final String? date;
  final String? email;
  final String? payload;

  const AgendaThxView({Key? key, this.date, this.email, this.payload}) : super(key: key);
  @override
  State<AgendaThxView> createState() => _AgendaThxViewState();
}

class _AgendaThxViewState extends State<AgendaThxView> {
  @override
  Widget build(BuildContext context) {
    return Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: LetrasAsesoria(email: widget.email ?? 'noemail@noemail.com'),
              ),
            ],
          ),
        );
  }
}

class LetrasAsesoria extends StatelessWidget {
  final String email;

  const LetrasAsesoria({Key? key, required this.email}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final wScreen = MediaQuery.of(context).size.width;
    final formProvider = Provider.of<FormProvider>(context);
    late String title;
    if (formProvider.rootForm == 'mentoria') {
      title = 'MENTORÍA INTENSIVA';
    }
    if (formProvider.rootForm == 'encargado') {
      title = 'SER EL ENCARGADO';
    }
    if (formProvider.rootForm == 'conferencias') {
      title = 'CONFERENCIAS';
    } else {
      title = 'ASESORIA 1:1';
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
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
          Text(
            '¡Gracias por brindarnos tu información!',
            textAlign: TextAlign.start,
            style: GoogleFonts.roboto(fontSize: (wScreen < 500) ? 20 : 24, fontWeight: FontWeight.w700, color: blancoText),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            '¡Estás a un paso del éxito para marcar la diferencia, bienvenido a esta misión!',
            style: GoogleFonts.roboto(fontSize: (wScreen < 500) ? 18 : 20, fontWeight: FontWeight.w400, color: blancoText),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Hemos agendado tu cita, revisa tu correo electrónico ($email) para mas detalles.',
            style: GoogleFonts.roboto(fontSize: (wScreen < 500) ? 15 : 18, fontWeight: FontWeight.w400, color: blancoText),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Sígueme en todas las redes para conocer TIPS y actualizaciones ADS',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(fontSize: (wScreen < 500) ? 20 : 24, fontWeight: FontWeight.w700, color: azulText),
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
          Image.asset(
            'images/base.gif',
            colorBlendMode: BlendMode.modulate,
            color: blancoText.withOpacity(0.4),
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
                  child: Text('FINALIZAR', style: GoogleFonts.roboto(color: blancoText, fontSize: 16))),
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
    Future<void> launchUrlInstagram() async {
      final Uri url = Uri.parse('https://www.instagram.com/jpdirector/');
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }

    Future<void> launchUrlFacebook() async {
      final Uri url = Uri.parse('https://www.facebook.com/jpdirector/');
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }

    Future<void> launchUrlTikTok() async {
      final Uri url = Uri.parse('https://www.tiktok.com/@jpdirectorr');
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }

    return GestureDetector(
      onTap: () {
        if (route == 'Instagram') {
          launchUrlInstagram();
        }
        if (route == 'Facebook') {
          launchUrlFacebook();
        }
        if (route == 'Tiktok') {
          launchUrlTikTok();
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
