import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:jp_director/providers/leads_provider.dart';
import 'package:jp_director/ui/shared/botones/custom_button.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';
import 'package:jp_director/ui/shared/labels/inputs_decorations.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constant.dart';
import '../../../generated/l10n.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import '../../shared/widgets/logotop.dart';

class ContactoView extends StatelessWidget {
  const ContactoView({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final wScreen = MediaQuery.of(context).size.width;
    final hScreen = MediaQuery.of(context).size.height;

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
                          style: (hScreen < 585) ? DashboardLabel.h3 : DashboardLabel.azulTextH1
                        ),
                    
                        
                        const SizedBox(
                          height: 20,
                        ),
                         if(hScreen > 585)
                        Text(
                          appLocal.contactoLargeText,
                          style: (hScreen < 585) ? DashboardLabel.mini.copyWith(fontSize: 8) : DashboardLabel.mini,
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
                                    appLocal.descargaRegaloBtn,
                                    style: DashboardLabel.paragraph,
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
                          appLocal.siTienesDudas,
                          style: DashboardLabel.paragraph,
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              final Uri url = Uri.parse('https://wa.me/12142265941?text=from:%20Web%20contact.%20Need%20information%20about');
                              launchUrl(url);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      FontAwesomeIcons.whatsapp,
                                      color: verdeBorde,
                                    )),
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
                  if (MediaQuery.of(context).size.height > 715)
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
                            appLocal.derechosReservados,
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
                                    appLocal.politicasDeProivacidad,
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
                                    appLocal.terminosYCondiciones,
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
    final appLocal = AppLocalizations.of(context);
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
                  appLocal.todoListoDescarga,
                  style: DashboardLabel.h4,
                ),
              ),
            if (!isOk)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      
                      appLocal.enviaremosUnEmail,
                      style: DashboardLabel.h4,
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
                              cursorColor: azulText,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) => (EmailValidator.validate(value.toString())) ? null : appLocal.correoTextFiel,
                              style: DashboardLabel.h4,
                              decoration: InputDecor.formFieldInputDecoration(icon: Icons.email, label: email),
                              onChanged: (value) {
                                email = value;
                              }),
                          const SizedBox(height: 10),
                          TextFormField(
                              cursorColor: azulText,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value!.isEmpty || value.length <= 6) {
                                  return appLocal.telfSinCaracteres;
                                }
                                if (value.length > 6 && value.length < 10) {
                                  return appLocal.telfDebeCodArea;
                                }
                                if (!RegExp(r"^[0-9]").hasMatch(value)) {
                                  return appLocal.telfSoloNumeros;
                                }
                                return null;
                              },
                              style: DashboardLabel.h4,
                              decoration: InputDecor.formFieldInputDecoration(icon: Icons.phone, label: telf),
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
                            appLocal.alHacerClickHeLeido,
                            style: DashboardLabel.mini,
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
                    text: appLocal.enviarBtn,
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
                  text: (isOk) ? 'OK' : appLocal.cancelarBtn,
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
