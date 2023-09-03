import 'package:flutter/material.dart';
import 'package:jp_director/services/navigator_service.dart';

import 'package:jp_director/services/mobileui.dart' if (dart.library.html) 'package:jp_director/services/webui.dart' as multiplatform;
import '../../shared/widgets/top_area_back.dart';

class AsesoriaAgendarPage extends StatelessWidget {
  const AsesoriaAgendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hSize = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Column(
          children: [
            TopAreaBack(onPress: () => NavigatorService.navigateTo('/servicios')),
            const SizedBox(height: 15),
            Container(constraints: BoxConstraints(maxHeight: hSize, maxWidth: 800), child: const multiplatform.AgendaPlug()),
          ],
        ),
      ],
    );
  }
}
