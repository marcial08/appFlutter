import 'package:flutter/material.dart';
import 'package:idepronet/src/models/response_api.dart';
import 'package:idepronet/src/models/user.dart';

import 'package:idepronet/src/provider/users_provider.dart';
import 'package:idepronet/src/utils/my_snackbar.dart';
import 'package:idepronet/src/utils/shared_pref.dart';

class LoginController {

  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  String nombre = '';
  String cargo= '';
  UsersProvider usersProvider = new UsersProvider();
  //PushNotificationsProvider pushNotificationsProvider = new PushNotificationsProvider();
  SharedPref _sharedPref = new SharedPref();

  Future init(BuildContext context) async {
    this.context = context;
    await usersProvider.init(context);

    User user = User.fromJson(await _sharedPref.read('user') ?? {});

    print('Usuario: ${user.toJson()}');

    if (user?.sessionToken != null) {
      if (user.roles== 'OFN') {
        Navigator.pushNamedAndRemoveUntil(context, 'home/inicio', (route) => false);
      }
      else {
        Navigator.pushNamedAndRemoveUntil(
            context, user.roles, (route) => false);
      }
    }
  }

  void goToRegisterPage() {
    //Navigator.pushNamed(context, 'register');
  }

  void login() async {
    String username = emailController.text.trim();
    String password = passwordController.text.trim();
    ResponseApi responseApi = await usersProvider.login(username, password);


    if(responseApi != null){
      print('Respuesta object: ${responseApi}');
      print('Respuesta: ${responseApi.toJson()}');
      if (responseApi.estado) {
        User user = User.fromJson(responseApi.data);
        _sharedPref.save('user', user.toJson());
        nombre = user.nombre;
        cargo = user.cargo;
        //   pushNotificationsProvider.saveToken(user.id);

        print('USUARIO LOGEADO: ${user.toJson()}');
        if (user.roles == "OFN") {
          Navigator.pushNamedAndRemoveUntil(context, 'home/inicio', (route) => false);
        }
        else {
          Navigator.pushNamedAndRemoveUntil(
              context, user.roles, (route) => false);
        }
      }
      else {
        MySnackbar.show(context, responseApi.message);
      }
    }else{
      MySnackbar.show(context, 'Verifique su conexion por (VPN)');
    }

  }

}