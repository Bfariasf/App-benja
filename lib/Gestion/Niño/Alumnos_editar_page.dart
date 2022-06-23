import 'package:flutter/material.dart';
import 'package:trabajo/providers/Alumnos_provider.dart';
import 'package:trabajo/providers/Curso_provider.dart';
class Alumnos_editar_page extends StatefulWidget {
  String codAlumno;
  Alumnos_editar_page(this.codAlumno,{Key? key}) : super(key: key);

  @override
  State<Alumnos_editar_page> createState() => _Alumnos_editar_pageState();
}

class _Alumnos_editar_pageState extends State<Alumnos_editar_page> {
  TextEditingController codigoCtrl = TextEditingController();
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController direccionCtrl = TextEditingController();
  TextEditingController telefonoCtrl = TextEditingController();
  TextEditingController edadCtrl = TextEditingController();
  TextEditingController cursoCtrl = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String curs = '';
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Alumno'),
        backgroundColor: Colors.purple,
      ),
      body: FutureBuilder(
        future: AlumnosProvider().getAlumno(widget.codAlumno),
        builder:(context, AsyncSnapshot snapshot){
          if (!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var data = snapshot.data;
          codigoCtrl.text = data['cod_alumno'];
          nombreCtrl.text = data['nom_alumno'];
          direccionCtrl.text = data['direccion'];
          telefonoCtrl.text = data['telefono'];
          edadCtrl.text = data['edad'].toString();
          cursoCtrl.text = data['nom_curso'];
         
          return Form(
            key: formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: codigoCtrl,
                  decoration: InputDecoration(labelText: 'Codigo'),
                ),
                TextFormField(
                  controller: nombreCtrl,
                  decoration: InputDecoration(labelText: 'Nombre'),
                ),
                TextFormField(
                  controller: direccionCtrl,
                  decoration: InputDecoration(labelText: 'Direccion'),
                ),
                TextFormField(
                  controller: telefonoCtrl,
                  decoration: InputDecoration(labelText: 'Telefono'),
                ),
                TextFormField(
                  controller: edadCtrl,
                  decoration: InputDecoration(labelText: 'Edad'),
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

                      var curso = snapshot.data;

                      return DropdownButtonFormField<String>(
                        
                        hint: Text(cursoCtrl.text),
                        items: curso.map<DropdownMenuItem<String>>((curs) {
                          return DropdownMenuItem<String>(
                            child: Text(curs['curso']),
                            value: curs['curso'],
                          );
                        }).toList(),
                        value: curs.isEmpty ? null : curs,
                        onChanged: (nuevaRegion) {
                          setState(() {
                            curs = nuevaRegion.toString();
                          });
                        },
                      );
                    },
                  ),
                ),

                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text('Editar'),
                    onPressed: (){
                      AlumnosProvider().alumnosEditar(widget.codAlumno, codigoCtrl.text.trim(), nombreCtrl.text.trim(), direccionCtrl.text.trim(), telefonoCtrl.text.trim(), int.tryParse(edadCtrl.text.trim())??0, curs);
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                    )
                  ),
                )

              ],
            ),
          );
        }
      ),
    );
  }
}