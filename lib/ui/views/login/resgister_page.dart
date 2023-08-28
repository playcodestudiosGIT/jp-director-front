import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../providers/forms/register_form_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import '../../shared/labels/dashboard_label.dart';
import '../../shared/politicas_footer.dart';
import '../../shared/widgets/forms/register_form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final wScreen = MediaQuery.of(context).size.width;
    double hScreen = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (_) => RegisterFormProvider(),
      child: Scaffold(
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
                  const SizedBox(
                      height: 80,
                    ),
                  Container(
                    alignment: (wScreen < 450) ? Alignment.topCenter:Alignment.center,
                          constraints: BoxConstraints(maxWidth: 1200, minHeight: hScreen),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (wScreen > 980) const Image(image: logoGrande),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          
                            if (wScreen <= 980) const SizedBox(width: 200, child: Image(image: logoGrande)),
                            const FittedBox(
                              fit: BoxFit.contain,
                              child: SizedBox(width: 315, child: RegisterForm()),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Text(
                                  appLocal.yaTienesCuenta,
                                  style: DashboardLabel.h4,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                TextButton(
                                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(blancoText.withOpacity(0.1))),
                                  onPressed: () {
                                    NavigatorService.replaceTo(Flurorouter.loginRoute);
                                  }, // Navigate to register page
                                  child: Text(
                                    appLocal.iniciaAqui,
                                    style: GoogleFonts.roboto(fontSize: 14, color: azulText, fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const PoliticasFooter()
                ],
              ),
            ],
          ),]
        ),
      ),
    );
  }
}
