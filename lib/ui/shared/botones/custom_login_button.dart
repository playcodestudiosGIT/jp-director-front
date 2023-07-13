import 'package:flutter/material.dart';
import 'package:jpdirector_frontend/constant.dart';
import 'package:jpdirector_frontend/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final double width;
  final Function? onPress;
  final Color color;
  final IconData? icon;
  const LoginButton({super.key, required this.text, required this.onPress, required this.width, this.color = azulText, this.icon});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return GestureDetector(
      onTap: () => onPress!(),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
          width: width,
          height: 34,
          child: Center(
              child: (authProvider.isLoading)
                  ? Container(
                      padding: const EdgeInsets.all(3),
                      width: 30,
                      height: 30,
                      child: const CircularProgressIndicator(
                        color: blancoText,
                      ))
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null)
                      ...[
                        Icon(icon, color: Colors.white,),
                        const SizedBox(width: 10)
                      ],
                      Text(text, style: const TextStyle(fontFamily: 'Roboto', color: blancoText, fontSize: 14, fontWeight: FontWeight.w800)),
                    ],
                  )),
        ),
      ),
    );
  }
}
