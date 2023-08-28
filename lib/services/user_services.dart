import 'package:flutter/material.dart';
import 'package:jp_director/providers/users_provider.dart';
import 'package:provider/provider.dart';

import '../models/usuario_model.dart';

class UserServices {
  static Usuario? getUserInfo(BuildContext context, userId) {

    final usersProvider = Provider.of<UsersProvider>(context);

    Usuario? usuario = usersProvider.users.where((element) => element.uid == userId).firstOrNull;

    if (usuario != null) {
      return usuario;
    } else {
      return null;
    }
  }

  
}
