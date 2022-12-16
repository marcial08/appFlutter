import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:idepronet/src/models/ad_clasificador.dart';
import 'package:idepronet/src/pages/negocio/Formulario/F01_credito_rechazado/create/credito_rechazado_create_controler.dart';
import 'package:idepronet/src/utils/my_colors.dart';
import 'package:intl/intl.dart';

class CreditoRechazadoCreatePage extends StatefulWidget {
  const CreditoRechazadoCreatePage({Key key}) : super(key: key);

  @override
  _CreditoRechazadoCreatePageState createState() => _CreditoRechazadoCreatePageState();
}

class _CreditoRechazadoCreatePageState extends State<CreditoRechazadoCreatePage> {

  CreditoRechazadoCreateController _con = new CreditoRechazadoCreateController();
  final _formKey = GlobalKey<FormState>();
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
     // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Nuevo Registro F-01'),
        backgroundColor: MyColors.primaryColor,
      ),
      bottomNavigationBar: _buttonAccept(),
      body: Container(
            child:  Form(
              key: _formKey,
              child: SingleChildScrollView(
              child: Column(
                children: [
                  _fechaSolicitud(),
                  _tipoCredito(),
                  _ListOficina(),
                  _tipoPersona(),
                  _genero(),
                  _fechaRechazo(),
                  _fechaInicio(),
                  _motivoRechazo(),
                  _otroMotivoRechazo(),
                  _textCompleteData()
                ],
              ),
            ),
        ),
      ),
    );
  }

  Widget _fechaSolicitud() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextFormField(
        controller: _con.fechaSolicitudController,
        validator: (value) {
          if (value.isEmpty) {
            return 'Fecha de solicitud requerido.';
          }else{
            if (!isDate(value, "dd/MM/yyyy")) {
              return 'Fecha invalida.';
            }
          }
          return null;
        },
        onTap: () async {
          DateTime pickerDate=await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2022), lastDate: DateTime(2025)) ;
          if(pickerDate!=null){
            String formattedDate = DateFormat("dd/MM/yyyy").format(pickerDate);
            setState(() {
              _con.fechaSolicitudController.text=formattedDate.toString();
            });
          }else{
            print("no selesct fecha");
          }
        },
//         autofocus: false,
//         focusNode: AlwaysDisabledFocusNode(),
        decoration: InputDecoration(
            labelText: 'Fecha de solicitud',
            suffixIcon: Icon(
              Icons.date_range_sharp,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }

  Widget _tipoCredito() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Material(
              elevation: 2.0,
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 7),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: DropdownButtonFormField(
                        icon: Icon(
                          Icons.arrow_drop_down_circle,
                          color: MyColors.primaryColor,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyColors.primaryColor),

                          ),
                        ),
                        elevation: 3,
                        isExpanded: true,
                        hint: Text(
                          'Tipo de crédito solicitado',
                          style: TextStyle(
                              color: MyColors.primaryColor,
                              fontSize: 14
                          ),
                        ),
                        items: _dropDownItems(_con.adClasificadorCreditosSolicitadosList),
                        // items: dropdownItems,
                        value: _con.selectedTipoCredito,
                        //value: selectedValue,
                        validator: (value) => value == null ? 'Tipo de crédito solicitado requerido.' : null,
                        onChanged: (option) {
                          setState(() {
                            print('LIST OFICINA $option');
                            _con.selectedTipoCredito = option; // ESTABLECIENDO EL VALOR SELECCIONADO
                            //selectedValue = option; // ESTABLECIENDO EL VALOR SELECCIONADO
                          });
                        },

                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
    );
  }

  Widget _ListOficina() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Material(
              elevation: 2.0,
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 7),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: DropdownButtonFormField(
                        icon: Icon(
                          Icons.arrow_drop_down_circle,
                          color: MyColors.primaryColor,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyColors.primaryColor),

                          ),
                        ),
                        elevation: 3,
                        isExpanded: true,
                        hint: Text(
                          'Oficina',
                          style: TextStyle(
                              color: MyColors.primaryColor,
                              fontSize: 14
                          ),
                        ),
                        items: _dropDownItems(_con.adClasificadorOficinasList),
                        // items: dropdownItems,
                        value: _con.selectedOficina,
                        //value: selectedValue,
                        validator: (value) => value == null ? 'Oficina es requerido.' : null,
                        onChanged: (option) {
                          setState(() {
                            print('LIST OFICINA $option');
                            _con.selectedOficina = option; // ESTABLECIENDO EL VALOR SELECCIONADO
                            //selectedValue = option; // ESTABLECIENDO EL VALOR SELECCIONADO
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
    );
  }

  Widget _tipoPersona() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Material(
              elevation: 2.0,
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 7),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: DropdownButtonFormField(
                        icon: Icon(
                          Icons.arrow_drop_down_circle,
                          color: MyColors.primaryColor,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyColors.primaryColor),

                          ),
                        ),
                        elevation: 3,
                        isExpanded: true,
                        hint: Text(
                          'Tipo persona',
                          style: TextStyle(
                              color: MyColors.primaryColor,
                              fontSize: 14
                          ),
                        ),
                        items: _dropDownItems(_con.adClasificadorTipoPersonaList),
                        // items: dropdownItems,
                        value: _con.selectedTipoPersona,
                        validator: (value) => value == null ? 'Tipo persona es requerido.' : null,
                        //value: selectedValue,
                        onChanged: (option) {
                          setState(() {
                            print('Tipo Persona de credito selecciondo $option');
                            _con.selectedTipoPersona = option; // ESTABLECIENDO EL VALOR SELECCIONADO
                            //selectedValue = option; // ESTABLECIENDO EL VALOR SELECCIONADO
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
    );
  }

  Widget _genero() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Material(
              elevation: 2.0,
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 7),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: DropdownButtonFormField(
                        icon: Icon(
                          Icons.arrow_drop_down_circle,
                          color: MyColors.primaryColor,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyColors.primaryColor),

                          ),
                        ),
                        elevation: 3,
                        isExpanded: true,
                        hint: Text(
                          'Genero',
                          style: TextStyle(
                              color: MyColors.primaryColor,
                              fontSize: 14
                          ),
                        ),
                        items: _dropDownItems(_con.adClasificadorGeneroList),
                        // items: dropdownItems,
                        value: _con.selectedGenero,
                        //value: selectedValue,
                        validator: (value) => value == null ? 'Genero es requerido.' : null,
                        onChanged: (option) {
                          setState(() {
                            print('Reparidor selecciondo $option');
                            _con.selectedGenero = option; // ESTABLECIENDO EL VALOR SELECCIONADO
                            //selectedValue = option; // ESTABLECIENDO EL VALOR SELECCIONADO
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
    );
  }

  Widget _fechaRechazo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextFormField(
        controller: _con.fechaRechazoController,
        validator: (value) {
          if (value.isEmpty) {
            return 'Fecha de rechazo requerido.';
          }
          return null;
        },
        onTap: () async {
          DateTime pickerDate=await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2022), lastDate: DateTime(2025)) ;
          if(pickerDate!=null){
            String formattedDate = DateFormat("dd/MM/yyyy").format(pickerDate);
            setState(() {
              _con.fechaRechazoController.text=formattedDate.toString();
            });
          }else{
            return 'Fecha rechazo es requerido.';
          }
        },
//         autofocus: false,
//         focusNode: AlwaysDisabledFocusNode(),
        decoration: InputDecoration(
            labelText: 'Fecha de Rechazo',
            suffixIcon: Icon(
              Icons.date_range_sharp,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }

  Widget _fechaInicio() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextFormField(
        controller: _con.fechaInicioController,
        validator: (value) {
          if (value.isEmpty) {
            return 'Fecha de inicio requerido.';
          }
          return null;
        },
        onTap: () async {
          DateTime pickerDate=await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2022), lastDate: DateTime(2025)) ;
          if(pickerDate!=null){
            String formattedDate = DateFormat("dd/MM/yyyy").format(pickerDate);
            setState(() {
              _con.fechaInicioController.text=formattedDate.toString();
            });
          }else{
            print("no selesct fecha");
          }
        },
//         autofocus: false,
//         focusNode: AlwaysDisabledFocusNode(),
        decoration: InputDecoration(
            labelText: 'Fecha de inicio',
            suffixIcon: Icon(
              Icons.date_range_sharp,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }

  Widget _motivoRechazo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Material(
              elevation: 2.0,
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 7),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: DropdownButtonFormField(
                        icon: Icon(
                          Icons.arrow_drop_down_circle,
                          color: MyColors.primaryColor,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyColors.primaryColor),
                          ),
                        ),
                        elevation: 3,
                        isExpanded: true,
                        hint: Text(
                          'Tipo de motivo rechazo',
                          style: TextStyle(
                              color: MyColors.primaryColor,
                              fontSize: 14
                          ),
                        ),
                        items: _dropDownItems(_con.adClasificadorMotivoRechazoList),
                        // items: dropdownItems,
                        value: _con.selectedMotivoRechazo,
                        //value: selectedValue,
                        validator: (value) => value == null ? 'Tipo de motivo rechazo es requerido.' : null,
                        onChanged: (option) {
                          setState(() {
                            print('Reparidor selecciondo $option');
                            _con.selectedMotivoRechazo = option; // ESTABLECIENDO EL VALOR SELECCIONADO
                            //selectedValue = option; // ESTABLECIENDO EL VALOR SELECCIONADO
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
    );
  }

  Widget _otroMotivoRechazo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextFormField(
        controller: _con.otroMotivoRechazoController,
        decoration: InputDecoration(
            labelText: 'Otro motivo de rechazo',
            suffixIcon: Icon(
              Icons.note_outlined,
              color: MyColors.primaryColor,
            )
        ),
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value.isEmpty) {
            return 'Otro motivo de rechazo es requerido.';
          }
          return null;
        },
      ),
    );
  }

  Widget _textCompleteData() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Text(
        'Completa estos datos',
        selectionColor: MyColors.primaryColor,
        style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _buttonAccept() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
      child: ElevatedButton(
        onPressed: (){
          if(_formKey.currentState.validate()){
            setState(() {
              _con.create();
            });
          }
        },
        child: Text(
            'CREAR REGISTRO'
        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            primary: MyColors.primaryColor
        ),
      ),
    );
  }
  bool isDate(String input, String format)  {
    try {
      final DateTime d = DateFormat(format).parseStrict(input);
      //print(d);
      return true;
    } catch (e) {
      //print(e);
      return false;
    }
  }
  void refresh() {

    setState(() {});

  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

List<DropdownMenuItem<String>> _dropDownItems(List<AdClasificador> documentType) {
  List<DropdownMenuItem<String>> list = [];
  documentType.forEach((document) {
    list.add(DropdownMenuItem(
      child: Container(
        margin: EdgeInsets.only(top: 7),
        child: Text(document.itemText),
      ),
      value: document.itemId,
    ));
  });

  return list;
}
