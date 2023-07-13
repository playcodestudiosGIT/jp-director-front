import 'package:flutter/material.dart';
import 'package:jpdirector_frontend/ui/shared/botones/custom_button.dart';
import 'package:jpdirector_frontend/ui/shared/labels/dashboard_label.dart';

import '../../constant.dart';

class WhiteCard extends StatelessWidget {
  final String? title;
  final Widget child;

  const WhiteCard({super.key, this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      decoration: buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title!,
                  style: DashboardLabel.h3.copyWith(color: bgColor),
                ),
                
                Row(
                  children: [
                    if(size.width > 400)
                    
                    const SizedBox(width: 30),
                    if(size.width > 500)
                    CustomButton(
                      text: 'Comentarios',
                      onPress: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      width: 140,
                      icon: Icons.comment,
                    ),
                    if(size.width <= 500)
                    CustomButton(
                      text: '',
                      onPress: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      width: 55,
                      icon: Icons.comment,
                    ),
                  ],
                )
              ],
            ),
            const Divider()
          ],
          child
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
      color: blancoText, borderRadius: BorderRadius.circular(5), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)]);
}
