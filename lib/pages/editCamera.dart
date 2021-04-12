import 'package:flutter/material.dart';
import 'package:integradora/controllers/databaseHelpers.dart';
import 'package:integradora/pages/camarasPage.dart';

class EditCamera extends StatefulWidget {
  final List list;
  final int index;

  EditCamera({this.list, this.index});

  @override
  _EditCameraState createState() => _EditCameraState();
}

class _EditCameraState extends State<EditCamera> {
  DataBaseHelper databaseHelper = new DataBaseHelper();

  TextEditingController
      controllerIp; // controlador para le edicion de formularios
  var indice; // indice
  @override
  void initState() {
    controllerIp = new TextEditingController(
        text: widget.list[widget.index]
            .toString()); // se le asigna el indice del url a editar al controlador como string
    indice = widget.index; // indice es igual al indice del elemento
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Editar camara"), // titutlo
        centerTitle: true,
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: <Widget>[
            new Column(
              children: <Widget>[
                new ListTile(
                  leading: const Icon(Icons.camera, color: Colors.black),
                  title: new TextFormField(
                    controller: controllerIp, // controla el texto a editar
                    validator: (value) {
                      // valida que haya un elemento sino regresa la palabra link
                      if (value.isEmpty) return "Link";
                    },
                    decoration: new InputDecoration(
                      // funcion para decorar el formulario
                      hintText: "Link", //titulo del elemento
                      labelText: "Link", //subtitulo
                    ),
                  ),
                ),
                const Divider(
                  height: 1.0,
                ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                new RaisedButton(
                  child: new Text("Edit"), // boton d confirmacion
                  color: Colors.blueAccent,
                  onPressed: () {
                    databaseHelper.editarCamara(
                        // manda la peticion para editar la camara
                        indice.toString(),
                        controllerIp.text.trim());
                    for (var i = 0; i < 2; i++) {
                      //aremoviendo las paginas anteriores
                      Navigator.of(context).pop();
                    }
                    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new CamerasPage(),
                    ));
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
