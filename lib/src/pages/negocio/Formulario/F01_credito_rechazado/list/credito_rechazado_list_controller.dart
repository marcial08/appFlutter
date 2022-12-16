import 'package:flutter/material.dart';
import 'package:idepronet/src/models/address.dart';
import 'package:idepronet/src/models/credito_rechazado.dart';
import 'package:idepronet/src/models/user.dart';
import 'package:idepronet/src/provider/address_provider.dart';
import 'package:idepronet/src/provider/orders_provider.dart';
import 'package:idepronet/src/utils/shared_pref.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../models/response_api.dart';
import '../../../../../provider/negocios_provider.dart';

class CreditoRechazadoListController {

  BuildContext context;
  Function refresh;

  List<CreditoRechazado> creditoRechazadoList = [];
  AddressProvider _addressProvider = new AddressProvider();
  User user;
  SharedPref _sharedPref = new SharedPref();

  int radioValue = 0;

  bool isCreated;

  Map<String, dynamic> dataIsCreated;

  OrdersProvider _ordersProvider = new OrdersProvider();
  NegociosProvider _negociosProvider = new NegociosProvider();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
  //  _addressProvider.init(context, user);
    _ordersProvider.init(context, user);

    refresh();
  }

  void createOrder() async {
    // Address a = Address.fromJson(await _sharedPref.read('address') ?? {});
    // List<Product> selectedProducts = Product.fromJsonList(await _sharedPref.read('order')).toList;
    // Order order = new Order(
    //   idClient: user.id,
    //   idAddress: a.id,
    //   products: selectedProducts
    // );
    // ResponseApi responseApi = await _ordersProvider.create(order);
    Navigator.pushNamed(context, 'client/payments/create');
  }

  void deleteItem( CreditoRechazado creditoRechazado) async {
    print('DELETEEEEEEEEEEEEEEE');
    print(creditoRechazado.id);
    ResponseApi responseApi = await _negociosProvider.delete(creditoRechazado.id,user.sessionToken);

    if (responseApi.estado) {
      //// _sharedPref.save('credito rechazado', creditos);

      Fluttertoast.showToast(msg: 'Se elimino con éxito');
      Navigator.pop(context, creditoRechazadoList);
      creditoRechazadoList.removeWhere((p) => p.id == creditoRechazado.id);
      _sharedPref.save('order', creditoRechazadoList);
    }
    refresh();
  }
  void handleRadioValueChange(int value) async {
    radioValue = value;
    _sharedPref.save('address', creditoRechazadoList[value]);

    refresh();
    print('Valor seleccioonado: $radioValue');
  }

  Future<List<CreditoRechazado>> getCreditosRechazados() async {
    creditoRechazadoList = await _negociosProvider.getByUser(user.usuario,user.sessionToken);

    CreditoRechazado a = CreditoRechazado.fromJson(await _sharedPref.read('address') ?? {});
    int index = creditoRechazadoList.indexWhere((ad) => ad.id == a.id);

    if (index != -1) {
      radioValue = index;
    }
    print('LISTA OPERACIONES: ${a.toJson()}');

    return creditoRechazadoList;
  }

  void goToNewAddress() async {
    var result = await Navigator.pushNamed(context, 'negocio/formulario/F01_credito_rechazado/create');

    if (result != null) {
      if (result) {
        refresh();
      }
    }
  }

}