import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';
import 'ads_view.dart';
import 'contacto_view.dart';
import 'first_view.dart';
import 'resultados_view.dart';
import 'service_view.dart';

class HomeBody extends StatefulWidget {
  final int index;

  const HomeBody({super.key, this.index = 0});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  double scrollValue = 0.0;
  late PageController homePageController;
  bool isRocket = false;
  @override
  void initState() {
    super.initState();
    homePageController = PageController(initialPage: widget.index);
  }

  @override
  void dispose() {
    super.dispose();
    homePageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    homePageController.addListener(() {
      scrollValue = homePageController.page ?? 0;
    });
    final size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.center,
      children: [
        // if (scrollValue >= 1.6)
        //   Positioned(
        //       top: 550,
        //       right: 130,
        //       child: Transform.rotate(
        //         angle: 10,
        //         child: Opacity(
        //           opacity: 0.1,
        //           child: SlideInUp(
        //             from: 450,
        //             duration: const Duration(seconds: 20),
        //             child: const Image(
        //               width: 300,
        //               image: rocketGif,
        //             ),
        //           ),
        //         ),
        //       )),
        Container(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: ListView(
            controller: homePageController,
            primary: false,
            children: [
              SizedBox(width: double.infinity, height: size.height, child: const FirstView()),
              SizedBox(width: double.infinity, height: size.height, child: const AdsView()),
              SizedBox(width: double.infinity, height: size.height, child: const ServicesView()),
              SizedBox(width: double.infinity, height: size.height, child: ResultadosView()),
              SizedBox(width: double.infinity, height: size.height, child: const ContactoView()),
            ],
          ),
        ),
      ],
    );
  }
}
