import 'package:flutter/material.dart';
import 'package:trabajo/providers/Alumnos_provider.dart';
import 'package:trabajo/providers/Curso_provider.dart';

class Alumnos_agregar_page extends StatefulWidget {
  Alumnos_agregar_page({Key? key}) : super(key: key);

  @override
  State<Alumnos_agregar_page> createState() => _Alumnos_agregar_pageState();
}

class _Alumnos_agregar_pageState extends State<Alumnos_agregar_page> {
  final formKey = GlobalKey<FormState>();
  TextEditingController codigoCtrl = TextEditingController();
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController direccionCtrl = TextEditingController();
  TextEditingController telefonoCtrl = TextEditingController();
  TextEditingController edadCtrl = TextEditingController();
  TextEditingController cursoCtrl = TextEditingController();
  String cur = '';
  String errCodigo = "";
  String errNombre = "";
  String errDireccion = "";
  String errTelefono = "";
  String errEdad = "";
  String errCurso = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Alumnos'),
        backgroundColor: Colors.purple,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              TextFormField(
                controller: codigoCtrl,
                decoration: InputDecoration(labelText: 'Codigo'),
              ),
              Container(
                width: double.infinity,
                child: Text(
                  errCodigo,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextFormField(
                controller: nombreCtrl,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              Container(
                width: double.infinity,
                child: Text(
                  errNombre,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextFormField(
                controller: direccionCtrl,
                decoration: InputDecoration(labelText: 'Direccion'),
              ),
              Container(
                width: double.infinity,
                child: Text(
                  errDireccion,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextFormField(
                controller: telefonoCtrl,
                decoration: InputDecoration(labelText: 'Telefono'),
              ),
              Container(
                width: double.infinity,
                child: Text(
                  errTelefono,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextFormField(
                controller: edadCtrl,
                decoration: InputDecoration(labelText: 'Edad'),
              ),
              Container(
                width: double.infinity,
                child: Text(
                  errEdad,
                  style: TextStyle(color: Colors.red),
                ),
              ),

              Container(
                child: FutureBuilder(
                  future: CursoProvider().getCursocmb(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      //return Text('Cargando regiones...');
                      return DropdownButtonFormField<String>(
                        hint: Text('Cargando cursos...'),
                        items: [],
                        onChanged: (valor) {},
                      );
                    }
                    var cursos = snapshot.data;
                    return DropdownButtonFormField<String>(       
                      hint: Text('Cursos'),
                      items: cursos.map<DropdownMenuItem<String>>((cur) {                        
                        return DropdownMenuItem<String>(                          
                          child: Text(cur['curso']),
                          value: cur['curso'],
                        );
                      }).toList(),
                      value: cur.isEmpty ? null : cur,
                      onChanged: (nuevo) {
                        setState(() {
                          cur = nuevo.toString();
                        });
                      },
                    );
                  },
                ),
              ),

              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Agregar Alumno'),
                  onPressed: ()async{
                    int edad = int.tryParse(edadCtrl.text)??0;
                    var respuesta = await AlumnosProvider().alumnosAgregar(codigoCtrl.text.trim(), nombreCtrl.text.trim(), direccionCtrl.text.trim(), telefonoCtrl.text.trim(), edad, cur.toString());
                    
                    if (respuesta['message']!= null){
                      if(respuesta['errors']['cod_alumno']!=null){
                        errCodigo = respuesta['errors']['cod_alumno'][0];
                      }else{
                        errCodigo = '';
                      }
                      setState(() {
                        
                      });
                      return;
                    }Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}