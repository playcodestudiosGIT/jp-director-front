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
          // Container(
          //   alignment: Alignment.center,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 30),
          //         child: Text(
          //           'APRENDE TODO SOBRE ADS',
          //           style: GoogleFonts.roboto(fontSize: (wScreen > 580) ? 40 : 22, fontWeight: FontWeight.w900, color: blancoText),
          //         ),
          //       ),
          //       Container(
          //         width: (wScreen > 580) ? 548 : 400,
          //         height: 5,
          //         decoration: const BoxDecoration(
          //             gradient: LinearGradient(colors: [
          //           bgColor,
          //           azulText,
          //           bgColor,
          //         ])),
          //       ),
          //       const SizedBox(
          //         height: 30,
          //       ),
          //       Text(
          //         'Cursos',
          //         style: GoogleFonts.roboto(fontSize: 32, fontWeight: FontWeight.w900, color: blancoText),
          //       ),
          //       Container(
          //         constraints: const BoxConstraints(maxHeight: 300, maxWidth: 800),
          //         child: Wrap(
          //           spacing: 15,
          //           runSpacing: 0,
          //           direction: Axis.horizontal,
          //           alignment: WrapAlignment.center,
          //           children: [
          //             if (baners.isEmpty) const Center(child: SizedBox(width: 40, height: 40, child: CircularProgressIndicator())),
          //             if (baners.isNotEmpty)
          //               // const SizedBox(
          //               //   height: 15,
          //               // ),
          //               ...baners.map(
          //                 (e) => CursoImagen(
          //                   img: e.img,
          //                   priceId: e.priceId,
          //                   cursoId: e.cursoId,
          //                 ),
          //               )
          //           ],
          //         ),
          //       ),
          //       const SizedBox(
          //         height: 60,
          //       ),
          //       SizedBox(
          //         width: 796,
          //         child: Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 20),
          //           child: Text(
          //             'Consigue clientes que quieran comprar tu producto o servicio utilizando la herramienta por la que llegaste aqui: Instagram - Facebook - Tik Tok',
          //             textAlign: TextAlign.center,
          //             style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w400, color: blancoText),
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
