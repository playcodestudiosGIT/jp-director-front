import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';

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
        return SizedBox(
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              child: Center(
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          appLocal.miraloOjos,
                          style: GoogleFonts.roboto(fontSize: (wScreen < 450) ? 18 : 24, fontWeight: FontWeight.w900, color: azulText),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 500,
                        child: PageView(children: [
                          CarouselSlider(
                              items: listResultWiget,
                              options: CarouselOptions(

                                height: 500,
                                viewportFraction: 0.5,
                                enlargeFactor: 0.8,
                                enlargeCenterPage: true,
                                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                                pageSnapping: false,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                autoPlay: true
                              )),
                        ]),
                      ),
                      Center(
                        child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5), color: Colors.transparent, child: const Image(image: baseGif)),
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
                          loadingBuilder: (context, event) => const Center(
                                  child: SizedBox(
                                width: 35,
                                height: 35,
                                child: CircularProgressIndicator(),
                              )),
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
                              color: bgColor,
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
                              color: bgColor,
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
