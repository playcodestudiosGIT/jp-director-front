import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../providers/form_provider.dart';


class FormThxView extends StatefulWidget {
  const FormThxView({super.key});

  @override
  State<FormThxView> createState() => _FormThxViewState();
}

class _FormThxViewState extends State<FormThxView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600, maxHeight: 600),
            child: const LetrasAsesoria(),
          ),
        ],
      ),
    );
  }
}

class LetrasAsesoria extends StatelessWidget {
  const LetrasAsesoria({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final wScreen = MediaQuery.of(context).size.width;
    final formProvider = Provider.of<FormProvider>(context);
    late String title;
    if (formProvider.rootForm == 'mentoria') {
      title = appLocal.mentoriaIntensiva;
    }
    if (formProvider.rootForm == 'encargado') {
      title = appLocal.serElEncargado;
    }
    if (formProvider.rootForm == 'conferencias') {
      title = appLocal.conferencias;
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
            appLocal.graciasInfo,
            textAlign: TextAlign.start,
            style: GoogleFonts.roboto(fontSize: (wScreen < 500) ? 16 : 20, fontWeight: FontWeight.w700, color: blancoText),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            appLocal.estasAunPaso,
            style: GoogleFonts.roboto(fontSize: (wScreen < 500) ? 16 : 20, fontWeight: FontWeight.w700, color: blancoText),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            appLocal.enElTranscurso,
            style: GoogleFonts.roboto(fontSize: (wScreen < 500) ? 12 : 16, fontWeight: FontWeight.w400, color: blancoText),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            appLocal.siguemeEnTodas,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(fontSize: (wScreen < 500) ? 16 : 20, fontWeight: FontWeight.w700, color: azulText),
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
                icon: iconFb,
              ),
            ],
          ),
          const Image(image: baseGif),
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
