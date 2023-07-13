import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../providers/auth_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import '../../shared/botones/custom_button.dart';
import '../../shared/widgets/asesoria_slider/agenda_cita.dart';
import '../login/login_page.dart';

class AsesoriaAgendarPage extends StatelessWidget {
  const AsesoriaAgendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return SafeArea(
      child: Stack(
        children: [
          Container(
            color: const Color(0xFF00041C),
          ),
          const Positioned(bottom: -200, left: -300, child: SizedBox(width: 1000, child: Image(image: circulo))),
          const Positioned(top: -200, right: -300, child: SizedBox(width: 800, child: Image(image: circulo))),
          SingleChildScrollView(
              child: Column(
            children: [
              const SizedBox(
                width: double.infinity,
                height: 120,
              ),
              Container(
                padding: (authProvider.authStatus == AuthStatus.authenticated)
                    ? const EdgeInsets.only(left: 40, top: 17)
                    : const EdgeInsets.only(left: 0, top: 0),
                alignment: Alignment.centerLeft,
                constraints: const BoxConstraints(maxWidth: 1200),
                child: IconButton(
                    onPressed: () {
                      NavigatorService.navigateTo('/servicios');
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: azulText,
                      size: 30,
                    )),
              ),
              const Agenda(),
            ],
          )),
          Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,
            height: 80,
            // color: Color(0xFF00041C),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, Flurorouter.homeRoute);
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: 345,
                  child: const Image(
                    image: logoJp,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              right: 100,
              top: 28,
              child: CustomButton(
                width: 80,
                text: 'LOGIN',
                onPress: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage())),
              )),
        ],
      ),
    );
  }
}
