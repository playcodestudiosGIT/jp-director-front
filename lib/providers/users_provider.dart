import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jp_director/api/jp_api.dart';

import '../models/curso.dart';
import '../models/http/all_users_response.dart';
import '../models/http/auth_response.dart';
import '../models/usuario_model.dart';

class UsersProvider extends ChangeNotifier {
  List<Usuario> users = [];
  int total = 0;
  bool isLoading = false;

  List<Curso> cursos = [];

  setUsers(newUsers) {
    users = newUsers;
    notifyListeners();
  }

  // -------------- FUNCIONES ----------------//

  getPaginatedUsers() async {
    isLoading = true;
    final resp = await JpApi.httpGet('/usuarios');

    final userResponse = AllUsuariosResp.fromJson(resp);

    users = userResponse.usuarios;
    total = userResponse.total;

    isLoading = false;

    notifyListeners();
  }

  createUser(String? nombre, String? apellido, String? email, String? password,
      String? rol, bool? estado) {
    final data = {
      "nombre": nombre,
      "apellido": apellido,
      "correo": email,
      "password": email,
      "rol": rol,
      "estado": estado
    };

    // Petición HTTP
    JpApi.post('/usuarios', data).then((json) {
      final authResponse = AuthResponse.fromJson(json);
      users.add(authResponse.usuario);
      notifyListeners();
    }).catchError((e) {
      // 
    });
  }

  Future updateUser(
      {String? pass,
      String? uid,
      String? nombre,
      String? apellido,
      String? correo,
      String? rol,
      String? telf,
      String? me,
      String? instagram,
      String? facebook,
      String? tiktok,
      bool? estado,
      DateTime? updatedAt}) async {
    final data = {
      "nombre": nombre,
      "apellido": apellido,
      "correo": correo,
      "password": pass,
      "telf": telf,
      "me": me,
      "instagram": instagram,
      "facebook": facebook,
      "tiktok": tiktok,
      "estado": estado,
      "updatedAt": DateTime.now()
    };

    try {
      await JpApi.put('/usuarios/$uid', data);

      // await getPaginatedUsers();
    } catch (e) {
      throw Exception('Error en el update user  $e');
    }
  }

  Future deleteUser(String id) async {
    try {
      await JpApi.delete('/usuarios/$id', {});

      users.removeWhere(
        (user) => user.uid == id,
      );

      notifyListeners();
      return true;
    } catch (e) {
      throw Exception('Error en el delete user  $e');
    }
  }

  Future updateImage(String id, file) async {
    final user = await JpApi.editUserImg('/uploads/usuarios/$id', file.bytes!);

    final Usuario newUser = Usuario.fromJson(jsonDecode(user.toString()));

    users = users.map((u) {
      if (u.uid != id) return u;
      u.img = newUser.img;
      return u;
    }).toList();
    notifyListeners();
  }
}
