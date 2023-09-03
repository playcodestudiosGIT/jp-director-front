import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'package:universal_html/html.dart' as html;
import 'dart:ui_web' as ui;

import '../ui/shared/widgets/progress_ind.dart';

class AgendaPlug extends StatefulWidget {
  const AgendaPlug({super.key});

  @override
  AgendaPlugState createState() => AgendaPlugState();
}

class AgendaPlugState extends State<AgendaPlug> {
  String createdViewId = 'map_element';

  @override
  void initState() {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        createdViewId,
        (int viewId) => html.IFrameElement()
          ..style.width = '100%' //'800'
          ..style.height = '100%' //'400'
          ..style.overflowY = 'hidden'
          ..srcdoc = """<!-- Principio del widget integrado de Calendly -->
    
                      <div class="calendly-inline-widget" data-url="https://calendly.com/jp-director/asesoria-1-1?background_color=00041c&text_color=ffffff&primary_color=15e0fb" style="min-width:300px; max-width:800px; height:1200px; overflow-y:hidden;"></div>
                      <script type="text/javascript" src="https://assets.calendly.com/assets/external/widget.js" async></script>
                  
                      <!-- Final del widget integrado de Calendly -->"""
          ..style.border = 'none');

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hSize = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      width: 800,
      height: hSize - 200,
      child: Stack(
        children: [
          const Positioned(child: ProgressInd()),
          Positioned(
            child: Directionality(
                textDirection: TextDirection.ltr,
                child: HtmlElementView(
                  viewType: createdViewId,
                )),
          ),
        ],
      ),
    );
  }
}
