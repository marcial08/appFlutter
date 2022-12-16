import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:idepronet/src/models/address.dart';
import 'package:idepronet/src/models/credito_rechazado.dart';
import 'package:idepronet/src/pages/negocio/Formulario/F01_credito_rechazado/list/credito_rechazado_list_controller.dart';
import 'package:idepronet/src/utils/my_colors.dart';
import 'package:idepronet/src/widgets/no_data_widget.dart';

class CreditoRechazadoListPage extends StatefulWidget {
  const CreditoRechazadoListPage({Key key}) : super(key: key);

  @override
  _CreditoRechazadoListPageState createState() => _CreditoRechazadoListPageState();
}

class _CreditoRechazadoListPageState extends State<CreditoRechazadoListPage> {

  CreditoRechazadoListController _con = new CreditoRechazadoListController();

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
        title: Text('F-01 CRED. RECHAZADOS'),
        backgroundColor: MyColors.primaryColor,
        actions: [
          _iconAdd()
        ],
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.deepPurple, // Navigation bar
          statusBarColor: Colors.deepPurple, // Status bar
        ),
      ),
      body: Stack(
        children: [
          Positioned(
              top: 0,
              child: _textSelectAddress()
          ),
          Container(
              margin: EdgeInsets.only(top: 50),
              child: _listAddress()
          )
        ],
      ),
      //bottomNavigationBar: _buttonAccept(),
    );
  }

  Widget _noAddress() {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: 30),
            child: NoDataWidget(text: 'No tienes ningun registro, agrega una nueva')
        ),
        _buttonNewAddress()
      ],
    );
  }

  Widget _buttonNewAddress() {
    return Container(
      height: 40,
      child: ElevatedButton(
        onPressed: _con.goToNewAddress,
        child: Text(
            'AGREGAR'
        ),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor
        ),
      ),
    );
  }

  // Widget _buttonAccept() {
  //   return Container(
  //     height: 50,
  //     width: double.infinity,
  //     margin: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
  //     child: ElevatedButton(
  //       onPressed: _con.createOrder,
  //       child: Text(
  //         'ACEPTAR'
  //       ),
  //       style: ElevatedButton.styleFrom(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(30)
  //         ),
  //         primary: MyColors.primaryColor
  //       ),
  //     ),
  //   );
  // }

  Widget _listAddress() {
    return FutureBuilder(
        future: _con.getCreditosRechazados(),
        builder: (context, AsyncSnapshot<List<CreditoRechazado>> snapshot) {

          if (snapshot.hasData) {

            if (snapshot.data.length > 0) {
              return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (_, index) {
                    return _radioSelectorAddress(context, snapshot.data[index], index);
                  }
              );
            }
            else {
              return _noAddress();
            }
          }
          else {
            return _noAddress();
          }
        }
    );
  }

  Widget _radioSelectorAddress(context, CreditoRechazado creditoRechazado, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              // Radio(
              //   value: index,
              //   groupValue: _con.radioValue,
              //   onChanged: _con.handleRadioValueChange,
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    creditoRechazado?.otroMotivoRechazo ?? '',
                    style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                   'Fecha solicitud: '+ creditoRechazado?.fechaSolicitud ?? '',
                    style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    'Fecha Rechazo: '+ creditoRechazado?.fechaSolicitud ?? '',
                    style: TextStyle(
                      fontSize: 9,
                    ),
                  )
                ],
              ),

              Spacer(),
              Column(
                children: [
                  //DialogAlert(context, creditoRechazado)
                  //_iconDelete(context,creditoRechazado)
                  _iconDeletee(creditoRechazado)
                ],
              )
            ],
          ),
          Divider(
            color: Colors.grey[400],
          )
        ],
      ),
    );
  }

  Widget _iconDelete(BuildContext context, CreditoRechazado creditoRechazado) {
    return IconButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('¿Está seguro de eliminar?'),
            content: const Text('La fecha de solicitud de esta operaciones es y fue rechazado motivo de rechazo es'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => _con.deleteItem(creditoRechazado),
                child: const Text('Confirmar'),
              ),
            ],
          ),

        ),
        icon: Icon(Icons.delete, color: MyColors.primaryColor)
    );
  }


  Widget _iconDeletee(CreditoRechazado creditoRechazado) {
    return IconButton(
        onPressed: () {
          _con.deleteItem(creditoRechazado);
        },
        icon: Icon(Icons.delete, color: MyColors.primaryColor,)
    );
  }



  Widget DialogAlert(BuildContext context, CreditoRechazado creditoRechazado) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const Text('AlertDialog description'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }

  Widget _textSelectAddress() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Text(
        'Lista de operaciones',
        style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _iconAdd() {
    return IconButton(
        onPressed: _con.goToNewAddress,
        icon: Icon(Icons.add, color: Colors.white)
    );
  }

  void refresh() {
    setState(() {});
  }
}
