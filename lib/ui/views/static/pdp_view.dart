import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:jp_director/providers/auth_provider.dart';
import 'package:jp_director/router/router.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../services/navigator_service.dart';
import '../../shared/labels/dashboard_label.dart';


class PdpView extends StatelessWidget {
  const PdpView({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final wScreen = MediaQuery.of(context).size.width;
    final authProvider = Provider.of<AuthProvider>(context);
    return Container(
        margin: EdgeInsets.only(
          left: wScreen < 670 && authProvider.authStatus == AuthStatus.authenticated ? 30 : 0,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.transparent,
          image:
              DecorationImage(image: bgContacto, opacity: 0.2, alignment: (wScreen < 700) ? const Alignment(0.3, 0) : Alignment.center, fit: BoxFit.cover),
          backgroundBlendMode: BlendMode.darken,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: 612,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: bgColor.withOpacity(0.7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: blancoText,
                                ),
                                onPressed: () {
                                  NavigatorService.navigateTo('/contacto');
                                },
                              )
                            ],
                          ),
                          const SizedBox(height: 90),
                          Text(
                            appLocal.politicaDePrivacidad,
                            style: DashboardLabel.azulTextH2
                          ),
                          Text(
                            appLocal.actualizacionTyC,
                            style: DashboardLabel.mini.copyWith(fontSize: 10, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            appLocal.estaPolitica,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              appLocal.laDenominacionSocial,
                              style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                            ),
                          ),
                          Text(
                            appLocal.datosSolicitados,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              appLocal.nombApllYCorr,
                              style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                            ),
                          ),
                          Text(
                            appLocal.jpEnTodoMomento,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          Text(
                            appLocal.jpCompartira,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          Text(
                            appLocal.losEnlacesATerceros,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${appLocal.formularios}\n',
                            style: DashboardLabel.h4,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.elSitioWebDispone,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'DERECHOS\n',
                            style: DashboardLabel.h4,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.elUsuarioTiene,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'ENCARGADOS DEL TRATAMIENTO\n',
                            style: DashboardLabel.h4,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.jpNecesitaElApoyo,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'POLÍTICAS RELACIONADAS CON LA NEWSLETTER\n',
                            style: DashboardLabel.h4,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.estasPoliticasSeEntenderan,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'INTERÉS LEGÍTIMO\n',
                            style: DashboardLabel.h4,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.cuandoSeRealice,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.duracionDeTratamiento,
                            style: DashboardLabel.h4,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.enElCasoDeLosDatos,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.residentesCalifornia,
                            style: DashboardLabel.h4,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.jpCumpleLaLey,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(8),
                      width: double.infinity,
                      color: bgColor.withOpacity(0.8),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: wScreen < 500 ? 0 : 8,
                            ),
                            child: Text(
                              'JP DIRECTOR | QUIERO ADS',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: blancoText,
                                fontWeight: FontWeight.w700,
                                fontSize: wScreen < 500 ? 10 : 10,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: wScreen < 500 ? 0 : 8),
                            child: Text(
                              appLocal.todosLosDerechosRes,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: blancoText,
                                fontWeight: FontWeight.w700,
                                fontSize: wScreen < 500 ? 10 : 10,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: wScreen < 500 ? 8 : 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () => NavigatorService.navigateTo(Flurorouter.pdpRoute),
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Text(
                                      appLocal.politicasDeProivacidad,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: azulText,
                                        fontWeight: FontWeight.w700,
                                        fontSize: wScreen < 500 ? 10 : 10,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  ' -  ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: blancoText,
                                    fontWeight: FontWeight.w700,
                                    fontSize: wScreen < 500 ? 10 : 10,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => NavigatorService.navigateTo(Flurorouter.tycRoute),
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Text(
                                      appLocal.terminosYCondiciones,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: azulText,
                                        fontWeight: FontWeight.w700,
                                        fontSize: wScreen < 500 ? 10 : 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: wScreen < 500 ? 8 : 8),
                            child: Text(
                              'This site is not part of Meta website or Meta Inc.\nThis site is not part of the Tik Tok website or Tik Tok inc.\nThis site is NOT endorsed by Meta or Tik Tok in any way.\nMeta is a trademark of Meta and Tik Tok is a trademark of Tik Tok Inc',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: blancoText.withOpacity(0.6),
                                fontWeight: FontWeight.w300,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
