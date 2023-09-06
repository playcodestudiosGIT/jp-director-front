import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';

class NoPageFound extends StatelessWidget {
  const NoPageFound({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    return Container(
      color: const Color(0xFF00041C),
      child: Column(
        children: [
          const SizedBox(
            height: 120,
          ),
          const Image(
            image: ufoGif,
            width: 800,
          ),
          Text(
            appLocal.pagina404,
            style: const TextStyle(color: blancoText, fontSize: 50),
          ),
        ],
      ),
    );
  }
}
