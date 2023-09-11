import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:jp_director/ui/shared/widgets/progress_ind.dart';
import 'package:photo_view/photo_view.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../shared/labels/dashboard_label.dart';

class ResultadosView extends StatelessWidget {
  final List listMiniPhotos = resultadosMini;
  final List listPhotos = resultados;

  ResultadosView({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final List<Widget> listResultWiget = [
      ...listMiniPhotos.map((image) {
        final i = listMiniPhotos.indexOf(image);
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
            child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                    onTap: () {
                      _dialogBuilder(context: context, i: i);
                    },
                    child: Image(image: NetworkImage(image)))));
      })
    ];

    final wScreen = MediaQuery.of(context).size.width;

    double viewport = 0.3;
    if (wScreen < 1000) {
      viewport = 0.4;
    }
    if (wScreen < 730) {
      viewport = 0.5;
    }
    if (wScreen < 590) {
      viewport = 0.6;
    }
    if (wScreen < 490) {
      viewport = 0.7;
    }
    if (wScreen < 420) {
      viewport = 0.8;
    }
    if (wScreen < 370) {
      viewport = 0.9;
    }
    if (wScreen < 330) {
      viewport = 1;
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    const SizedBox(height: 100),
                    Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  appLocal.miraloOjos,
                  textAlign: TextAlign.center,
                  style: (wScreen > 580) ?DashboardLabel.gigant : DashboardLabel.h2.copyWith(fontWeight: FontWeight.bold)
                ),
              ),
              Container(
                width: (wScreen > 580) ? 548 : 400,
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
                    SizedBox(
                      width: double.infinity,
                      height: 300,
                      child: PageView(
                        
                        children: [
                        CarouselSlider(
                            
                            items: listResultWiget,
                            options: CarouselOptions(
                              scrollPhysics: const NeverScrollableScrollPhysics(),
                                height: 300,
                                viewportFraction: viewport,
                                enlargeFactor: 0.4,
                                enlargeCenterPage: true,
                                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                                pageSnapping: false,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                autoPlay: true)),
                      ]),
                    ),
                    Center(
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5), color: Colors.transparent, child: const Image(image: baseGif)),
                    )
                  ])),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> _dialogBuilder({required BuildContext context, int i = 0}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          backgroundColor: Colors.transparent,
          content: ContentDialog(
            i: i,
          ));
    },
  );
}

class ContentDialog extends StatefulWidget {
  final int? i;
  const ContentDialog({super.key, this.i});

  @override
  State<ContentDialog> createState() => _ContentDialogState();
}

class _ContentDialogState extends State<ContentDialog> {
  late int index;

  @override
  void initState() {
    index = widget.i ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PageController pagecntl = PageController(initialPage: index);

    final size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            PageView(
              controller: pagecntl,
              children: [
                ...resultados
                    .map((e) => Padding(
                          padding: const EdgeInsets.only(bottom: 40.0),
                          child: PhotoView(
                              loadingBuilder: (context, event) => const ProgressInd(),
                              backgroundDecoration: const BoxDecoration(color: Colors.transparent),
                              imageProvider: NetworkImage(e)),
                        ))
                    .toList()
              ],
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(width: double.infinity),
                  Container(
                    color: bgColor.withOpacity(0.7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(azulText)),
                            onPressed: () {
                              if (index == 0) {
                                index = 4;
                                pagecntl.jumpToPage(4);
                              } else {
                                index--;
                                pagecntl.previousPage(duration: const Duration(microseconds: 300), curve: Curves.ease);
                              }
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.arrow_circle_left_outlined,
                              size: 30,
                              color: azulText,
                            )),
                        IconButton(
                            style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(azulText)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.clear,
                              size: 30,
                              color: Colors.red,
                            )),
                        IconButton(
                            style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(azulText)),
                            onPressed: () {
                              if (index > 4) {
                                pagecntl.jumpToPage(0);
                                index = 0;
                              } else {
                                index++;
                                pagecntl.nextPage(duration: const Duration(microseconds: 300), curve: Curves.ease);
                              }
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.arrow_circle_right_outlined,
                              size: 30,
                              color: azulText,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
