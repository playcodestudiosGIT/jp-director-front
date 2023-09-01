import 'package:flutter/material.dart';
import 'package:jp_director/constant.dart';

import '../labels/dashboard_label.dart';
import 'progress_ind.dart';

class RespuestaWidget extends StatelessWidget {
  final String img;
  final String nombre;
  final String apellido;
  final String rol;
  final String respuesta;
  const RespuestaWidget({super.key, required this.img, required this.nombre, required this.apellido, required this.rol, required this.respuesta});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          CircleAvatar(
            backgroundImage: (img == '') ? const NetworkImage(noimage) : NetworkImage(img),
            radius: 10,
          ),
          const SizedBox(width: 10),
          (nombre == '')
          ? const ProgressInd()
          : Text(
            '$nombre $apellido', // e.id
            style: DashboardLabel.paragraph,
          ),
          if (rol == 'ADMIN_ROLE') ...[
            const SizedBox(width: 10),
            const Icon(
              Icons.star,
              color: Colors.amberAccent,
              size: 15,
            )
          ]
        ]),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(4),
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 25),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.white.withOpacity(0.1)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              respuesta,
              style: DashboardLabel.mini,
            ),
          ),
        ),
      ],
    );
  }
}