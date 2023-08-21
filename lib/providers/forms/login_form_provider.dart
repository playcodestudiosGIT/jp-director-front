import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../all_cursos_provider.dart';
import '../auth_provider.dart';

class LoginFormProvider extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();

  String email = '';
  String pass = '';

  bool remember = false;

  bool obscureText = true;

  setEmail(String value) {
    email = value;
  }

  setPassword(String value) {
    pass = value;
  }

  setObscure() {
    obscureText = !obscureText;
    notifyListeners();
  }

  setRemember() {
    remember = !remember;
    notifyListeners();
  }

  void read() async {
    email = await _storage.read(key: "KEY_MAIL") ?? '';
    pass = await _storage.read(key: "KEY_PASS") ?? '';
    final rmmb = await _storage.read(key: "KEY_RMMB") ?? 'false';
    if (rmmb == 'true') {
      remember = true;
    }
    if (rmmb == 'false') {
      remember = false;
    }
    notifyListeners();
  }

  Future<bool> validateForm({required BuildContext context, required bool isValid}) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (isValid) {
      if (remember) {
        await _storage.write(key: "KEY_MAIL", value: email);
        await _storage.write(key: "KEY_PASS", value: pass);
        await _storage.write(key: "KEY_RMMB", value: remember.toString());

        notifyListeners();
      } else {
        await _storage.deleteAll();
      }
      await authProvider.login(email, pass);
      if (context.mounted) {
        await Provider.of<AllCursosProvider>(context, listen: false).getAllCursos();
      }
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}
