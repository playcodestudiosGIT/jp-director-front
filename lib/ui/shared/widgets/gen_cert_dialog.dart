import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../models/certificado.dart';
import '../../../providers/export_all_providers.dart';
import '../labels/dashboard_label.dart';
import 'progress_ind.dart';

class GenCertDialog extends StatelessWidget {
  const GenCertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final curso = Provider.of<AllCursosProvider>(context, listen: false).cursoView;
    final appLocal = AppLocalizations.of(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return AlertDialog(
        backgroundColor: Colors.transparent,
        content: FutureBuilder(
          future: Provider.of<AllCursosProvider>(context, listen: false).generarCert(userId: authProvider.user!.uid, cursoId: curso.id),
          builder: (context, snapshot) {
            final Certificado newCert = Provider.of<AllCursosProvider>(context, listen: false).newCert;

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ProgressInd(),
                  const SizedBox(height: 10),
                  Text(
                    appLocal.generandoCert,
                    style: DashboardLabel.h4,
                  ),
                  Text(
                    'please wait...',
                    style: DashboardLabel.mini,
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
                                        size: 18,
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
                              appLocal.felicidadesCert,
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
                                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(azulText.withOpacity(0.1))),
                                onPressed: () {
                                  final Uri url = Uri.parse(newCert.urlPdf);
                                  launchUrl(url);
                                },
                                icon: const Icon(
                                  Icons.remove_red_eye,
                                  color: azulText,
                                  size: 18,
                                ),
                                label: Text(
                                  appLocal.ver,
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
  }
}
