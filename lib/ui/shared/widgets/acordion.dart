import 'package:flutter/material.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';

import '../../../constant.dart';
import '../../../providers/export_all_providers.dart';
import '../../../providers/meta_event_provider.dart';

class Acordeon extends StatefulWidget {
  final String title;
  final String content;
  final String service;

  const Acordeon(
      {Key? key,
      required this.title,
      required this.content,
      required this.service})
      : super(key: key);

  @override
  State<Acordeon> createState() => _AcordeonState();
}

class _AcordeonState extends State<Acordeon> {
  String estado = '';
  bool isExpanded = false;
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    if (isExpanded) {
      estado = 'Abrio acordeon';
    } else {
      estado = 'Cerro acordeon';
    }
    return MouseRegion(
      onHover: (event) => setState(() {
        isHover = true;
      }),
      onExit: (event) => setState(() {
        isHover = false;
      }),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => setState(() {
          Provider.of<MetaEventProvider>(context, listen: false).clickEvent(
              source: '/v/${widget.service} - ACORDEON',
              description: '$estado ${widget.title}',
              title: widget.title);
          isExpanded = !isExpanded;
        }),
        child: Column(
          children: [
            Container(
              color: (isHover)
                  ? Colors.white.withOpacity(0.2)
                  : Colors.white.withOpacity(0.1),
              width: double.infinity,
              height: 50,
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  Text(widget.title, style: DashboardLabel.h4),
                  Spacer(),
                  if (!isExpanded) const Icon(Icons.arrow_downward, size: 20),
                  if (isExpanded) const Icon(Icons.arrow_upward, size: 20),
                  const SizedBox(width: 20)
                ],
              ),
            ),
            if (isExpanded) ...[
              const Divider(),
              Container(
                width: double.infinity,
                color: Colors.white.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(widget.content),
                ),
              )
            ],
            Container(
              width: double.infinity,
              height: 5,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                bgColor,
                azulText,
                bgColor,
              ])),
            ),
          ],
        ),
      ),
    );
  }
}
