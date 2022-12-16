class AdClasificador {

  //IDENTIFICADOR DEL TIPO DE IDENTIFICACION
  String itemId;

  //OMBRE DEL TIPO DE IDENTIFICACION
  String itemText;

  // //TIPO DE DATO DEL NUMERO DE IDENTIFICACION
  // String type;
  //
  // //MINIMA LONGITUD DEL NUMERO DE IDENTIFICACION
  // int minLength;
  //
  // //MAXIMA LONGITUD DEL NUMERO DE IDENTIFICACION
  // int maxLength;

  List<AdClasificador> AdClasificadorList = new List();

  AdClasificador();

  AdClasificador.fromJsonList( List<dynamic> jsonList  ){
    if ( jsonList == null ) {
      return;
    }
    jsonList.forEach((item) {
      final chat = AdClasificador.fromJsonMap(item);
      AdClasificadorList.add(chat);
    });
  }

  AdClasificador.fromJsonMap( Map<String, dynamic> json ) {
    print('EL JSON ES $json');
    itemId = json['item_id'];
    itemText          = json['item_text'];
    // type          = json['type'];
    // minLength     = (json['min_length'] != null) ? int.parse(json['min_length'].toString()) : 0;
    // maxLength     = (json['max_length'] != null) ? int.parse(json['max_length'].toString()) : 0;
  }

  Map<String, dynamic> toJson() =>
      {
        'item_id'          : itemId,
        'item_text'        : itemText,
        // 'type'        : type,
        // 'min_length'  : minLength,
        // 'max_length'  : maxLength
      };
}