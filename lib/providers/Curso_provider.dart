import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CursoProvider {
  final String apiURL = 'http://10.0.2.2:8000/api';
  

  Future<List<dynamic>>getCurso()async{
    var uri = Uri.parse('$apiURL/curso');
    var respuesta = await http.get(uri);
    
    if(respuesta.statusCode==200){
      return json.decode(respuesta.body);
    }else{
      return [];
    }
  }

  Future<LinkedHashMap<String, dynamic>>getCursoo(String codCurso)async{
    var uri = Uri.parse('$apiURL/curso/$codCurso');
    var respuesta = await http.get(uri);
    
    if(respuesta.statusCode==200){
      return json.decode(respuesta.body);
    }else{
      return new LinkedHashMap();
    }
  }
  
  Future<LinkedHashMap<String, dynamic>>cursoAgregar(String cod_curso, String curso, int cantidad)async{
    var uri = Uri.parse('$apiURL/curso');
    var respuesta = await http.post(uri, headers: <String, String>{'Content-Type':'application/json; charset=UTF-8','Accept':'application/json'},
    body: jsonEncode(<String, dynamic>{'cod_curso':cod_curso,'curso':curso,'cantidad':cantidad}));
    return json.decode(respuesta.body);
  }

  Future<bool> cursoBorrar(String cod_curso)async{
    var uri = Uri.parse('$apiURL/curso/$cod_curso');
    var respuesta = await http.delete(uri);

    return respuesta.statusCode == 200;
  }

  Future<List<dynamic>> getCursocmb() async {
    var url = Uri.parse('$apiURL/curso');
    var respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }
}