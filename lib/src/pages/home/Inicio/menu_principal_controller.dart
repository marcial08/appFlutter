import 'dart:async';

import 'package:flutter/material.dart';
import 'package:idepronet/src/models/category.dart';
import 'package:idepronet/src/models/product.dart';
import 'package:idepronet/src/models/user.dart';
import 'package:idepronet/src/provider/categories_provider.dart';
import 'package:idepronet/src/provider/products_provider.dart';
import 'package:idepronet/src/utils/shared_pref.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MenuPrincipalPageController {

  BuildContext context;
  SharedPref _sharedPref = new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Function refresh;
  User user;
  CategoriesProvider _categoriesProvider = new CategoriesProvider();
  ProductsProvider _productsProvider = new ProductsProvider();
  List<Category> categories = [];
  StreamController<String> streamController = StreamController();
  // TextEditingController _searchController = new TextEditingController();

  Timer searchOnStoppedTyping;

  String productName = '';

  //PushNotificationsProvider pushNotificationsProvider = new PushNotificationsProvider();



  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
   // _categoriesProvider.init(context, user);
  //  _productsProvider.init(context, user);


    getCategories();
    refresh();
  }

  void onChangeText(String text) {
    const duration = Duration(milliseconds:800); // set the duration that you want call search() after that.
    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping.cancel();
      refresh();
    }

    searchOnStoppedTyping = new Timer(duration, () {
      productName = text;
      refresh();
      // getProducts(idCategory, text)
      print('TEXTO COMPLETO $text');
    });
  }

  Future<List<Product>> getProducts(String idCategory, String productName) async {
    if (productName.isEmpty) {
      return await _productsProvider.getByCategory(idCategory);
    }
    else {
      return await _productsProvider.getByCategoryAndProductName(idCategory, productName);
    }
  }

  void getCategories() async {
    categories = await _categoriesProvider.getAll();
    refresh();
  }

  void openBottomSheet(Product product) {
    showMaterialModalBottomSheet(
        context: context,
       // builder: (context) => ClientProductsDetailPage(product: product)
    );
  }

  void logout() {
    _sharedPref.logout(context, user.id);
  }

  void openDrawer() {
    key.currentState.openDrawer();
  }

  void goToUpdatePage() {
    Navigator.pushNamed(context, 'login/updateUser');
  }

  void goToNegocioPage() {
    Navigator.pushNamed(context, 'negocio/formulario/F01_credito_rechazado/list');
  }

  void goToOrdersList() {
    Navigator.pushNamed(context, 'negocio/formulario/F01_credito_rechazado/list');
  }

  void goToOrderCreatePage() {
    Navigator.pushNamed(context, 'client/orders/create');
  }

  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }

}