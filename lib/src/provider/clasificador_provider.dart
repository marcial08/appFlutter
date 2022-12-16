import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:idepronet/src/api/environment.dart';
import 'package:idepronet/src/models/ad_clasificador.dart';
import 'package:idepronet/src/models/mercado_pago_payment_method_installments.dart';
import 'package:idepronet/src/models/order.dart';
import 'package:idepronet/src/models/user.dart';
import 'package:idepronet/src/utils/shared_pref.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ClasificadorProvider {

  String _urlMercadoPago = 'api.mercadopago.com';
  String _url = Environment.API_IDEPRO;
  User sessionUser;

  final _mercadoPagoCredentials = Environment.mercadoPagoCredentials;

  BuildContext context;
  User user;

  Future init (BuildContext context, User user) {
    this.context = context;
    this.user = user;
  }



    Future<List<AdClasificador>> getTipoCreditosRechazados(String id) async {
      try {
        Uri url = Uri.http(_url, '/negocios/clasificadores/findByClasificador/${id}');
        Map<String, String> headers = {
          'Content-type': 'application/json',
          'Authorization': user.sessionToken
        };
        final res = await http.get(url, headers: headers);

        if (res.statusCode == 401) {
          Fluttertoast.showToast(msg: 'Sesion expirada');
          new SharedPref().logout(context, sessionUser.email);
        }
        final data = json.decode(res.body); // CATEGORIAS
        AdClasificador tipoCredito = AdClasificador.fromJsonList(data);
        return tipoCredito.AdClasificadorList;
      }
      catch(e) {
        print('Error: $e');
        return [];
      }
    }

  Future<List<AdClasificador>> getOficinas() async {
    try {
      Uri url = Uri.http(_url, '/negocios/clasificadores/findByClasificadorOficina');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': user.sessionToken
      };
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Sesion expirada');
        new SharedPref().logout(context, sessionUser.email);
      }
      final data = json.decode(res.body); // CATEGORIAS
      AdClasificador oficinas = AdClasificador.fromJsonList(data);
      return oficinas.AdClasificadorList;
    }
    catch(e) {
      print('Error: $e');
      return [];
    }
  }

  Future<List<AdClasificador>> getTipoPersonas() async {
    try {
      Uri url = Uri.http(_url, '/negocios/clasificadores/findByClasificadorTipoPersona');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': user.sessionToken
      };
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Sesion expirada');
        new SharedPref().logout(context, sessionUser.email);
      }
      final data = json.decode(res.body); // CATEGORIAS
      AdClasificador oficinas = AdClasificador.fromJsonList(data);
      return oficinas.AdClasificadorList;
    }
    catch(e) {
      print('Error: $e');
      return [];
    }
  }

  Future<List<AdClasificador>> getGeneros() async {
    try {
      Uri url = Uri.http(_url, '/negocios/clasificadores/findByClasificadorGenero');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': user.sessionToken
      };
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Sesion expirada');
        new SharedPref().logout(context, sessionUser.email);
      }
      final data = json.decode(res.body); // CATEGORIAS
      AdClasificador genero = AdClasificador.fromJsonList(data);
      return genero.AdClasificadorList;
    }
    catch(e) {
      print('Error: $e');
      return [];
    }
  }

  Future<List<AdClasificador>> getTipoMotivoRechazos(String id) async {
    try {
      Uri url = Uri.http(_url, '/negocios/clasificadores/findByClasificadorPrefijo/${id}');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': user.sessionToken
      };
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Sesion expirada');
        new SharedPref().logout(context, sessionUser.email);
      }
      final data = json.decode(res.body); // CATEGORIAS
      AdClasificador tipoCredito = AdClasificador.fromJsonList(data);
      return tipoCredito.AdClasificadorList;
    }
    catch(e) {
      print('Error: $e');
      return [];
    }
  }

  Future<Response> createPayment({
    @required String cardId,
    @required double transactionAmount,
    @required int installments,
    @required String paymentMethodId,
    @required String paymentTypeId,
    @required String issuerId,
    @required String emailCustomer,
    @required String cardToken,
    @required String identificationType,
    @required String identificationNumber,
    @required Order order,
  }) async {

    try {

      final url = Uri.http(_url, '/api/payments/createPay');

      Map<String, dynamic> body = {
        'order': order,
        'card_id': cardId,
        'description': 'Flutter Delivery Udemy',
        'transaction_amount': transactionAmount,
        'installments': installments,
        'payment_method_id': paymentMethodId,
        'payment_type_id': paymentTypeId,
        'token': cardToken,
        'issuer_id': issuerId,
        'payer': {
          'email': emailCustomer,
          'identification': {
            'type': identificationType,
            'number': identificationNumber,
          }
        }
      };

      print('PARAMS: ${body}');

      String bodyParams = json.encode(body);

      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': user.sessionToken
      };

      final res = await http.post(url, headers: headers, body: bodyParams);

      if (res.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Sesion expirada');
        new SharedPref().logout(context, user.nombre);
        return null;
      }

      return res;

    } catch(e) {

      print('Error: $e');
      return null;
    }
  }

  Future<MercadoPagoPaymentMethodInstallments> getInstallments(String bin, double amount) async {

    try {
      final url = Uri.https(_urlMercadoPago, '/v1/payment_methods/installments', {
        'access_token': _mercadoPagoCredentials.accessToken,
        'bin': bin,
        'amount': '${amount}'
      });

      final res = await http.get(url);
      final data = json.decode(res.body);
      print('DATA INSTALLMENTS: $data');

      final result = new MercadoPagoPaymentMethodInstallments.fromJsonList(data);

      return result.installmentList.first;
    } catch(e) {
      print('Error: $e');
      return null;
    }

  }

  Future<http.Response> createCardToken({
    String cvv,
    String expirationYear,
    int expirationMonth,
    String cardNumber,
    String documentNumber,
    String documentId,
    String cardHolderName,
  }) async {
    try {

      final url = Uri.https(_urlMercadoPago, '/v1/card_tokens', {
        'public_key': _mercadoPagoCredentials.publicKey
      });

      final body = {
        'security_code': cvv,
        'expiration_year': expirationYear,
        'expiration_month': expirationMonth,
        'card_number': cardNumber,
        'cardholder': {
          'identification' : {
            'number': documentNumber,
            'type': documentId,
          },
          'name': cardHolderName
        },
      };

      final res = await http.post(url, body: json.encode(body));

      return res;

    } catch(e) {
      print('Error: $e');
      return null;
    }

  }


}