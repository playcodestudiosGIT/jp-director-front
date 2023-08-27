import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../providers/forms/register_form_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
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
    return ChangeNotifierProvider(
      create: (_) => RegisterFormProvider(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Stack(
                  children: [
                    // const Positioned(top: 0, left: -500, child: SizedBox(width: 1100, child: Image(image: circulo))),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              if (wScreen > 980) const Image(image: logoGrande),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 60,
                                  ),
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
                                        style: GoogleFonts.roboto(fontSize: 14, color: blancoText, fontWeight: FontWeight.w400),
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
                          const PoliticasFooter()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
