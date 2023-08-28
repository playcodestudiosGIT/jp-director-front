import 'package:flutter/material.dart';
import 'package:jp_director/router/router.dart';

import '../../services/navigator_service.dart';
import '../shared/labels/dashboard_label.dart';
import '../shared/widgets/progress_ind.dart';
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
            ? const ProgressInd()
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
                        style: DashboardLabel.h3.copyWith(fontWeight: FontWeight.w800),
                      )),
                  const SizedBox(height: 15),
                  Container(
                      margin: const EdgeInsets.only(left: 10, right: 10, top: 0),
                      child: Text(
                        subtitle,
                        style: DashboardLabel.paragraph,
                      )),
                  Container(
                      margin: const EdgeInsets.only(left: 10, right: 10, top: 11),
                      child: Text(
                        description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: DashboardLabel.paragraph
                      )),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        const Icon(Icons.view_module),
        
                        Text(modulos),
                        const SizedBox(width: 30),
                        const Icon(Icons.timer_outlined),
     
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

