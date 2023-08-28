import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';

import '../../../providers/form_provider.dart';
import '../../shared/widgets/forms/form_sv_id.dart';
import '../../shared/widgets/forms/form_sv_know.dart';
import '../../shared/widgets/forms/form_sv_rrss.dart';
import 'form_thx_view.dart';

class FormulariosPage extends StatefulWidget {
  final String rootForm;
  final int? index;
  const FormulariosPage({super.key, required this.rootForm, this.index = 0});

  @override
  State<FormulariosPage> createState() => _FormulariosPageState();
}

class _FormulariosPageState extends State<FormulariosPage> {
  @override
  void initState() {
    Provider.of<FormProvider>(context, listen: false).rootForm = widget.rootForm;
    Provider.of<FormProvider>(context, listen: false).setCurrentIndex(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Slider(
            index: widget.index ?? 0,
          ),
        ],
      ),
    );
  }
}

class Slider extends StatefulWidget {
  final int index;
  const Slider({super.key, required this.index});

  @override
  State<Slider> createState() => _SliderState();
}

class _SliderState extends State<Slider> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final formProvider = Provider.of<FormProvider>(context);
    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Container(
              alignment: Alignment.centerLeft,
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: IconButton(
                    onPressed: () {
                      if (widget.index == 1) {
                        Navigator.pushReplacementNamed(context, '/v/mentoria');
                      }
                      if (widget.index == 2) {
                        Navigator.pushReplacementNamed(context, '/v/encargado');
                      }
                      if (widget.index == 3) {
                        Navigator.pushReplacementNamed(context, '/v/conferencias');
                      }
                      if (widget.index == 0) {
                        Navigator.pushReplacementNamed(context, '/v/asesoria');
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: azulText,
                      size: 30,
                    )),
              ),
            ),
            CarouselSlider(
                carouselController: formProvider.formScrollController,
                items: const [FormSVid(), FormSVknow(), FormSVrrss(), FormThxView()],
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    formProvider.currentIndex = index;
                    setState(() {});
                  },
                  height: size.height,
                  reverse: false,
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  viewportFraction: 1,
                  initialPage: 0,
                )),
          ],
        ),
      ),
    );
  }
}
