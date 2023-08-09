import 'dart:convert';
import 'package:jpdirector_frontend/services/notificacion_service.dart';
import 'package:universal_html/html.dart' as html;

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';

import '../../api/backend_google.dart';
import '../../checkout/stripe_checkout_class.dart';
import '../../models/http/horas_response.dart';

class AgendarProvider extends ChangeNotifier {
  CarouselController carrouselScrollController = CarouselController();

  GlobalKey<FormState> keyForm = GlobalKey<FormState>(debugLabel: 'Agenda');

  final List<String> _pages = ['agendar', 'pagar', 'gracias'];
  int _currentIndex = 0;

  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  List fechas = [];
  List<List<DateTime>>? horasDispo = [];
  String horaSeleccionada = '0';
  List<DateTime> horaSinFormato = [];

  bool isBuscando = false;

  disposeKey() {
    keyForm.currentState!.reset();
  }

  setIsBuscando() {
    isBuscando = !isBuscando;
    notifyListeners();
  }

  List<DateTime> reserveHour = [];

  setHoraSelec(String value) {
    horaSeleccionada = value;
    reserveHour = horasDispo![int.parse(value)];
    notifyListeners();
  }

  setHoraSinFormato(String value) {
    horaSinFormato = horasDispo![int.parse(value)];

    notifyListeners();
  }

  String nombre = '';
  String telefono = '';
  String email = '';
  String tdcName = '';
  String tdcNumber = '';
  String tdcCvc = '';
  String vence = '';

  setCurrentIndex(index) {
    _currentIndex = index;
  }

  int getPageIndex() {
    return _currentIndex;
  }

  goTo(int index) {
    // final routeName = _pages[index];
    html.window.history.pushState(null, 'none', '#/${_pages[index]}');

    carrouselScrollController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  Future<void> getAvailableHours(String yyyy, String mm, String dd) async {
    try {
      setIsBuscando();
      final resp = await BackendGoogle.httpGet('/apis/v1/calendar/geteventsbydate?date=$yyyy-$mm-$dd');
      final listHoras = HorasDisponiblesResponse.fromMap(jsonDecode(resp.toString())); // FROMMAP JSONDECODE METHOD
      horasDispo = listHoras.availablehours;
      horaSinFormato = horasDispo![0];
      isBuscando = false;
      setIsBuscando();
    } catch (e) {
      throw Exception('e');
    }
    notifyListeners();
  }

  Future<void> redirectToCheckout({required String email, required String priceId, required DateTime date, required DateTime hour}) async {
    String stripeKey = 'pk_test_51KVpnfCVYYmwLSmF5F3u2GP0PT2z8kOKpa0U8zpSmJWJl9L4hNAM7AIIGlfWQvDCSt2eyYO55woGYOjopphL2dR800d3RftdHh';
    String successUrl =
        'https://jpdirector.herokuapp.com/#/checkout/success/$email/${date.year}-${date.month}-${date.day}--${hour.hour}';

    final stripe = Stripe(stripeKey);
    try {
      await stripe.redirectToCheckout(CheckoutOptions(
          lineItems: [LineItem(price: priceId, quantity: 1)],
          mode: 'payment', // buscar funcionamiento del modo
          successUrl: successUrl,
          cancelUrl: 'https://jpdirector.herokuapp.com/#/form/agendar'));
    } catch (e) {
      NotifServ.showSnackbarError('Formulario invalido', Colors.red);
    }
  }

  Future<void> createAgenda({required String dateAgendar, required String email}) async {
    final horafin = int.parse(dateAgendar.substring(dateAgendar.length - 2, dateAgendar.length)) + 1;

    final data = {
      "email": email,
      "meetingrank": [
        "${dateAgendar.substring(0, dateAgendar.length - 4)}T${dateAgendar.substring(dateAgendar.length - 2, dateAgendar.length)}:00:00",
        "${dateAgendar.substring(0, dateAgendar.length - 4)}T${horafin.toString()}:00:00"
      ]
    };
    try {
      await BackendGoogle.post('/apis/v1/calendar/createmeet', data);
      notifyListeners();
    } catch (e) {
      throw Exception('e');
    }
  }
}
