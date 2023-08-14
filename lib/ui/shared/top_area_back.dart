import 'package:flutter/material.dart';

import '../../constant.dart';
import '../../services/navigator_service.dart';

class TopAreaBack extends StatelessWidget {
  const TopAreaBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          width: double.infinity,
          height: 80,
        ),
        Container(
          padding: const EdgeInsets.only(left: 20),
          width: double.infinity,
          alignment: Alignment.centerLeft,
          constraints: const BoxConstraints(maxWidth: 1200),
          child: IconButton(
              onPressed: () {
                NavigatorService.navigateTo('/servicios');
              },
              icon: const Icon(
                Icons.arrow_back,
                color: azulText,
                size: 30,
              )),
        ),
      ],
    );
  }
}
