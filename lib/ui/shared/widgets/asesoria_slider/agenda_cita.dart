import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../constant.dart';
import '../../../../providers/forms/agendar_provider.dart';
import '../../../../providers/tarjeta_credito_provider.dart';
import '../../../../services/notificacion_service.dart';
import '../forms/agendar_form.dart';

class Agenda extends StatefulWidget {
  const Agenda({super.key});

  @override
  State<Agenda> createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    mes(int mes) {
      if (mes == 1) {
        return 'Enero';
      }
      if (mes == 2) {
        return 'Febrero';
      }
      if (mes == 3) {
        return 'Marzo';
      }
      if (mes == 4) {
        return 'Abril';
      }
      if (mes == 5) {
        return 'Mayo';
      }
      if (mes == 6) {
        return 'Junio';
      }
      if (mes == 7) {
        return 'Julio';
      }
      if (mes == 8) {
        return 'Agosto';
      }
      if (mes == 9) {
        return 'Septiembre';
      }
      if (mes == 10) {
        return 'Octubre';
      }
      if (mes == 11) {
        return 'Noviembre';
      }
      if (mes == 12) {
        return 'Diciembre';
      }
    }

    final agendarProvider = Provider.of<AgendarProvider>(context);
    // ignore: unused_local_variable
    Map<String, dynamic>? paymentIntent;
    return SizedBox(
      width: double.infinity,
      child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AgendarForm(),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Asegurate de seleccionar la fecha y la hora',
              style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w400, color: blancoText),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: azulText.withOpacity(0.05),
                    height: 42,
                    width: 200,
                    child: TextButton(
                      child: Text(
                        'FECHA: ${agendarProvider.date.day} de ${mes(agendarProvider.date.month)}',
                        style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w400, color: blancoText),
                      ),
                      onPressed: () async {
                        DateTime? newDate =
                            await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2025));

                        if (newDate == null) return;

                        agendarProvider.date = newDate;

                        agendarProvider.getAvailableHours(
                            agendarProvider.date.year.toString(),
                            agendarProvider.date.month.toString().padLeft(2, '0'),
                            agendarProvider.date.day
                                .toString()
                                .padLeft(2, '0')); // yyyy: newDate.year.toString(), mm: newDate.month.toString(), dd: newDate.day.toString()
                        agendarProvider.date = newDate;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                    height: 15,
                  ),
                  if (agendarProvider.isBuscando && agendarProvider.horasDispo!.isEmpty)
                    // if (agendarProvider.horasDispo!.length == 0)
                    const Center(
                        child: Column(
                      children: [
                        SizedBox(height: 15, width: 15, child: CircularProgressIndicator()),
                      ],
                    )),
                  if (agendarProvider.horasDispo!.isNotEmpty)
                    Container(
                      color: azulText.withOpacity(0.05),
                      height: 42,
                      width: 200,
                      child: DropdownButton(
                        dropdownColor: const Color(0xFF00041C),
                        value: agendarProvider.horaSeleccionada,
                        alignment: Alignment.center,
                        hint: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Seleccione la Hora',
                              style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w400, color: blancoText),
                            ),
                          ),
                        ),
                        underline: Container(),
                        // value:  reviernta
                        onChanged: (value) => setState(() {
                          agendarProvider.setHoraSelec(value.toString());
                          agendarProvider.setHoraSinFormato(value.toString());
                        }),
                        selectedItemBuilder: (context) {
                          return agendarProvider.horasDispo!.map((hora) {
                            final text = 'HORA: ${DateFormat.jm().format(DateTime.parse(hora[0].toString()))}';
                            return Center(
                              child: Text(
                                text,
                                style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w400, color: blancoText),
                              ),
                            );
                          }).toList();
                        },
                        items: agendarProvider.horasDispo!.map<DropdownMenuItem<String>>((hora) {
                          final index = agendarProvider.horasDispo!.indexOf(hora);

                          return DropdownMenuItem<String>(
                            value: index.toString(),
                            child: Center(
                              child: Text(
                                DateFormat.jm().format(DateTime.parse(hora[0].toString())),
                                style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w400, color: blancoText),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  const SizedBox(
                    height: 60,
                  ),
                  if (agendarProvider.horasDispo!.isEmpty)
                    Container(
                      height: 62,
                      width: 200,
                      decoration: BoxDecoration(
                          border: Border.all(color: verdeBorde.withOpacity(0.3), width: 2, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextButton(
                        onPressed: null,
                        child: Text(
                          'SELECCIONE LA FECHA Y LA HORA',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w700, color: blancoText),
                        ),
                      ),
                    ),
                  if (agendarProvider.horasDispo!.isNotEmpty)
                    Container(
                      height: 62,
                      width: 144,
                      decoration: BoxDecoration(
                          border: Border.all(color: verdeBorde, width: 4, style: BorderStyle.solid), borderRadius: BorderRadius.circular(15)),
                      child: TextButton(
                        child: (isLoading)
                            ? const SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(
                                  color: azulText,
                                ))
                            : Text(
                                'CHECKOUT',
                                style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w700, color: blancoText),
                              ),
                        onPressed: () {
                          if (agendarProvider.keyForm.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                              agendarProvider.redirectToCheckout(email:  agendarProvider.email, priceId: 'price_1MKVK0CVYYmwLSmFiLLvWWcN', date: agendarProvider.date, hour:agendarProvider.horaSinFormato[0]  ); //agendarProvider.email, agendarProvider.date, agendarProvider.horaSinFormato[0]
                            });
                          } else {
                            NotificationServices.showSnackbarError('Formulario invalido', Colors.red);
                          }
                        },
                      ),
                    ),
                  const SizedBox(
                    height: 300,
                  )
                ],
              ),
            ),
          ]),
    );
  }
}

// class DialogsAlert {
//   static AlertDialog tdcPayDialog(BuildContext context) {

//     return AlertDialog(
//         actions: [
//           CustomButton(
//             text: 'PAGAR',
//             onPress: () {
//               redirectToCheckout();
//             },
//             width: 100,
//             color: Colors.green,
//           ),
//           CustomButton(
//             text: 'ATRAS',
//             onPress: () {
//               Navigator.of(context).pop();
//             },
//             width: 100,
//             color: azulText.withOpacity(0.4),
//           ),
//         ],
//         backgroundColor: bgColor,
//         title: Text(
//           'Pagar Asesoria 1:1',
//           style: GoogleFonts.roboto(color: blancoText, fontSize: 30),
//         ),
//         content: const ContentDialog());
//   }
// }

InputDecoration buildInputDecoration({required String label, required String hint, required IconData icon, IconData? suffIcon, Function? onPrs}) =>
    InputDecoration(
        fillColor: blancoText.withOpacity(0.03),
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: azulText),
        ),
        iconColor: Colors.white,
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: azulText.withOpacity(0.3))),
        labelText: label,
        hintText: hint,
        hintStyle: GoogleFonts.roboto(color: blancoText, fontSize: 14),
        labelStyle: GoogleFonts.roboto(color: blancoText, fontSize: 14),
        prefixIcon: Icon(icon, color: azulText.withOpacity(0.3)),
        suffixIconColor: azulText.withOpacity(0.3));

class ContentDialog extends StatefulWidget {
  const ContentDialog({super.key});

  @override
  State<ContentDialog> createState() => _ContentDialogState();
}

class _ContentDialogState extends State<ContentDialog> {
  @override
  Widget build(BuildContext context) {
    final targetaCreditoProvider = Provider.of<TargetaCreditoProvider>(context);
    return Scaffold(
        body: Container(
      height: 500,
      color: Colors.transparent,
      child: Column(
        children: [
          SizedBox(
              width: 300,
              height: 200,
              child: CreditCardWidget(
                isHolderNameVisible: true,
                cardNumber: targetaCreditoProvider.tdcnumero,
                expiryDate: targetaCreditoProvider.expire,
                cardHolderName: targetaCreditoProvider.titular,
                textStyle: GoogleFonts.inconsolata(color: bgColor),
                cvvCode: targetaCreditoProvider.cvv,
                showBackView: targetaCreditoProvider.backSide,
                onCreditCardWidgetChange: (p0) => {},
                isChipVisible: false,
                isSwipeGestureEnabled: false,
                // obscureCardCvv: true,
                cardBgColor: Colors.amber,
                obscureInitialCardNumber: true,
              )),
          const SizedBox(height: 15),
          TextFormField(
            onTap: () => targetaCreditoProvider.backSide = false,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => (value!.isNotEmpty || value.length < 12) ? null : 'Nombre invalido',
            initialValue: targetaCreditoProvider.titular,
            keyboardType: TextInputType.number,
            onChanged: (value) => {targetaCreditoProvider.titular = value}, // registerFormProvider.setNombre(value),
            style: GoogleFonts.roboto(color: blancoText, fontSize: 14),
            decoration: buildInputDecoration(icon: Icons.person, label: 'Nombre de la TDC', hint: 'John Doe'),
          ),
          const SizedBox(height: 15),
          TextFormField(
            onTap: () => targetaCreditoProvider.backSide = false,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => (value!.isNotEmpty || value.length < 12) ? null : 'Numero de TDC invalido',
            initialValue: targetaCreditoProvider.tdcnumero,
            keyboardType: TextInputType.number,
            onChanged: (value) => {targetaCreditoProvider.tdcnumero = value}, // registerFormProvider.setNombre(value),
            style: GoogleFonts.roboto(color: blancoText, fontSize: 14),
            decoration: buildInputDecoration(icon: Icons.credit_card_outlined, label: 'Numero de su TDC', hint: '4242424242424242'),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              SizedBox(
                width: 150,
                child: TextFormField(
                  onTap: () => targetaCreditoProvider.backSide = false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => (value!.isNotEmpty || value.length < 12) ? null : 'Fecha de Expiración invalida "MM/YY"',
                  initialValue: targetaCreditoProvider.expire,
                  onChanged: (value) => {targetaCreditoProvider.expire = value}, // registerFormProvider.setNombre(value),
                  style: GoogleFonts.roboto(color: blancoText, fontSize: 14),
                  decoration: buildInputDecoration(icon: Icons.date_range_rounded, label: 'Expira', hint: '00/00'),
                ),
              ),
              const SizedBox(width: 15),
              SizedBox(
                width: 150,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onTap: () => targetaCreditoProvider.backSide = true,

                  validator: (value) => (value!.isNotEmpty || value.length < 12) ? null : 'CCV Invalido "000"',
                  initialValue: targetaCreditoProvider.cvv,
                  onChanged: (value) => {targetaCreditoProvider.cvv = value}, // registerFormProvider.setNombre(value),
                  style: GoogleFonts.roboto(color: blancoText, fontSize: 14),
                  decoration: buildInputDecoration(icon: FontAwesomeIcons.creditCard, label: 'CVV', hint: '000'),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
