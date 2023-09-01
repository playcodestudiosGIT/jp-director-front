import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jp_director/constant.dart';
import 'package:jp_director/generated/l10n.dart';
import 'package:jp_director/providers/auth_provider.dart';
import 'package:jp_director/router/router.dart';
import 'package:jp_director/services/navigator_service.dart';
import 'package:provider/provider.dart';

import '../../shared/labels/dashboard_label.dart';

class TycView extends StatelessWidget {
  const TycView({super.key});

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
          image: DecorationImage(
              image: bgContacto, opacity: 0.2, alignment: (wScreen < 700) ? const Alignment(0.3, 0) : Alignment.center, fit: BoxFit.cover),
          backgroundBlendMode: BlendMode.darken,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (wScreen < 450) const SizedBox(height: 80),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: 612,
                child: Column(
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
                            appLocal.avisoLegalYTerminos,
                            style: DashboardLabel.azulTextH2
                          ),
                          Text(
                            appLocal.actualizacionTyC,
                            style: DashboardLabel.mini.copyWith(fontSize: 10, fontWeight: FontWeight.w400, color: blancoText.withOpacity(0.6)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            appLocal.avisoLegal1,
                            style: DashboardLabel.h4,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.puedoGatantizarte,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              appLocal.miDenominacion,
                              style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.finalidadWeb1_2,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              appLocal.laVentanaDeFormacion,
                              style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.usuarios1_3,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.elAccesoyo,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.usoDelSitioWeb1_4,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.usoDelSitioWeb1_4_1,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.laPaginaWebText,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.capturaDeInf1_4_2,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              appLocal.capturaDeInf1_4_2Text,
                              style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                            ),
                          ),
                          Text(
                            appLocal.aPesarDeLoAnterior,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              appLocal.elTratamientoDeSusDatos,
                              style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                            ),
                          ),
                          Text(
                            appLocal.asiMismoInformamos,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.propiedadIntelectual,
                            style: DashboardLabel.h4,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.propiedadIntelectualText,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.exclusionDeGarant,
                            style: DashboardLabel.h4,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.exclusionDeGarantText,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.modificaciones,
                            style: DashboardLabel.h4,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.modificacionesText,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.politicaDeEnlaces,
                            style: DashboardLabel.h4,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.politicaDeEnlacesText,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              appLocal.noSePermiteRepr,
                              style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.derechoExcl,
                            style: DashboardLabel.h4,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.derechoExclText,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.generalidades,
                            style: DashboardLabel.h4,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.generalidadesText,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.modificacionCond,
                            style: DashboardLabel.h4,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.modificacionCondText,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.reclamacionesDudas,
                            style: DashboardLabel.h4,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.reclamacionesDudasText,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.condicionesDeVenta,
                            style: DashboardLabel.h4,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.condicionesDeVentaText,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.leyAplicable,
                            style: DashboardLabel.h4,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.leyAplicableText,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.causasDeDisolucion,
                            style: DashboardLabel.h4,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            appLocal.causasDeDisolucionText,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              appLocal.laFalsedadText,
                              style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                            ),
                          ),
                          Text(
                            appLocal.laDisolucion,
                            style: DashboardLabel.paragraph.copyWith(color: blancoText.withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const EndBody()
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class EndBody extends StatelessWidget {
  const EndBody({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final wScreen = MediaQuery.of(context).size.width;
    return Container(
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
              'This site is not part of Meta website or Meta Inc.\nThis site is not part of the Tik Tok website or Tik Tok inc.\nThis site is NOT endorsed by Meta or Tik Tok in any way.\n\nMeta is a trademark of Meta and Tik Tok is a trademark of Tik Tok Inc',
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
    );
  }
}
