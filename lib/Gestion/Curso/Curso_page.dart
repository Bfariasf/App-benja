import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trabajo/Gestion/Curso/Curso_agregar_page.dart';
import 'package:trabajo/providers/Curso_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CursoPage extends StatefulWidget {
  CursoPage({Key? key}) : super(key: key);

  @override
  State<CursoPage> createState() => _CursoPageState();
}

class _CursoPageState extends State<CursoPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de cursos'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: CursoProvider().getCurso(),
                builder: (context, AsyncSnapshot snap){
                  if(!snap.hasData){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (_,__) => Divider(),
                    itemCount: snap.data.length,
                    itemBuilder: (context, index){
                      var cur = snap.data[index];
                      return Slidable(
                        child: ListTile(
                          leading: Icon(Icons.list),
                          title: Text('Nombre del curso: ${cur['curso']}', style: TextStyle(fontSize: 18, color: Colors.indigo),),
                          subtitle: Text('Cantidad de alumnos:${cur['cantidad']}'),
                        ),
                        startActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                String cod_curso = cur['cod_curso'];
                                String curso = cur['curso'];

                                confirmDialog(context, curso).then((confirma) {
                                  if (confirma) {
                                    //borrar
                                    CursoProvider().cursoBorrar(cod_curso).then((borradoOk) {
                                      if (borradoOk) {
                                        //pudo borrar
                                        snap.data.removeAt(index);
                                        setState(() {});
                                        showSnackbar('Producto $curso borrado');
                                      } else {
                                        //no pudo borrar
                                        showSnackbar('No se pudo borrar el producto');
                                      }
                                    });
                                  }
                                });
                              },
                              backgroundColor: Colors.red,
                              label: 'Borrar',
                            ),
                          ],
                        ),
                      );
                      /*return Dismissible(
                        key: ObjectKey(cur),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.purple,
                        ),
                        secondaryBackground: Container(
                          padding: EdgeInsets.only(right: 10),
                          alignment: Alignment.centerRight,
                          color: Colors.red,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('Borrar',style: TextStyle(color: Colors.white),),
                              Icon(Icons.abc, color: Colors.red,)
                            ],
                          ),
                        ),
                        onDismissed: (direction){
                          String cod_curso = cur['cod_curso'];
                          CursoProvider().cursoBorrar(cod_curso).then((borradook){
                            if(borradook){
                              snap.data.removeAt(index);
                              setState(() {});
                            }
                          });
                        },
                        child: ListTile(
                          leading: Icon(Icons.list),
                          title: Text('Nombre del curso: ${cur['curso']}', style: TextStyle(fontSize: 18, color: Colors.indigo),),
                          subtitle: Text('Cantidad de alumnos:${cur['cantidad']}'),
                        ),
                      );*/
                    },
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
                    return CursoAgregarPage();
                  });
                  Navigator.push(context, go).then((value){
                    print('Actualizar Pagina');
                    setState(() {});
                  });
              },),
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


  Future<dynamic> confirmDialog(BuildContext context, String producto) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmar borrado'),
          content: Text('¿Borrar el producto $producto?'),
          actions: [
            TextButton(
              child: Text('CANCELAR'),
              onPressed: () => Navigator.pop(context, false),
            ),
            ElevatedButton(
              child: Text('ACEPTAR'),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        );
      },
    );
  }
}