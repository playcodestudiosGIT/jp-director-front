import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:jpdirector_frontend/ui/shared/botones/botonverde.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../providers/form_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
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
    // final authProvider = Provider.of<AuthProvider>(context);
    final formProvider = Provider.of<FormProvider>(context);
    late String botonText;

    if (formProvider.getPageIndex() == 0) {
      botonText = 'SIGUIENTE';
    }
    if (formProvider.getPageIndex() == 1) {
      botonText = 'SIGUIENTE';
    }
    if (formProvider.getPageIndex() == 2) {
      botonText = 'ENVIAR';
    }
    if (formProvider.getPageIndex() == 3) {
      botonText = 'FINALIZAR';
    }

    onPressed() async {
      if (formProvider.getPageIndex() == 0 && formProvider.keyForm.currentState!.validate()) formProvider.formScrollController.nextPage();

      if (formProvider.getPageIndex() == 1 && formProvider.keyForm2.currentState!.validate()) formProvider.formScrollController.nextPage();

      if (formProvider.getPageIndex() == 2 && formProvider.keyForm3.currentState!.validate()) {
        formProvider.sendForm();
        formProvider.keyForm.currentState?.dispose();
        formProvider.keyForm2.currentState?.dispose();
        formProvider.keyForm3.currentState?.dispose();
        formProvider.formScrollController.nextPage();
      }

      if (formProvider.getPageIndex() == 3) {
        NavigatorService.replaceTo(Flurorouter.homeRoute);
        formProvider.setCurrentIndex(0);
      }
    }

    return SizedBox(
      width: double.infinity,
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
                  reverse: false,
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  height: 650,
                  viewportFraction: 1,
                  initialPage: 0,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 100,
                ),
                BotonVerde(text: botonText, width: 100, onPressed: ()=> onPressed()),
                
              ],
            ),
            const SizedBox(
              height: 300,
            )
          ],
        ),
      ),
    );
  }
}
