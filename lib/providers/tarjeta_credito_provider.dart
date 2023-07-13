import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';

class TargetaCreditoProvider extends ChangeNotifier {
  String _tdcnumero = '0000000000000000';
  String _titular = 'Jhon Doe';
  String _expire = '00/00';
  String _cvv = '000';
  int _monto = 250;

  bool _backSide = false;

  Map<String, dynamic> _paymentIntent = {};

  Map<String, dynamic> get paymentIntent => _paymentIntent;

  set paymentIntent(Map<String, dynamic> value) {
    _paymentIntent = value;
    notifyListeners();
  }

  String get tdcnumero => _tdcnumero;

  set tdcnumero(String value) {
    _tdcnumero = value;
    notifyListeners();
  }

  String get titular => _titular;

  set titular(String value) {
    _titular = value;
    notifyListeners();
  }

  String get expire => _expire;

  set expire(String value) {
    _expire = value;
    notifyListeners();
  }

  String get cvv => _cvv;

  set cvv(String value) {
    _cvv = value;
    notifyListeners();
  }

  int get monto => _monto;

  set monto(int value) {
    _monto = value;
    notifyListeners();
  }

  bool get backSide => _backSide;

  set backSide(bool value) {
    _backSide = value;
    notifyListeners();
  }
}
//   Future<void> payment() async {
//     final element;
    
//     //1.  Payment Intent
//     try {
//       Map<String, dynamic> body = {
//         'amount': 25000,
//         'currency': 'USD',
//       };

//       final response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {'Authorization': 'Bearer', 'Content-type': 'application/x-www-form-urlencoded'},
//       );
//       _paymentIntent = json.decode(response.body);
//     } catch (e) {
//       throw Exception(e);
//     }

//     // 2. Initialize payment sheet

//     // await Stripe.instance.ele

//     try {
//       await Stripe.instance
//         .initPaymentSheet(
//             paymentSheetParameters: SetupPaymentSheetParameters(
//                 paymentIntentClientSecret: paymentIntent['client_secret'], style: ThemeMode.dark, merchantDisplayName: 'Jp Director'))
//         .then((value) => {});
//     } catch (e) {
//       throw Exception(e);
//     }

//     //3. display payment sheet

//     try {
//       await Stripe.instance.presentPaymentSheet().then((value) => {
//       });
//     } catch (e) {
//       throw Exception(e);
//     }
//   }
// }
