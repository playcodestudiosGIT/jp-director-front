import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../../models/curso.dart';
import '../../../providers/export_all_providers.dart';
import '../../shared/widgets/curso_landing_slider.dart';

class SliderCurso extends StatefulWidget {
  final Curso curso;

  const SliderCurso({super.key, required this.curso});

  @override
  State<SliderCurso> createState() => _SliderCursoState();
}

class _SliderCursoState extends State<SliderCurso> {
  int currIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    Provider.of<AllCursosProvider>(context, listen: false).getCursosById(widget.curso.id);
    pageController = PageController(initialPage: currIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 800, maxHeight: 400),
      child: Stack(
        children: [
          CursoLandingSlider(pageController: pageController),
          Column(
            children: [
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                            onTap: () {
                              if (currIndex == 0) {
                                currIndex = 4;

                                pageController.animateToPage(4, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                              } else {
                                currIndex = currIndex - 1;
                                pageController.animateToPage(currIndex, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                              }
                            },
                            child: const SizedBox(
                                width: 30,
                                height: 30,
                                child: Icon(
                                  Icons.arrow_circle_left_outlined,
                                  color: azulText,
                                  size: 18,
                                ))),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                            onTap: () {
                              if (currIndex == 4) {
                                currIndex = 0;
                                pageController.animateToPage(
                                  0,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.ease,
                                );
                              } else {
                                currIndex = currIndex + 1;
                                pageController.animateToPage(
                                  currIndex,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.ease,
                                );
                              }
                            },
                            child: const SizedBox(
                              width: 30,
                              height: 30,
                              child: Icon(
                                Icons.arrow_circle_right_outlined,
                                color: azulText,
                                size: 18,
                              ),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
