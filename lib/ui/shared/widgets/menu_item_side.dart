import 'package:flutter/material.dart';
import 'package:jpdirector_frontend/ui/shared/labels/dashboard_label.dart';

import '../../../constant.dart';

class MenuItemSide extends StatefulWidget {
  final String text;
  final IconData icon;
  final bool isActive;
  final Function onPress;

  const MenuItemSide({Key? key, required this.text, required this.icon, required this.isActive, required this.onPress}) : super(key: key);

  @override
  State<MenuItemSide> createState() => _MenuItemSideState();
}

class _MenuItemSideState extends State<MenuItemSide> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      color: isHovered
          ? blancoText.withOpacity(0.1)
          : widget.isActive
              ? azulText
              : Colors.transparent,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.isActive ? null : () => widget.onPress(),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: MouseRegion(
              onEnter: (_) => setState(() => isHovered = true),
              onExit: (_) => setState(() => isHovered = false),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    widget.icon,
                    color: widget.isActive
                        ? isHovered
                            ? blancoText.withOpacity(0.1)
                            : const Color(0xff111111)
                        : blancoText.withOpacity(0.3),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.text,
                    style: DashboardLabel.paragraph.copyWith(
            
                      color: widget.isActive
                          ? isHovered
                              ? blancoText.withOpacity(0.1)
                              : const Color(0xff111111)
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
