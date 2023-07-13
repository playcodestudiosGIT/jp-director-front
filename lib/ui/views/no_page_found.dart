import 'package:flutter/material.dart';

import '../../constant.dart';

class NoPageFound extends StatelessWidget {
  const NoPageFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF00041C),
      child: Container(
        child: const Column(
          children: [
            SizedBox(
              height: 120,
            ),
            Image(
              image: ufoGif,
              width: 800,
            ),
            Text(
              'Página no encontrada 404',
              style: TextStyle(color: blancoText, fontSize: 50),
            ),
          ],
        ),
      ),
    );
  }
}
