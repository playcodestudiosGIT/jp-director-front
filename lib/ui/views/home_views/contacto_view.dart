import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/providers/leads_provider.dart';
import 'package:jpdirector_frontend/ui/shared/botones/custom_button.dart';
import 'package:jpdirector_frontend/ui/shared/labels/dashboard_label.dart';
import 'package:jpdirector_frontend/ui/shared/logotop.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';

class ContactoView extends StatelessWidget {
  const ContactoView({super.key});

  @override
  Widget build(BuildContext context) {
    final wScreen = MediaQuery.of(context).size.width;

    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: bgColor,
          image: DecorationImage(
              image: bgContacto, opacity: 0.2, alignment: (wScreen < 700) ? const Alignment(0.3, 0) : Alignment.center, fit: BoxFit.cover),
          backgroundBlendMode: BlendMode.darken,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (wScreen < 450) const SizedBox(height: 80),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: 612,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: bgColor.withOpacity(0.7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '@jpdirector - Jorge Pérez',
                          style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w700, color: azulText),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Desde hace 4 años estoy comprometido a educar y potenciar negocios con estrategias efectivas en publicidad que dan el punto.\n\nCon un recorrido de mas de \$1.000.000 USD invertidos y un retorno de \$15.000.000 USD en gran cantidad de campañas publicitarias con inumerables pruebas en Facebook, Instagram y TikTok ADS, afirmo que el éxito en los negocios se consigue con:\n\n1.Una excelente estrategia publicitaria\n2.Analizar los datos\n3.Contar con un profesional con experiencia\n\nMi misión es ser tu mentor o el encargado de tu marca y acompañarte en todo el proceso.',
                          style: DashboardLabel.mini,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                alignment: Alignment.center,
                                height: 55,
                                width: 250,
                                decoration: BoxDecoration(
                                    border: Border.all(color: verdeBorde, width: 4, style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(15)),
                                child: TextButton(
                                  child: Text(
                                    'DESCARGA ESTE REGALO',
                                    style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700, color: blancoText),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => const CustomAlertDialogGift(),
                                    );
                                  },
                                )),
                          ],
                        ),
                        const SizedBox(height: 10)
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    color: bgColor.withOpacity(0.7),
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    width: double.infinity,
                    // height: ,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          'Si tienes alguna duda, comunícate conmigo vía ',
                          style: DashboardLabel.paragraph,
                        ),
                     
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              //TODO: WhatsApp launch
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton.outlined(onPressed: (){}, icon: const Icon(FontAwesomeIcons.whatsapp, color: verdeBorde,)),
                                Text(
                                  'Whatsapp',
                                  style: DashboardLabel.paragraph.copyWith(color: azulText),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(8),
                    width: double.infinity,
                    color: bgColor.withOpacity(0.8),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: wScreen < 500 ? 0 : 8,
                          ),
                          child: Text(
                            'JP DIRECTOR | QUIERO ADS',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: blancoText,
                              fontWeight: FontWeight.w700,
                              fontSize: wScreen < 500 ? 10 : 10,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: wScreen < 500 ? 0 : 8),
                          child: Text(
                            'TODOS LOS DERECHOS RESERVADOS © 2023',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: blancoText,
                              fontWeight: FontWeight.w700,
                              fontSize: wScreen < 500 ? 10 : 10,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: wScreen < 500 ? 8 : 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () => NavigatorService.navigateTo(Flurorouter.pdpRoute),
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: Text(
                                    'POLÍTICAS DE PRIVACIDAD',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: azulText,
                                      fontWeight: FontWeight.w700,
                                      fontSize: wScreen < 500 ? 10 : 10,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                ' -  ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: blancoText,
                                  fontWeight: FontWeight.w700,
                                  fontSize: wScreen < 500 ? 10 : 10,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => NavigatorService.navigateTo(Flurorouter.tycRoute),
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: Text(
                                    'TÉRMINOS Y CONDICIONES',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: azulText,
                                      fontWeight: FontWeight.w700,
                                      fontSize: wScreen < 500 ? 10 : 10,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: wScreen < 500 ? 8 : 8),
                          child: Text(
                            'This site is not part of Meta website or Meta Inc.\nThis site is not part of the Tik Tok website or Tik Tok inc.\nThis site is NOT endorsed by Meta or Tik Tok in any way.\n\nMeta is a trademark of Meta and Tik Tok is a trademark of Tik Tok Inc',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: blancoText.withOpacity(0.6),
                              fontWeight: FontWeight.w300,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

class CustomAlertDialogGift extends StatefulWidget {
  const CustomAlertDialogGift({super.key});

  @override
  State<CustomAlertDialogGift> createState() => _CustomAlertDialogGiftState();
}

class _CustomAlertDialogGiftState extends State<CustomAlertDialogGift> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formController = GlobalKey();
    String email = 'youremail@email.com';
    String telf = '12223334455';
    bool isOk = Provider.of<LeadsProvider>(context).isOk;

    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Center(
          child: Container(
        width: 300,
        height: 420,
        decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(25)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const LogoTop(),
            const SizedBox(
              height: 30,
            ),
            if (isOk)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'Todo listo, ya puedes descargar tu regalo haciendo click en el enlace que hemos enviado a tu correo electrónico ',
                  style: GoogleFonts.roboto(color: Colors.white),
                ),
              ),
            if (!isOk)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Enviaremos un correo electrónico con el enlace de descarga',
                      style: GoogleFonts.roboto(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Form(
                    key: formController,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) => (EmailValidator.validate(value.toString())) ? null : 'Ingrese su correo',
                              style: GoogleFonts.roboto(color: blancoText, fontSize: 14),
                              decoration: buildInputDecoration(icon: Icons.email, label: email),
                              onChanged: (value) {
                                email = value;
                              }),
                          const SizedBox(height: 10),
                          TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value!.isEmpty || value.length <= 6) {
                                  return 'Teléfono sin caractéres especiales (12223334455)';
                                }
                                if (value.length > 6 && value.length < 10) {
                                  return 'Debe incluir cod intenacional + cod de área';
                                }
                                if (!RegExp(r"^[0-9]").hasMatch(value)) {
                                  return 'Solo debe contener números. (12223334455)';
                                }
                                return null;
                              },
                              style: GoogleFonts.roboto(color: blancoText, fontSize: 14),
                              decoration: buildInputDecoration(icon: Icons.email, label: telf),
                              onChanged: (value) {
                                telf = value;
                              }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 270,
                          child: Text(
                            'Al hacer click en aceptar, confirmo que he leido y acepto todas las políticas y condiciones',
                            style: GoogleFonts.roboto(color: Colors.white.withOpacity(0.5), fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!isOk)
                  CustomButton(
                    text: 'Enviar',
                    onPress: () async {
                      if (formController.currentState!.validate()) {
                        await Provider.of<LeadsProvider>(context, listen: false).createLead(email: email, telf: telf);
                      }
                    },
                    width: 100,
                    color: Colors.green,
                  ),
                const SizedBox(width: 10),
                CustomButton(
                  text: (isOk) ? 'Ok' : 'Cancelar',
                  onPress: () {
                    Navigator.of(context).pop();
                  },
                  width: 100,
                  color: (isOk) ? Colors.green : Colors.red.withOpacity(0.5),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}

InputDecoration buildInputDecoration({required String label, required IconData icon, IconData? suffIcon, Function? onPrs}) => InputDecoration(
    fillColor: blancoText.withOpacity(0.03),
    filled: true,
    border: const OutlineInputBorder(
      borderSide: BorderSide(color: azulText),
    ),
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: azulText.withOpacity(0.3))),
    labelText: label,
    labelStyle: GoogleFonts.roboto(color: blancoText, fontSize: 14),
    prefixIcon: Icon(icon, color: azulText.withOpacity(0.3)),
    suffixIconColor: azulText.withOpacity(0.3));
