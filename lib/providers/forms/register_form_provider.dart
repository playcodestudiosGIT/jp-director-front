import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> registerKey = GlobalKey<FormState>(debugLabel: 'register');

  String email = '';
  String nombre = '';
  String apellido = '';
  String password1 = '';
  String password2 = '';
  bool remember = false;

  setEmail(value) {
    email = value;
    ChangeNotifier();
  }

  setNombre(value) {
    nombre = value;
    ChangeNotifier();
  }

  setApellido(value) {
    apellido = value;
    ChangeNotifier();
  }

  setPassword1(value) {
    password1 = value;
    ChangeNotifier();
  }

  setPassword2(value) {
    password2 = value;
    ChangeNotifier();
  }

  setRemember() {
    remember = !remember;
  }

  validateForm() {
    if (registerKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
