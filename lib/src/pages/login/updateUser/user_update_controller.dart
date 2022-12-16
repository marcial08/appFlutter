import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:idepronet/src/models/user.dart';
import 'package:idepronet/src/provider/users_provider.dart';
import 'package:idepronet/src/utils/shared_pref.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class UserUpdateController {

  BuildContext context;
  TextEditingController nombreController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController documentoIdentidadController = new TextEditingController();
  TextEditingController cargoController = new TextEditingController();
  TextEditingController oficinaController = new TextEditingController();
  TextEditingController telefonoController = new TextEditingController();
  TextEditingController usuarioController = new TextEditingController();
  TextEditingController rolesController = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();

  PickedFile pickedFile;
  File imageFile;
  Function refresh;

  ProgressDialog _progressDialog;

  bool isEnable = true;
  User user;
  SharedPref _sharedPref = new SharedPref();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    _progressDialog = ProgressDialog(context: context);
    user = User.fromJson(await _sharedPref.read('user'));

    print('TOKEN ENVIADO: ${user.sessionToken}');
    usersProvider.init(context, sessionUser: user);

    nombreController.text = user.nombre;
    emailController.text = user.email;
    documentoIdentidadController.text = user.documentoIdentidad;
    cargoController.text = user.cargo;
    oficinaController.text = user.oficina;
    telefonoController.text = user.telefono;
    usuarioController.text = user.usuario;
    rolesController.text = user.roles;

    refresh();
  }

  // void update() async {
  //   String name = nameController.text;
  //   String lastname = lastnameController.text;
  //   String phone = phoneController.text.trim();
  //
  //   if (name.isEmpty || lastname.isEmpty || phone.isEmpty) {
  //     MySnackbar.show(context, 'Debes ingresar todos los campos');
  //     return;
  //   }
  //
  //   _progressDialog.show(max: 100, msg: 'Espere un momento...');
  //   isEnable = false;
  //
  //   User myUser = new User(
  //
  //       nombre: name,
  //       email: user.email,
  //       cargo: user.cargo,
  //       oficina: user.oficina
  //   );
  //
  //   Stream stream = await usersProvider.update(myUser, imageFile);
  //   stream.listen((res) async {
  //
  //     _progressDialog.close();
  //
  //     // ResponseApi responseApi = await usersProvider.create(user);
  //     ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
  //     Fluttertoast.showToast(msg: responseApi.message);
  //
  //     if (responseApi.success) {
  //       user = await usersProvider.getById('1'); // OBTENIENDO EL USUARIO DE LA DB
  //       print('Usuario obtenido: ${user.toJson()}');
  //       _sharedPref.save('user', user.toJson());
  //       Navigator.pushNamedAndRemoveUntil(context, 'client/products/list', (route) => false);
  //     }
  //     else {
  //       isEnable = true;
  //     }
  //   });
  // }

  Future selectImage(ImageSource imageSource) async {
    pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    Navigator.pop(context);
    refresh();
  }

  void showAlertDialog() {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.gallery);
        },
        child: Text('GALERIA')
    );

    Widget cameraButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.camera);
        },
        child: Text('CAMARA')
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona tu imagen'),
      actions: [
        galleryButton,
        cameraButton
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        }
    );
  }

  void back() {
    Navigator.pop(context);
  }


}