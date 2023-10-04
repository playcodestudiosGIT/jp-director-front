import 'package:flutter/material.dart';
import 'package:jp_director/constant.dart';
import 'package:jp_director/providers/auth_provider.dart';
import 'package:jp_director/providers/meta_event_provider.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';
import 'package:provider/provider.dart';

import '../widgets/progress_ind.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final double width;
  final Function? onPress;
  final Color color;
  final IconData? icon;
  const LoginButton(
      {super.key,
      required this.text,
      required this.onPress,
      required this.width,
      this.color = azulText,
      this.icon});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return GestureDetector(
      onTap: () async {
        Provider.of<MetaEventProvider>(context, listen: false)
            .clickEvent(source: 'Login Button', description: 'Usuarios que inician sesión');
        onPress!();
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(12)),
          width: width,
          height: 34,
          child: Center(
              child: (authProvider.isLoading)
                  ? const ProgressInd()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (icon != null) ...[
                          Icon(
                            icon,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 10)
                        ],
                        Text(text,
                            style: DashboardLabel.paragraph.copyWith(
                                color: bgColor, fontWeight: FontWeight.bold)),
                      ],
                    )),
        ),
      ),
    );
  }
}
