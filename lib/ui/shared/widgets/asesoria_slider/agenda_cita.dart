import 'package:flutter/material.dart';
import 'package:jpdirector_frontend/services/mobileui.dart' if (dart.library.html) 'package:jpdirector_frontend/services/webui.dart' as multiplatform;

class Agenda extends StatefulWidget {
  const Agenda({super.key});

  @override
  State<Agenda> createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          multiplatform.AgendaPlug(),
        ],
      ),
    );
  }
}
