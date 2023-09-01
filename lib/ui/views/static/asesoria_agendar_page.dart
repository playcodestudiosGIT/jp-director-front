import 'package:flutter/material.dart';

import '../../shared/widgets/asesoria_slider/agenda_cita.dart';
import '../../shared/widgets/top_area_back.dart';

class AsesoriaAgendarPage extends StatelessWidget {
  const AsesoriaAgendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hSize = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TopAreaBack(),
              const SizedBox(height: 15),
              Container(constraints: BoxConstraints(maxHeight: hSize, maxWidth: 800), child: const Agenda()),
            ],
          )),
        ],
      ),
    );
  }
}
