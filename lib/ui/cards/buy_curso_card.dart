import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/router/router.dart';

import '../../services/navigator_service.dart';
import 'white_card_border.dart';

class BuyCursoCard extends StatelessWidget {
  final String uid;
  final String image;
  final String name;
  final String subtitle;
  final String modulos;
  final String description;
  final String duration;

  const BuyCursoCard(
      {Key? key,
      required this.image,
      required this.name,
      required this.subtitle,
      required this.description,
      required this.uid,
      required this.duration,
      required this.modulos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          NavigatorService.navigateTo('${Flurorouter.curso}/$uid/0');
        },
        child: SizedBox(
          width: 345,
          height: 485,
          child: (name == 'nombre')
            ? const Center(child: SizedBox(width: 35, height: 35, child: CircularProgressIndicator(color: Colors.white),),)
            : WhiteCardBorder(
              border: 44,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 0),
                    decoration: _cardDecoration(image),
                    height: 230,
                  ),
                  const SizedBox(height: 15),
                  Container(
                      margin: const EdgeInsets.only(left: 10, right: 10, top: 0),
                      child: Text(
                        name,
                        style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w800),
                      )),
                  const SizedBox(height: 15),
                  Container(
                      margin: const EdgeInsets.only(left: 10, right: 10, top: 0),
                      child: Text(
                        subtitle,
                        style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w400),
                      )),
                  Container(
                      margin: const EdgeInsets.only(left: 10, right: 10, top: 11),
                      child: Text(
                        description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                        ),
                      )),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        const Icon(Icons.view_module),
                        // const Text(
                        //   ' Modulos: ',
                        //   style: TextStyle(fontSize: 10),
                        // ),
                        Text(modulos),
                        const SizedBox(width: 30),
                        const Icon(Icons.timer_outlined),
                        // const Text(
                        //   ' Duracion: ',
                        //   style: TextStyle(fontSize: 10),
                        // ),
                        Text(duration)
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration(String img) {
    return BoxDecoration(borderRadius: BorderRadius.circular(40), image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover));
  }
}

