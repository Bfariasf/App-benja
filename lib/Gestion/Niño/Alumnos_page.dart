import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trabajo/Gestion/Ni%C3%B1o/Alumnos_agregar_page.dart';
import 'package:trabajo/providers/Alumnos_provider.dart';
import 'package:trabajo/Gestion/Niño/Alumnos_editar_page.dart';

class Ninos_page extends StatefulWidget {
  Ninos_page({Key? key}) : super(key: key);

  @override
  State<Ninos_page> createState() => _Ninos_pageState();
}

class _Ninos_pageState extends State<Ninos_page> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista Alumnos'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: AlumnosProvider().getAlumnos(),
                builder: (context,AsyncSnapshot snap){
                  if(!snap.hasData){
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.separated(
                    separatorBuilder:(_,__)=> Divider(),
                    itemCount:snap.data.length,
                    itemBuilder:(context,index){
                      var alumn = snap.data[index];
                      return Slidable(
                        child: ListTile(
                          leading: Icon(MdiIcons.book),
                          title: Text('[${alumn['cod_alumno']}] ${alumn['nom_alumno']}'),
                          subtitle: Text('${alumn['direccion']}'),
                          trailing: Text('${alumn['nom_curso']}'),
                        ),
                        startActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context){
                                MaterialPageRoute route = MaterialPageRoute(
                                  builder: (context) => Alumnos_editar_page(alumn['cod_alumno']),
                                );
                                Navigator.push(context, route).then((value){
                                  setState(() { });
                                },);
                                
                              },
                              backgroundColor: Colors.purple,
                              icon: MdiIcons.pen,
                              label: 'Editar',
                            ),
                          ],
                        ),
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context){
                                String cod_alumno = alumn['cod_alumno'];
                                String nom_alumno = alumn['nom_alumno'];

                                confirmDialog(context, nom_alumno).then((confirma){
                                  if(confirma){
                                    AlumnosProvider().alumnosBorrar(cod_alumno).then((borradoOK){
                                      if (borradoOK){
                                        snap.data.removeAt(index);
                                        setState(() {});
                                        showSnackbar('Alumno $nom_alumno borrado');
                                      }else{
                                        showSnackbar('No se pudo eliminar al Alumno');
                                      }
                                    });
                                  }
                                });
                              },
                              backgroundColor: Colors.red,
                              icon: MdiIcons.trashCan,
                              label: 'Borrar',
                            )
                          ],
                        ),
                      );
                    }
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              
              child: ElevatedButton(child: Text('Agregar'),
              onPressed: (){
                MaterialPageRoute go = MaterialPageRoute(
                  builder: (context){
                    return Alumnos_agregar_page();
                  });
                  Navigator.push(context, go).then((value){
                    print('Actualizar Pagina');
                    setState(() {});
                  });
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              )
              ),
            )
          ],
        ),
      ),
    );
  }
  void showSnackbar(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(mensaje),
      ),
    );
  }
  Future<dynamic>confirmDialog(BuildContext context, String alumno){
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('Confirmar borrado'),
          content: Text('¿Borrar el producto $alumno?'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.pop(context, false),
            ),
            ElevatedButton(
              child: Text('Aceptar'),
              onPressed: () => Navigator.pop(context, true),
            )
          ],
        );
      }
    );
  }
}