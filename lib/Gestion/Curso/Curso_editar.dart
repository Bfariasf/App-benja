/*import 'package:flutter/material.dart';
import 'package:trabajo/providers/Curso_provider.dart';

class CursoEditarPage extends StatefulWidget {
  String codCurso;
  CursoEditarPage(this.codCurso, {Key? key}) : super(key: key);

  @override
  State<CursoEditarPage> createState() => _CursoEditarPageState();
}

class _CursoEditarPageState extends State<CursoEditarPage> {
  TextEditingController codigoCtrl = TextEditingController();
  TextEditingController cursoCtrl = TextEditingController();
  TextEditingController cantidadCtrl = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar curso'),
      ),
      body: FutureBuilder(
          future: CursoProvider().getCursoo(widget.codCurso),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            var data = snapshot.data;
            codigoCtrl.text = data['cod_curso'];
            cursoCtrl.text = data['curso'];
            cantidadCtrl.text = data['cantidad'].toString();

            return Form(
              key: formKey,
              child: ListView(
                children: [
                  TextFormField(
                  controller: codigoCtrl,
                  decoration: InputDecoration(labelText: 'Nivel'),
                  ),
                  TextFormField(
                  controller: cursoCtrl,
                  decoration: InputDecoration(labelText: 'Nombre del Curso'),
                  ),
                  TextFormField(
                  controller: cantidadCtrl,
                  decoration: InputDecoration(labelText: 'Cantidad de alumnos'),
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text('Editar'),
                      onPressed: () {
                        CursoProvider.cursoEditar(
                          widget.codCurso,
                          codigoCtrl.text.trim(),
                          cursoCtrl.text.trim(),
                          int.tryParse(cantidadCtrl.text.trim()) ?? 0,
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}*/