import 'package:flutter/material.dart';

import '../../../constant.dart';

class TopAreaBack extends StatelessWidget {
  final Function onPress;
  const TopAreaBack({super.key, required this.onPress});

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
          constraints: const BoxConstraints(maxWidth: 800),
          child: IconButton(
              splashRadius: 16,
              onPressed: ()=> onPress(),
              icon: const Icon(
                Icons.arrow_back,
                color: azulText,
                size: 16,
              )),
        ),
      ],
    );
  }
}
