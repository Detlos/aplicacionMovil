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

  TextEditingController controllerIp;
  var indice;
  @override
  void initState() {
    controllerIp =
        new TextEditingController(text: widget.list[widget.index].toString());
    indice = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Editar camara"),
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
                    controller: controllerIp,
                    validator: (value) {
                      if (value.isEmpty) return "IP";
                    },
                    decoration: new InputDecoration(
                      hintText: "IP",
                      labelText: "IP",
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
                  child: new Text("Edit"),
                  color: Colors.blueAccent,
                  onPressed: () {
                    databaseHelper.editarCamara(
                        indice.toString(), controllerIp.text.trim());
                    for (var i = 0; i < 2; i++) {
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
