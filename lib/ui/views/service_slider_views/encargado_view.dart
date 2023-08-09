import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/ui/shared/botones/botonverde.dart';


import '../../../constant.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import '../../shared/labels/dashboard_label.dart';

class EncargadoView extends StatelessWidget {
  const EncargadoView({super.key});

  @override
  Widget build(BuildContext context) {
    double wScreen = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8.0),
      child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          width: double.infinity,
          height: 500,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'SER EL ENCARGADO',
                          style: (wScreen < 550) ? DashboardLabel.h1 : DashboardLabel.gigant,
                        ),
                        Container(
                          width: 300,
                          height: 5,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(colors: [
                            bgColor,
                            azulText,
                            bgColor,
                          ])),
                        ),
                        const SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'SOY EL RESPONSABLE DE TU ÉXITO'.toUpperCase(),
                          textAlign: TextAlign.start,
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: blancoText,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '¿Estás en el momento de contratar a un especialista que aumente tu flujo de clientes, alcance y visitas al negocio?',
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: blancoText.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Cuenta conmigo',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: azulText,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                BotonVerde(text: 'Agendar una Llamada', onPressed: () => NavigatorService.navigateTo(Flurorouter.encargadoRoute), width: 200)
              ],
            ),
          )),
    );
  }
}


