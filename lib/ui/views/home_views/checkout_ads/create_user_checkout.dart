import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/providers/all_cursos_provider.dart';
import 'package:jpdirector_frontend/providers/forms/register_form_provider.dart';
import 'package:jpdirector_frontend/ui/cards/curso_card.dart';
import 'package:jpdirector_frontend/ui/shared/widgets/forms/login_form.dart';
import 'package:jpdirector_frontend/ui/shared/widgets/forms/register_form.dart';
import 'package:provider/provider.dart';

import '../../../../constant.dart';

import '../../../../generated/l10n.dart';
import '../../../../router/router.dart';
import '../../../../services/navigator_service.dart';

class CreateUserCheckout extends StatefulWidget {
  final String cursoId;
  final String? state;
  const CreateUserCheckout({super.key, required this.cursoId, this.state});

  @override
  State<CreateUserCheckout> createState() => _CreateUserCheckoutState();
}

class _CreateUserCheckoutState extends State<CreateUserCheckout> {
  GlobalKey<FormState> checkoutKey = GlobalKey<FormState>(debugLabel: 'newcursowhituser');

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    double hScreen = MediaQuery.of(context).size.height;
    double wScreen = MediaQuery.of(context).size.width;

    return FutureBuilder(
      
      future: Future.delayed(const Duration(milliseconds: 100)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SizedBox(
              width: 35,
              height: 35,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: Colors.transparent,
            body: ListView(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(wScreen < 740)
                    const SizedBox(
                      height: 100,
                    ),
                    if(wScreen >= 740)
                    const SizedBox(
                      height: 200,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          constraints: BoxConstraints(maxWidth: 1200, minHeight: hScreen - 200),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            runSpacing: 20,
                            children: [
                              if (widget.state == 'register')
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(color: const Color(0xff021E36), borderRadius: BorderRadius.circular(80)),
                                  // height: 510,
                                  width: 340,
                                  child: Column(
                                    children: [
                                      Form(
                                          key: checkoutKey,
                                          child: ChangeNotifierProvider(create: (context) => RegisterFormProvider(), child: const RegisterForm())),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            appLocal.yaTienesCuenta,
                                            style: GoogleFonts.roboto(fontSize: 14, color: blancoText, fontWeight: FontWeight.w400),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              NavigatorService.navigateTo('${Flurorouter.payNewUserRouteAlt}/${widget.cursoId}/login');
                                            }, // Navigate to register page
                                            child: Text(
                                              appLocal.iniciaAqui,
                                              style: GoogleFonts.roboto(fontSize: 14, color: azulText, fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      )
                                    ],
                                  ),
                                ),
                              if (widget.state == 'login')
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  // height: 510,
                                  width: 340,
                                  child: LoginForm(
                                    cursoId: widget.cursoId,
                                    isBuying: true,
                                  ),
                                ),
                              const SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                width: 400,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 30),
                                    FutureBuilder(
                                      future: Provider.of<AllCursosProvider>(context, listen: false).getCursosById(widget.cursoId),
                                      builder: (context, snapshot) {
                                        final curso = Provider.of<AllCursosProvider>(context).cursoView;

                                        return CourseCard(esMio: false, curso: curso);
                                      },
                                    ),
                                    const SizedBox(height: 30),
                                    Center(
                                      child: Container(
                                          padding: const EdgeInsets.all(10),
                                          constraints: const BoxConstraints(maxWidth: 580),
                                          child: Wrap(
                                            alignment: WrapAlignment.center,
                                            children: [
                                              Text(
                                                appLocal.alHacerClickHeLeido,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(color: blancoText, fontSize: 16, fontWeight: FontWeight.w400),
                                              ),
                                              InkWell(
                                                onTap: () => NavigatorService.navigateTo(Flurorouter.tycRoute),
                                                child: Text(
                                                  appLocal.terminoDeUso,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(color: azulText, fontSize: 16, fontWeight: FontWeight.w400),
                                                ),
                                              ),
                                              Text(
                                                appLocal.yReconocesQue,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(color: blancoText, fontSize: 16, fontWeight: FontWeight.w400),
                                              ),
                                              Text(
                                                appLocal.nuestra,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(color: blancoText, fontSize: 16, fontWeight: FontWeight.w400),
                                              ),
                                              InkWell(
                                                onTap: () => NavigatorService.navigateTo(Flurorouter.pdpRoute),
                                                child: Text(
                                                  appLocal.politicaDePrivacidad,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(color: azulText, fontSize: 16, fontWeight: FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                    const SizedBox(height: 100)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
      },
    );
  }

  InputDecoration buildInputDecoration({
    required String label,
    required IconData icon,
  }) =>
      InputDecoration(
        fillColor: blancoText.withOpacity(0.03),
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: azulText),
        ),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: azulText.withOpacity(0.3))),
        labelText: label,
        labelStyle: GoogleFonts.roboto(color: blancoText, fontSize: 14),
        prefixIcon: Icon(icon, color: azulText.withOpacity(0.3)),
      );
}
