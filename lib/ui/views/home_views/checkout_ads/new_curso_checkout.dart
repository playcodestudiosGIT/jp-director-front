import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constant.dart';
import '../../../../providers/auth_provider.dart';
// import '../../../constant.dart';
// import '../../../models/baner.dart';
// import '../../../providers/auth_provider.dart';
// import '../../../providers/baners_provier.dart';
// import '../../shared/widgets/cursos_botones.dart';

class NewCursoCheckout extends StatefulWidget {
  const NewCursoCheckout({super.key});

  @override
  State<NewCursoCheckout> createState() => _NewCursoCheckoutState();
}

class _NewCursoCheckoutState extends State<NewCursoCheckout> {
  @override
  Widget build(BuildContext context) {
    final wScreen = MediaQuery.of(context).size.width;
    final authProvider = Provider.of<AuthProvider>(context);
    return Padding(
      padding:
          (wScreen < 715 && authProvider.authStatus == AuthStatus.authenticated) ? const EdgeInsets.only(left: 40) : const EdgeInsets.only(left: 0),
      child: Stack(
        children: [
          Container(
            color: bgColor,
          ),
          Positioned(
              top: 80,
              left: -450,
              child: SizedBox(
                height: 900,
                child: SlideInUp(
                  from: 60,
                  duration: const Duration(seconds: 10),
                  child: SlideInLeft(
                    from: 100,
                    duration: const Duration(seconds: 10),
                    child: const Image(
                      image: circulo,
                    ),
                  ),
                ),
              )),
          Positioned(
              top: 90,
              right: 30,
              child: Transform.rotate(
                angle: 16,
                child: Opacity(
                  opacity: 0.1,
                  child: SlideInUp(
                    from: 100,
                    duration: const Duration(seconds: 10),
                    child: const Image(
                      image: rocketGif,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
