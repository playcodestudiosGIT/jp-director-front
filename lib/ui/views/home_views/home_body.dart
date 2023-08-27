import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:jpdirector_frontend/providers/all_cursos_provider.dart';

import '../../../constant.dart';
import '../../../providers/export_all_providers.dart';
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
