import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:jp_director/generated/l10n.dart';


import '../../../constant.dart';

import '../../../services/navigator_service.dart';
import '../../shared/labels/dashboard_label.dart';

class FirstView extends StatelessWidget {
  const FirstView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenData = MediaQuery.of(context).size.width;
    return (screenData > 1150) ? const NormalBody() : const MobileBody();
  }
}

class NormalBody extends StatelessWidget {
  const NormalBody({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final screenData = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 100),
            ),
            Positioned(
              top: 250,
              left: 135,
              child: SlideInLeft(from: 60, duration: const Duration(seconds: 10), child: const Image(width: 160, image: planetaI)),
            ),
            Positioned(
              top: 320,
              left: 0,
              child: SlideInRight(from: 60, duration: const Duration(seconds: 10), child: const Image(width: 200, image: planetaM)),
            ),
            Positioned(
              bottom: 260,
              left: 220,
              child: SlideInLeft(from: 60, duration: const Duration(seconds: 10), child: const Image(width: 100, image: planetaF)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 60),
                                // width: 600,
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        appLocal.educacionYEstrategia,
                                        style: (screenData.width < 450) ? DashboardLabel.especialT2 : DashboardLabel.especialT1
                                      ),
                                      Text(
                                        appLocal.llegasteAlMundo,
                                        style: (screenData.width < 450) ? DashboardLabel.h2 : DashboardLabel.semiGigant
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            appLocal.siu,
                                            style: DashboardLabel.especial86
                                          ),
                                          FadeInRight(
                                            from: 20,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  appLocal.buscasAcelerar,
                                                  style: DashboardLabel.paragraph,
                                                ),
                                                Text(
                                                  appLocal.quieresConseguir,
                                                  style: DashboardLabel.paragraph,
                                                ),
                                                Text(
                                                  appLocal.quieresTener,
                                                  style: DashboardLabel.paragraph,
                                                ),
                                                Text(
                                                  appLocal.deseasDejar,
                                                  style: DashboardLabel.paragraph,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        appLocal.descubreComo,
                                        style: DashboardLabel.h1.copyWith(color:  azulText),
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            constraints: const BoxConstraints(maxWidth: 450),
                                            child: GestureDetector(
                                              onTap: () {
                                                NavigatorService.navigateTo('/cursos');
                                              },
                                              child: MouseRegion(
                                                cursor: SystemMouseCursors.click,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  child: BounceInDown(
                                                    from: 15,
                                                    duration: const Duration(seconds: 1),
                                                    child: const Image(
                                                      image: arrDown,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 800, minWidth: 490, minHeight: 370 ),
                    alignment: Alignment.center,
                    child: Image(
                        colorBlendMode: (screenData.width < 1300) ? BlendMode.multiply : BlendMode.screen,
                        fit: BoxFit.scaleDown,
                        image: bgHome),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MobileBody extends StatelessWidget {
  const MobileBody({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final screenData = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SizedBox(
        width: 430,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Text(
              appLocal.educacionYEstrategia,
              textAlign: (screenData.width < 1150) ? TextAlign.center : TextAlign.start,
              style: (screenData.width < 450) ? DashboardLabel.especialT2 : DashboardLabel.especialT1
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                appLocal.llegasteAlMundo,
                style: (screenData.width < 450) ? DashboardLabel.h2 : DashboardLabel.semiGigant
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    appLocal.siu,
                    style: DashboardLabel.azulTextH1.copyWith(fontSize: (screenData.width > 550) ? 86 : 54),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appLocal.buscasAcelerar,
                        style: DashboardLabel.paragraph,
                      ),
                      Text(
                        appLocal.quieresConseguir,
                        style: DashboardLabel.paragraph,
                      ),
                      Text(
                        appLocal.quieresTener,
                        style: DashboardLabel.paragraph,
                      ),
                      Text(
                        appLocal.deseasDejar,
                        style: DashboardLabel.paragraph,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Image(
              image: bgHome,
              width: (screenData.width < 450) ? 300 : 500,
              height: 370,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                appLocal.descubreComo,
                textAlign: (screenData.width > 550) ? TextAlign.left : TextAlign.center,
                style: DashboardLabel.h1.copyWith(color:  azulText),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  constraints: BoxConstraints(maxWidth: screenData.width),
                  child: GestureDetector(
                    onTap: () {
                      NavigatorService.navigateTo('/cursos');
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        alignment: Alignment.center,
                        child: BounceInDown(
                          from: 15,
                          duration: const Duration(seconds: 1),
                          child: const Image(
                            image: arrDown,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
