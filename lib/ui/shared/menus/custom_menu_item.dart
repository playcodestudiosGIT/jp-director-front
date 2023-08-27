import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:jpdirector_frontend/ui/shared/labels/dashboard_label.dart';

import '../../../constant.dart';

class CustomMenuItem extends StatefulWidget {
  final String text;
  final Function onPressed;
  final int delay;
  final double width;
  final double padding;

  const CustomMenuItem({Key? key, required this.text, required this.onPressed, this.delay = 0, required this.width, required this.padding}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomMenuItemState createState() => _CustomMenuItemState();
}

class _CustomMenuItemState extends State<CustomMenuItem> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      from: 10,
      duration: const Duration(milliseconds: 150),
      delay: Duration(milliseconds: widget.delay),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHover = true),
        onExit: (_) => setState(() => isHover = false),
        child: GestureDetector(
          onTap: () => widget.onPressed(),
          child: AnimatedContainer(
            alignment: Alignment.centerLeft,
            duration: const Duration(milliseconds: 300),
            width: widget.width,
            height: 50,
            color: isHover ? azulText : Colors.transparent,
            child: Padding(
              padding: EdgeInsets.only(left: widget.padding),
              child: Text(widget.text, style: DashboardLabel.h3.copyWith(color: isHover ? const Color(0xFF00041C) : const Color(0xffffffff))),
            ),
          ),
        ),
      ),
    );
  }
}
