import 'package:flutter/material.dart';

import '../../shared/top_area_back.dart';
import '../../shared/widgets/asesoria_slider/agenda_cita.dart';

class AsesoriaAgendarPage extends StatelessWidget {
  const AsesoriaAgendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TopAreaBack(),
              const SizedBox(height: 20),
              Container(constraints: const BoxConstraints(maxHeight: 800, maxWidth: 800), child: const Agenda()),
            ],
          )),
        ],
      ),
    );
  }
}
