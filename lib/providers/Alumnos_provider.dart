
import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AlumnosProvider{
  final String apiURL = 'http://10.0.2.2:8000/api';

  //Llamar alumnos
  Future <List<dynamic>> getAlumnos()async{
    var uri = Uri.parse('$apiURL/alumnos');
    var respuesta = await http.get(uri);
    if (respuesta.statusCode == 200){
      return json.decode(respuesta.body);
    }else{
      return[];
    }
  }

  //Llamar un alumno
  Future<LinkedHashMap<String,dynamic>> getAlumno(String codAlumno)async{
    var uri = Uri.parse('$apiURL/alumnos/$codAlumno');
    var respuesta = await http.get(uri);
    if (respuesta.statusCode == 200){
      return json.decode(respuesta.body);
    }else{
      return new LinkedHashMap();
    }
  }



  //editar alumno
  Future<LinkedHashMap<String, dynamic>> alumnosEditar(
    String cod_alumno, String cod_alumno_nuevo, String nom_alumno, String direccion, String telefono, int edad, String nom_curso)async{
      var uri = Uri.parse('$apiURL/alumnos/$cod_alumno');
      var respuesta = await http.put(uri,
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Accept': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'cod_alumno':cod_alumno,
        'cod_alumno_nuevo':cod_alumno_nuevo,
        'nom_alumno':nom_alumno,
        'direccion':direccion,
        'telefono':telefono,
        'edad':edad,
        'nom_curso':nom_curso
      }));
      return json.decode(respuesta.body);
    }
  


  //añadir
  Future <LinkedHashMap <String, dynamic>> alumnosAgregar(String cod_alumno, String nom_alumno, String direccion, String telefono, int edad, String nom_curso)async{
    var uri = Uri.parse('$apiURL/alumnos');
    var respuesta = await http.post(uri,headers:<String,String>{
      'Content-Type':'application/json;charset=UTF-8','Accept':'application/json'
    },
    body: jsonEncode(<String,dynamic>{'cod_alumno':cod_alumno, 'nom_alumno':nom_alumno, 'direccion':direccion, 'telefono':telefono, 'edad':edad, 'nom_curso':nom_curso}));
    return json.decode(respuesta.body);
  }

  //eliminar

  Future <bool> alumnosBorrar(String cod_alumno)async{
    var uri = Uri.parse('$apiURL/alumnos/$cod_alumno');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }

}
