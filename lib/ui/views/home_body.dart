import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/baners_provider.dart';
import 'home_views/ads_view.dart';
import 'home_views/contacto_view.dart';
import 'home_views/first_view.dart';
import 'home_views/resultados_view.dart';
import 'home_views/service_view.dart';

class HomeBody extends StatefulWidget {
  final int index;

  const HomeBody({super.key, this.index = 0});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  late PageController homePageController;

  @override
  void initState() {
    super.initState();
    homePageController = PageController(initialPage: widget.index);
    Provider.of<BanersProvider>(context, listen: false).getBaners();
  }

  @override
  void dispose() {
    super.dispose();
    homePageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView(
      controller: homePageController,
      primary: false,

      children: [
        SizedBox(width: double.infinity, height: size.height, child: const FirstView()),
        SizedBox(width: double.infinity, height: size.height, child: const AdsView()),
        SizedBox(width: double.infinity, height: size.height, child: const ServicesView()),
        SizedBox(width: double.infinity, height: size.height, child: ResultadosView()),
        SizedBox(width: double.infinity, height: size.height, child: const ContactoView()),
      ],
    );
  }
}
