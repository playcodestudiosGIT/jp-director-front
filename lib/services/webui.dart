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

          // ..style.scrollBehavior = 'none'
          ..srcdoc = """<!-- Principio del widget integrado de Calendly -->
                      <div class="calendly-inline-widget" data-url="https://calendly.com/jpdirector/1hour?background_color=00041c&text_color=ffffff&primary_color=15e0fb" style="height:100vh; overflow:hidden;"></div>
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
    return Container(
      alignment: Alignment.center,
      child: Stack(
        children: [
          const Positioned(child: ProgressInd()),
          Positioned(
            child: HtmlElementView(
              viewType: createdViewId,
            ),
          ),
        ],
      ),
    );
  }
}
