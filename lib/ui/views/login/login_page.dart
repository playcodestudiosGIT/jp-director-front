import 'package:flutter/material.dart';


import '../../../constant.dart';
import '../../shared/widgets/forms/login_form.dart';
import '../../shared/widgets/politicas_footer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double wScreen = MediaQuery.of(context).size.width;
    double hScreen = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          alignment: (wScreen < 450) ? Alignment.topCenter:Alignment.center,
                          constraints: BoxConstraints(maxWidth: 1200, minHeight: hScreen),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              if (wScreen > 980)
                                const Column(
                                  children: [
                                    SizedBox(height: 315, child: Image(image: logoGrande)),
                                    PoliticasFooter()
                                  ],
                                ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (wScreen <= 980) const SizedBox(width: 200, height: 136, child: Image(image: logoGrande)),
                                  const SizedBox(width: 315, child: LoginForm()),
                                  if (wScreen <= 980)
                                    const Column(
                                      children: [
                                        PoliticasFooter()
                                      ],
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
