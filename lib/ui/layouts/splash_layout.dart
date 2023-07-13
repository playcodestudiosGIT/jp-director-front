import 'package:flutter/material.dart';

import '../../constant.dart';

class SplashLayout extends StatelessWidget {
  const SplashLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircularProgressIndicator(
            color: blancoText,
          ),
          SizedBox(
            height: 20,
          ),
          Text('Checkin')
        ]),
      ),
    );
  }
}
