import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../providers/export_all_providers.dart';
import '../../../providers/events_provider.dart';
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
    final appLocal = AppLocalizations.of(context);
    final wScreen = MediaQuery.of(context).size.width;
    final List<Widget> sliders = [
      const AsesoriaView(),
      const MentoriaView(),
      const EncargadoView(),
      const ConferenceView(),
    ];

    return Stack(
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
        SizedBox(
            // height: size.height + 40,
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
              const SizedBox(
                height: 80,
              ),
              Text(
                appLocal.servicios,
                style: DashboardLabel.t1,
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
                                        onPressed: () {
                                          Provider.of<EventsProvider>(context,
                                          listen: false)
                                      .clickEvent(
                                    
                                          source: 'home/servicios',
                                          description:
                                              'Click en Asesoria - Boton Index Slider',
                                          title: 'Servicios - Asesoria Slider Index');
                                          setState(() {
                                            index = 0;
                                            sliderController
                                                .animateToPage(index);
                                          });
                                        },
                                        child: Text(appLocal.asesoria11,
                                            style: DashboardLabel.h4)),
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
                                  onPressed: () {
                                    Provider.of<EventsProvider>(context,
                                            listen: false)
                                        .clickEvent(
                                            source: 'home/servicios',
                                            description:
                                                'Click en Mentoria - Boton Index Slider',
                                            title:
                                                'Servicios - Mentoria Slider Index');
                                    setState(() {
                                      index = 1;
                                      sliderController.animateToPage(index);
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Text(appLocal.mentoria,
                                          style: DashboardLabel.h4),
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
                                  onPressed: () {
                                    Provider.of<EventsProvider>(context,
                                            listen: false)
                                        .clickEvent(
                                            source: 'home/servicios',
                                            description:
                                                'Click en Encargado - Boton Index Slider',
                                            title:
                                                'Servicios - Encargado Slider Index');
                                    setState(() {
                                      index = 2;
                                      sliderController.animateToPage(index);
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Text(appLocal.serElEncargado,
                                          style: DashboardLabel.h4),
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
                                  onPressed: () {
                                    Provider.of<EventsProvider>(context,
                                            listen: false)
                                        .clickEvent(
                                            source: 'home/servicios',
                                            description:
                                                'Click en Conferencias - Boton Index Slider',
                                            title:
                                                'Servicios - Conferencias Slider Index');
                                    setState(() {
                                      index = 3;
                                      sliderController.animateToPage(index);
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Text(appLocal.conferencias,
                                          style: DashboardLabel.h4),
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
                        splashRadius: 18,
                        onPressed: () => setState(() {
                          sliderController.previousPage();
                          if (index == 0) {
                            index = 3;
                          } else {
                            index = index - 1;
                          }
                        }),
                        icon: const Icon(
                          Icons.arrow_circle_left_outlined,
                          size: 18,
                        ),
                        color: azulText,
                      ),
                    ),
                  Expanded(
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxWidth: 1000, minWidth: 350),
                      child: CarouselSlider(
                          carouselController: sliderController,
                          items: [...sliders],
                          options: CarouselOptions(
                            scrollPhysics: const NeverScrollableScrollPhysics(),
                            onPageChanged: (index, reason) {
                              setState(() {
                                index = index;
                              });
                            },
                            height: 400,
                            viewportFraction: 1,
                            enableInfiniteScroll: true,
                          )),
                    ),
                  ),
                  if (wScreen > 500)
                    SizedBox(
                      width: 50,
                      child: IconButton(
                        splashRadius: 18,
                        onPressed: () => setState(() {
                          sliderController.nextPage();
                          if (index == 3) {
                            index = 0;
                          } else {
                            index = index + 1;
                          }
                        }),
                        icon: const Icon(
                          Icons.arrow_circle_right_outlined,
                          size: 18,
                        ),
                        color: azulText,
                      ),
                    ),
                ],
              ),
            ])))
      ],
    );
  }
}
