import 'package:flutter/material.dart';
import 'package:idepronet/src/models/ad_clasificador.dart';
import 'package:idepronet/src/models/credito_rechazado.dart';
import 'package:idepronet/src/models/response_api.dart';
import 'package:idepronet/src/models/user.dart';
import 'package:idepronet/src/provider/clasificador_provider.dart';
import 'package:idepronet/src/utils/my_snackbar.dart';
import 'package:idepronet/src/utils/shared_pref.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../../provider/negocios_provider.dart';

class CreditoRechazadoCreateController {

  BuildContext context;
  Function refresh;

  List<AdClasificador> adClasificadorCreditosSolicitadosList = [];
  List<AdClasificador> adClasificadorTipoPersonaList = [];
  List<AdClasificador> adClasificadorOficinasList = [];
  List<AdClasificador> adClasificadorGeneroList = [];
  List<AdClasificador> adClasificadorMotivoRechazoList = [];

  String selectedTipoCredito;
  String selectedTipoPersona;
  String selectedOficina;
  String selectedGenero;
  String selectedMotivoRechazo;



  String typeDocument = '';
  TextEditingController fechaSolicitudController = new TextEditingController();
  TextEditingController fechaRechazoController = new TextEditingController();
  TextEditingController fechaInicioController = new TextEditingController();
  TextEditingController codigoClienteController = new TextEditingController();
  TextEditingController motivoRechazoController = new TextEditingController();
  TextEditingController otroMotivoRechazoController = new TextEditingController();

  Map<String, dynamic> refPoint;

  NegociosProvider _negociosProvider = new NegociosProvider();
  ClasificadorProvider  _clasificadorProvider = new ClasificadorProvider();
  User user;
  SharedPref _sharedPref = new SharedPref();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    _negociosProvider.init(context, user);
    _clasificadorProvider.init(context, user);
     getTipoCredito();
     getTipoPersona();
     getOficina();
     getGenero();
     getMotivoRechazo();
  }

  void create() async {
    print(selectedTipoCredito);
    print(selectedOficina);
    print(selectedTipoPersona);

    String fechaSolicitud = fechaSolicitudController.text;
    String tipoCredito = selectedTipoCredito;
    String oficina = selectedOficina;
    String tipoPersona = selectedTipoPersona;
    String genero = selectedGenero;
    String fechaRechazo = fechaRechazoController.text;
    String fechaInicio = fechaInicioController.text;
    String motivoRechazo = selectedMotivoRechazo;
    String otroMotivoRechazo = otroMotivoRechazoController.text;
    String usuario = user.usuario;



    CreditoRechazado creditos = new CreditoRechazado(
        id: "0",
        fechaSolicitud: fechaSolicitud,
        creditoSolicitado: tipoCredito,
        agencia: oficina,
        tipoPersona: tipoPersona,
        genero: genero,
        fechaRechazo: fechaRechazo,
        fechaInicio: fechaInicio,
        motivoRechazo: motivoRechazo,
        otroMotivoRechazo: otroMotivoRechazo,
        usuario: usuario


    );

    print(creditos.genero);
    ResponseApi responseApi = await _negociosProvider.create(creditos);

    if (responseApi.estado) {
      creditos.id = responseApi.data;
     //// _sharedPref.save('credito rechazado', creditos);

      Fluttertoast.showToast(msg: 'Se registró con éxito');
      Navigator.pop(context, true);
    }
  }

  void getTipoCredito() async {
    adClasificadorCreditosSolicitadosList = await _clasificadorProvider.getTipoCreditosRechazados('8');

    adClasificadorCreditosSolicitadosList.forEach((document) {
      print('Tipo CRedito Resibido: ${document.toJson()}');
    });
    refresh();
  }

  void getTipoPersona() async {
    adClasificadorTipoPersonaList = await _clasificadorProvider.getTipoPersonas();

    adClasificadorTipoPersonaList.forEach((document) {
      print('TIPO PERSONA: ${document.toJson()}');
    });
    refresh();
  }

  void getGenero() async {
    adClasificadorGeneroList = await _clasificadorProvider.getGeneros();

    adClasificadorGeneroList.forEach((document) {
      print('GENERO: ${document.toJson()}');
    });
    refresh();
  }

  void getMotivoRechazo() async {
    adClasificadorMotivoRechazoList = await _clasificadorProvider.getTipoMotivoRechazos("9");

    adClasificadorMotivoRechazoList.forEach((document) {
      print('Documento: ${document.toJson()}');
    });
    refresh();
  }

  void getOficina() async {
    adClasificadorOficinasList = await _clasificadorProvider.getOficinas();

    adClasificadorOficinasList.forEach((document) {
      print('Lista de Oficinas: ${document.toJson()}');
    });
    refresh();
  }

  void getCreditoRechazado() async {
    adClasificadorMotivoRechazoList = await _clasificadorProvider.getTipoCreditosRechazados('8');

    adClasificadorMotivoRechazoList.forEach((document) {
      print('Documento: ${document.toJson()}');
    });
    refresh();
  }
// void openMap() async {
//   refPoint = await showMaterialModalBottomSheet(
//       context: context,
//       isDismissible: false,
//       enableDrag: false,
//       builder: (context) => CreditoRechazadoMapPage()
//   );
//
//   if (refPoint != null) {
//     refPointController.text = refPoint['address'];
//     refresh();
//   }
// }

}