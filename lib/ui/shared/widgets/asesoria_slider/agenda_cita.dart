import 'package:flutter/material.dart';
import 'package:jp_director/services/mobileui.dart' if (dart.library.html) 'package:jp_director/services/webui.dart' as multiplatform;

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
