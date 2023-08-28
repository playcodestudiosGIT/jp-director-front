import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jp_director/providers/all_cursos_provider.dart';
import 'package:jp_director/providers/forms/register_form_provider.dart';
import 'package:jp_director/ui/cards/curso_card.dart';
import 'package:jp_director/ui/shared/politicas_footer.dart';
import 'package:jp_director/ui/shared/widgets/forms/login_form.dart';
import 'package:jp_director/ui/shared/widgets/forms/register_form.dart';
import 'package:jp_director/ui/shared/widgets/progress_ind.dart';
import 'package:provider/provider.dart';

import '../../../../constant.dart';

import '../../../../generated/l10n.dart';
import '../../../../router/router.dart';
import '../../../../services/navigator_service.dart';
import '../../../shared/labels/dashboard_label.dart';

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
          return const ProgressInd();
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
                        if (wScreen < 740)
                          const SizedBox(
                            height: 100,
                          ),
                        if (wScreen >= 740)
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
                                      // height: 510,
                                      width: 340,
                                      child: Column(
                                        children: [
                                          Form(
                                              key: checkoutKey,
                                              child:
                                                  ChangeNotifierProvider(create: (context) => RegisterFormProvider(), child: const RegisterForm())),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                appLocal.yaTienesCuenta,
                                                style: DashboardLabel.h4,
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
                                                  style: DashboardLabel.h4.copyWith(color: azulText, fontWeight: FontWeight.w800),
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
                                        const PoliticasFooter(),
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
}
