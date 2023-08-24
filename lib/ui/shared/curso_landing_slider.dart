import 'package:flutter/material.dart';
import 'package:jpdirector_frontend/ui/shared/diapo_Item.dart';

import 'labels/dashboard_label.dart';

class CursoLandingSlider extends StatelessWidget {
  final PageController pageController;
  const CursoLandingSlider({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Esta misión es para ti', style: DashboardLabel.h1),
          ],
        ),
        Expanded(
            child: PageView(
          controller: pageController,
          scrollDirection: Axis.horizontal,
          children: listSliders,
        )),
      ],
    );
  }
}


List<Widget> listSliders = [
      const DiapoItem(
        bigText: 'Emprendedor o Freelancer',
        bigIcon: Icons.laptop,
        text:
            'Si eres emprendedor, tienes un negocio o quieres una formación que verdaderamente capacite a tu equipo a lanzar campañas de manera correcta',
      ),
      const DiapoItem(
        bigText: 'Dueños de Negocios',
        bigIcon: Icons.person_pin_outlined,
        text:
            'Ves publicidad todo el tiempo en tu teléfono y sabes que tu negocio lo necesita para darse a conocer y vender más. Esta formación te ayudará a entender como hacerlo y su importancia.',
      ),
      const DiapoItem(
        bigText: 'Negocio (Local o físico)',
        bigIcon: Icons.home_outlined,
        text:
            'Tienda de ropa, restaurante, gimnasio, bar o cualquier negocio que necesita tráfico en su tienda para consumir su producto o servicio.',
      ),
      const DiapoItem(
        bigText: 'Profesionales en Marketing y Comunicación',
        bigIcon: Icons.people_alt_outlined,
        text:
            'Si estás estudiando o trabajando en una empresa esto será muy valioso para desarrollarlo dentro de la compañía u ofrecerlo como uno de tus servicios.',
      ),
      const DiapoItem(
        bigText: 'Consultores o Especialistas',
        bigIcon: Icons.lightbulb_outline,
        text:
            'Eres médico, coach, realtor, abogado o nutricionista y tus servicios son altamente buscados en las redes sociales, por lo que solo falta exponerte de la manera correcta en publicidad.',
      ),
      const DiapoItem(
        bigText: 'Inhabilitados, Resagados o Bloqueados',
        bigIcon: Icons.visibility_off_outlined,
        text:
            'Si estás estudiando o trabajando en una empresa esto será muy valioso para desarrollarlo dentro de la compañía u ofrecerlo como uno de tus servicios.',
      ),
    ];
