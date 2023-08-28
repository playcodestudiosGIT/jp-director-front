import 'package:flutter/material.dart';
import 'package:jp_director/constant.dart';

class ProgressInd extends StatelessWidget {
  const ProgressInd({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 70,
        height: 70,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Positioned(
              right: 10,
              bottom: 20,
              child: SizedBox(
                width: 10,
                height: 10,
                child: CircularProgressIndicator(strokeAlign: BorderSide.strokeAlignCenter, color: azulText, strokeWidth: 4, backgroundColor: bgColor,  )),
            ),
            Transform.rotate(
                angle: .7,
                child: const Image(
                  image: rocketInd,
                  width: 50,
                )),
          ],
        ),
      ),
    );
  }
}
