import 'package:flutter/material.dart';
import 'package:trabajo/Gestion/Curso/Curso_page.dart';
import 'package:trabajo/Gestion/Ni%C3%B1o/Alumnos_page.dart';
import 'package:trabajo/Gestion/Profesores.dart';


class MenuG extends StatefulWidget {
  MenuG({Key? key}) : super(key: key);

  @override
  State<MenuG> createState() => _MenuGState();
}

class _MenuGState extends State<MenuG> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.android),
        title: Text('Menu de gestión'),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          /*Container(
            height: 40,
            width: double.infinity,
            color: Colors.indigo,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Pinches Juegos',style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),)
              ]),
          ),*/
          Expanded(
            child: ListView(
              children: [
                curso(),
                profesores(),
                kids()
              ],
            ))
        ],
      ),
    );
  }



  ListTile curso (){
    return ListTile(
      onTap: () {
      MaterialPageRoute route = MaterialPageRoute(builder: (context) {
        return CursoPage();
      });
      Navigator.push(context, route);
      },
      leading: Icon(Icons.accessibility),
      title: Text('Curso'),
    );

  }


  ListTile profesores (){
    return ListTile(
      onTap: () {
      MaterialPageRoute route = MaterialPageRoute(builder: (context) {
        return Profesores();
      });
      Navigator.push(context, route);
      },
      leading: Icon(Icons.accessibility),
      title: Text('Profesores'),
    );

  }

  ListTile kids (){
    return ListTile(
      onTap: () {
      MaterialPageRoute route = MaterialPageRoute(builder: (context) {
        return Ninos_page();
      });
      Navigator.push(context, route);
      },
      leading: Icon(Icons.accessibility),
      title: Text('Niños'),
    );

  }
}