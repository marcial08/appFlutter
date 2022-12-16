import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:idepronet/src/pages/login/updateUser/user_update_controller.dart';
import 'package:idepronet/src/utils/my_colors.dart';

class UserUpdatePage extends StatefulWidget {
  const UserUpdatePage({Key key}) : super(key: key);

  @override
  _UserUpdatePageState createState() => _UserUpdatePageState();
}

class _UserUpdatePageState extends State<UserUpdatePage> {

  UserUpdateController _con = new UserUpdateController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis datos'),
        backgroundColor: MyColors.primaryColor,
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              _imageUser(),
              SizedBox(height: 30),
              _textFieldNombre(),
              _textFieldEmail(),
              //_textFieldDocumentoIdentidad(),
              _textFieldCargo(),
              _textFieldOficina(),
              //_textFieldTelefono(),
              _textFieldUsuario(),
              _textFieldRol(),
            ],
          ),
        )
      ),
     // bottomNavigationBar: _buttonLogin(),
    );
  }

  Widget _imageUser() {
    return GestureDetector(
      onTap: _con.showAlertDialog,
      child: CircleAvatar(
        // backgroundImage: _con.imageFile != null
        //     ? FileImage(_con.imageFile)
        //     : _con.user?.nombre != null
        //       ? NetworkImage(_con.user?.nombre)
        //       : AssetImage('assets/img/user_profile_2.png'),

        backgroundImage:
         AssetImage('assets/img/user_profile_2.png'),
        radius: 60,
        backgroundColor: Colors.grey[200],
      ),
    );
  }

  Widget _textFieldNombre() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.nombreController,
        decoration: InputDecoration(
            hintText: 'Nombre',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            enabled: false,
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark
            ),
            prefixIcon: Icon(
              Icons.person,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.emailController,
        decoration: InputDecoration(
            hintText: 'Correo',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            enabled: false,
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark
            ),
            prefixIcon: Icon(
              Icons.email,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }

  Widget _textFieldDocumentoIdentidad() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.documentoIdentidadController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'C.I.',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            enabled: false,
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark
            ),
            prefixIcon: Icon(
              Icons.fingerprint,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }

  Widget _textFieldCargo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.cargoController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'Cargo',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            enabled: false,
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark
            ),
            prefixIcon: Icon(
              Icons.recent_actors,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }

  Widget _textFieldOficina() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.oficinaController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'Oficina',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            enabled: false,
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark
            ),
            prefixIcon: Icon(
              Icons.home,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }

  Widget _textFieldTelefono() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.telefonoController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'Telefono',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            enabled: false,
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark
            ),
            prefixIcon: Icon(
              Icons.phone,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }

  Widget _textFieldUsuario() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.usuarioController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'Usuario',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            enabled: false,
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark
            ),
            prefixIcon: Icon(
              Icons.vpn_key,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }

  Widget _textFieldRol() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.rolesController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'rol',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            enabled: false,
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark
            ),
            prefixIcon: Icon(
              Icons.security,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }


  void refresh() {
    setState(() {

    });
  }
}
