import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../providers/auth_provider.dart';
import '../service_slider_views/asesoria_view.dart';
import '../service_slider_views/conference_view.dart';
import '../service_slider_views/encargado_view.dart';
import '../service_slider_views/mentoria_view.dart';

class ServicesView extends StatefulWidget {
  const ServicesView({super.key});

  @override
  State<ServicesView> createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  late CarouselController sliderController;
  int index = 0;
  @override
  void initState() {
    super.initState();
    sliderController = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    final wScreen = MediaQuery.of(context).size.width;
    final authProvider = Provider.of<AuthProvider>(context);
    final List<Widget> sliders = [
      const AsesoriaView(),
      const MentoriaView(),
      const EncargadoView(),
      const ConferenceView(),
    ];

    final size = MediaQuery.of(context).size;

    return Padding(
      padding:
          (wScreen < 715 && authProvider.authStatus == AuthStatus.authenticated) ? const EdgeInsets.only(left: 40) : const EdgeInsets.only(left: 0),
      child: Stack(
        alignment: (wScreen < 550) ? Alignment.topCenter : Alignment.center,
        children: [
          
          Positioned(
              top: 550,
              right: 330,
              child: Transform.rotate(
                angle: 10,
                child: Opacity(
                  opacity: 0.1,
                  child: SlideInUp(
                    from: 450,
                    duration: const Duration(seconds: 20),
                    child: const Image(
                      width: 150,
                      image: rocketGif,
                    ),
                  ),
                ),
              )),
          
          SingleChildScrollView(
            child: SizedBox(
                height: size.height,
                child: Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const SizedBox(
                    height: 90,
                  ),
                  Text(
                    'SERVICIOS',
                    style: GoogleFonts.roboto(fontSize: 40, fontWeight: FontWeight.w900, color: blancoText),
                  ),
                  Container(
                    width: 220,
                    height: 5,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                      bgColor,
                      azulText,
                      bgColor,
                    ])),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          // width: 1000,
                          height: 44,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      children: [
                                        TextButton(
                                            onPressed: () => setState(() {
                                                  index = 0;
                                                  sliderController.animateToPage(index);
                                                }),
                                            child: Text(
                                              'ASESORÍA 1:1',
                                              style: GoogleFonts.roboto(color: blancoText, fontSize: 15, fontWeight: FontWeight.w500),
                                            )),
                                        if (index == 0) ...[
                                          const SizedBox(height: 4),
                                          Container(
                                            height: 4,
                                            width: 100,
                                            decoration: const BoxDecoration(
                                                gradient: LinearGradient(colors: [
                                              bgColor,
                                              azulText,
                                              bgColor,
                                            ])),
                                          )
                                        ]
                                      ],
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: TextButton(
                                      onPressed: () => setState(() {
                                            index = 1;
                                            sliderController.animateToPage(index);
                                          }),
                                      child: Column(
                                        children: [
                                          Text('MENTORÍA', style: GoogleFonts.roboto(color: blancoText, fontSize: 15, fontWeight: FontWeight.w500)),
                                          if (index == 1) ...[
                                            const SizedBox(height: 4),
                                            Container(
                                              height: 4,
                                              width: 100,
                                              decoration: const BoxDecoration(
                                                  gradient: LinearGradient(colors: [
                                                bgColor,
                                                azulText,
                                                bgColor,
                                              ])),
                                            )
                                          ]
                                        ],
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: TextButton(
                                      onPressed: () => setState(() {
                                            index = 2;
                                            sliderController.animateToPage(index);
                                          }),
                                      child: Column(
                                        children: [
                                          Text('SER EL ENCARGADO',
                                              style: GoogleFonts.roboto(color: blancoText, fontSize: 15, fontWeight: FontWeight.w500)),
                                          if (index == 2) ...[
                                            const SizedBox(height: 4),
                                            Container(
                                              height: 4,
                                              width: 100,
                                              decoration: const BoxDecoration(
                                                  gradient: LinearGradient(colors: [
                                                bgColor,
                                                azulText,
                                                bgColor,
                                              ])),
                                            )
                                          ]
                                        ],
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: TextButton(
                                      onPressed: () => setState(() {
                                            index = 3;
                                            sliderController.animateToPage(index);
                                          }),
                                      child: Column(
                                        children: [
                                          Text('CONFERENCIAS',
                                              style: GoogleFonts.roboto(color: blancoText, fontSize: 15, fontWeight: FontWeight.w500)),
                                          if (index == 3) ...[
                                            const SizedBox(height: 4),
                                            Container(
                                              height: 4,
                                              width: 100,
                                              decoration: const BoxDecoration(
                                                  gradient: LinearGradient(colors: [
                                                bgColor,
                                                azulText,
                                                bgColor,
                                              ])),
                                            )
                                          ]
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ))),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (wScreen > 500)
                        SizedBox(
                          width: 50,
                          child: IconButton(
                            onPressed: () => setState(() {
                              sliderController.previousPage();
                              if (index == 0) {
                                index = 3;
                              } else {
                                index = index - 1;
                              }
                            }),
                            icon: const Icon(Icons.arrow_back),
                            color: azulText,
                          ),
                        ),
                      Expanded(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1000, maxHeight: 450, minWidth: 350),
                          child: CarouselSlider(
                              carouselController: sliderController,
                              items: [...sliders],
                              options: CarouselOptions(
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    index = index;
                                  });
                                },
                                height: 500,
                                viewportFraction: 1,
                                // initialPage: pageProvider.getStateIndex(),
                                enableInfiniteScroll: true,
                              )),
                        ),
                      ),
                      if (wScreen > 500)
                        SizedBox(
                          width: 50,
                          child: IconButton(
                            onPressed: () => setState(() {
                              sliderController.nextPage();
                              if (index == 3) {
                                index = 0;
                              } else {
                                index = index + 1;
                              }
                            }),
                            icon: const Icon(Icons.arrow_forward),
                            color: blancoText,
                          ),
                        ),
                    ],
                  ),
                ]))),
          )
        ],
      ),
    );
  }
}
