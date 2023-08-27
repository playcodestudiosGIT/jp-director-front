import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constant.dart';
import '../labels/dashboard_label.dart';

class MenuItemTop extends StatefulWidget {
  final String text;
  final bool isActive;
  final Function onPress;

  const MenuItemTop({Key? key, required this.text, required this.isActive, required this.onPress}) : super(key: key);

  @override
  State<MenuItemTop> createState() => _MenuItemTopState();
}

class _MenuItemTopState extends State<MenuItemTop> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      color: isHovered
          ? blancoText.withOpacity(0.1)
          : widget.isActive
              ? azulText.withOpacity(0.1)
              : Colors.transparent,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.isActive ? null : () => widget.onPress(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: MouseRegion(
              onEnter: (_) => setState(() => isHovered = true),
              onExit: (_) => setState(() => isHovered = false),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.text,
                    textAlign: TextAlign.center,
                    style: DashboardLabel.paragraph.copyWith(
                      color: widget.isActive
                          ? isHovered
                              ? blancoText.withOpacity(0.1)
                              : blancoText.withOpacity(0.3)
                          : blancoText.withOpacity(0.3),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
