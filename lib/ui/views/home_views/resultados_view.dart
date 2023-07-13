import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';


import '../../../constant.dart';
import '../../../providers/auth_provider.dart';

class ResultadosView extends StatelessWidget {
  final listPhotos = resultados;

  ResultadosView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PhotoView> listResultWiget = [
      ...listPhotos.map((image) => PhotoView(
            imageProvider: NetworkImage(image),
            backgroundDecoration: const BoxDecoration(color: bgColor),
            enablePanAlways: true,
          ))
    ];
    final wScreen = MediaQuery.of(context).size.width;
    final authProvider = Provider.of<AuthProvider>(context);
    return Padding(
      padding: (wScreen < 715 && authProvider.authStatus == AuthStatus.authenticated) ? const EdgeInsets.only(left: 40) : const EdgeInsets.only(left: 0),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              color: bgColor,
            ),
            SingleChildScrollView(
              child: Center(
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'MÍRALO CON TUS PROPIOS OJOS',
                          style: GoogleFonts.roboto(fontSize: (wScreen < 450) ? 18 : 24, fontWeight: FontWeight.w900, color: azulText),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: double.infinity, maxHeight: wScreen < 450 ? 350 : 600, minHeight: 300, minWidth: 350),
                        child: PageView(children: [
                          CarouselSlider(
                              
                              items: listResultWiget,
                              options: CarouselOptions(
                                height: wScreen < 450 ? 350 : 600,
                                viewportFraction: 1,
                                enlargeCenterPage: false,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                              )),
                        ]),
                      ),
                      Center(
                        child: Container(child: const Image(image: baseGif)),
                      )
                    ])),
              ),
            )
          ],
        ),
      ),
    );
  }
}
