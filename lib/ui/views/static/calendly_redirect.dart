import 'package:flutter/material.dart';

import 'package:jp_director/services/navigator_service.dart';
import 'package:jp_director/ui/shared/botones/botonverde.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../providers/form_provider.dart';
import '../../../router/router.dart';
import '../../shared/labels/dashboard_label.dart';

class CalendlyRedirect extends StatefulWidget {
  final String title;
  final String email;
  final String fullname;
  final DateTime date;
  final String phone;
  const CalendlyRedirect({super.key, required this.title, required this.email, required this.fullname, required this.date, required this.phone});

  @override
  State<CalendlyRedirect> createState() => _CalendlyRedirectState();
}

class _CalendlyRedirectState extends State<CalendlyRedirect> {
  @override
  Widget build(BuildContext context) {
    return Center(child: CalendlyThx(title: widget.title, date: widget.date, email: widget.email, fullname: widget.fullname, phone: widget.phone,));
  }
}

class CalendlyThx extends StatelessWidget {
  final String? title;
  final String? email;
  final String? fullname;
  final String? phone;
  final DateTime? date;
  const CalendlyThx({super.key, this.title, this.email, this.fullname, this.phone, this.date});

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final wScreen = MediaQuery.of(context).size.width;
    final formProvider = Provider.of<FormProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title ?? '',
              style:
                  (wScreen < 500) ? DashboardLabel.semiGigant : DashboardLabel.h1,
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
              style:
                  (wScreen < 500) ? DashboardLabel.paragraph : DashboardLabel.h3,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              appLocal.estasAunPaso,
              style:
                  (wScreen < 500) ? DashboardLabel.paragraph : DashboardLabel.h3,
            ),
            const SizedBox(
              height: 30,
            ),
            // if(date != DateTime.parse('1900-10-19'))
            Text(
              'Se ha confirmado la agenda de una ASESORIA 1 a 1, toda la información fué enviada a tu correo electrónico',
              style: (wScreen < 500)
                  ? DashboardLabel.mini
                  : DashboardLabel.paragraph,
            ),
            // SizedBox(height: 30),
            // if(date != DateTime.parse('1900-10-19'))
            // Text(
            //   fullname ?? '',
            //   style: (wScreen < 500)
            //       ? DashboardLabel.mini
            //       : DashboardLabel.paragraph,
            // ),
            // SizedBox(height: 10),
            // if(date != DateTime.parse('1900-10-19'))
            // Text(
            //   email ?? '',
            //   style: (wScreen < 500)
            //       ? DashboardLabel.mini
            //       : DashboardLabel.paragraph,
            // ),
            
            // SizedBox(height: 10),
            // if(date != DateTime.parse('1900-10-19'))
            // Text(
            //   '${DateFormat.yMMMMd().format(date ?? DateTime.now())}',
            //   style: (wScreen < 500)
            //       ? DashboardLabel.mini
            //       : DashboardLabel.paragraph,
            // ),
            const SizedBox(
              height: 30,
            ),
            Text(
              appLocal.siguemeEnTodas,
              textAlign: TextAlign.center,
              style:
                  (wScreen < 500) ? DashboardLabel.paragraph : DashboardLabel.h3,
            ),
            const SizedBox(
              height: 30,
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: (wScreen < 550)
                  ? WrapAlignment.center
                  : WrapAlignment.spaceBetween,
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
            const Image(image: baseGif),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BotonVerde(
                    text: 'Finalizar',
                    onPressed: () {
                      formProvider.setResetForm();
          
                      NavigatorService.navigateTo(Flurorouter.homeRoute);
                    },
                    width: 80)
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ButtomRrss extends StatelessWidget {
  final String text;
  final String route;
  final NetworkImage icon;

  const ButtomRrss(
      {Key? key, required this.text, required this.route, required this.icon})
      : super(key: key);
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
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                  color: verdeBorde, width: 4, style: BorderStyle.solid)),
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
                style: DashboardLabel.paragraph,
              )
            ],
          ),
        ),
      ),
    );
  }
}
