import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../providers/auth_provider.dart';

class ResultadosView extends StatelessWidget {
  final List listMiniPhotos = resultadosMini;
  final List listPhotos = resultados;

  ResultadosView({super.key});

  @override
  Widget build(BuildContext context) {
    //Image(image: NetworkImage(img))
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
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding:
            (wScreen < 715 && authProvider.authStatus == AuthStatus.authenticated) ? const EdgeInsets.only(left: 0) : const EdgeInsets.only(left: 0),
        child: Center(
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
                            'MÍRALO CON TUS PROPIOS OJOS',
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
                    .map((e) => PhotoView(
                        loadingBuilder: (context, event) => const Center(
                                child: SizedBox(
                              width: 35,
                              height: 35,
                              child: CircularProgressIndicator(),
                            )),
                        backgroundDecoration: const BoxDecoration(color: Colors.transparent),
                        imageProvider: NetworkImage(e)))
                    .toList()
              ],
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
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
                          child: const Icon(
                            Icons.arrow_circle_left_outlined,
                            size: 20,
                            color: bgColor,
                          )),
                      TextButton(
                          style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(azulText)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.clear,
                            size: 40,
                            color: Colors.red,
                          )),
                      TextButton(
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
                          child: const Icon(
                            Icons.arrow_circle_right_outlined,
                            size: 20,
                            color: bgColor,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
