import 'package:flutter/material.dart';
import 'package:integradora/controllers/databaseHelpers.dart';
import 'package:integradora/pages/camarasPage.dart';
import 'package:integradora/pages/editCamera.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Detail extends StatefulWidget {
  List list; // lista
  int index; // indice de la lista
  Detail({this.index, this.list});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  DataBaseHelper databaseHelper = new DataBaseHelper(); // objeto databasehelper
  //create function delete
  void confirm() async {
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance(); //objeto con valores del usuarioq ue inicio sesion
    AlertDialog alertDialog = new AlertDialog(
      //objeto del tipo alertdialog
      content: new Text(
          "Esta seguro de eliminar '${widget.list[widget.index]}'"), // muestra una caja de dialogo con ese mensaje
      actions: <Widget>[
        new RaisedButton(
          child: new Text(
            "Si, remover!", // boton de confirmacion
            style: new TextStyle(color: Colors.black),
          ),
          color: Colors.red,
          onPressed: () {
            print(widget.index.toString().runtimeType);
            var username =
                sharedPreferences.getString('username'); // almacena el usuario
            databaseHelper.removeRegister(widget.index.toString(),
                username); // funcion que remeuve el registro
            for (var i = 0; i < 2; i++) {
              Navigator.of(context)
                  .pop(); // itera la cantidad de paginas anteriores una vez eliminado el registro
            }
            Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new CamerasPage(),
            ));
          },
        ),
        new RaisedButton(
          child: new Text("Cancelar",
              style: new TextStyle(
                  color: Colors
                      .black)), //boton para cancelar el eliminar un registro
          color: Colors.green,
          onPressed: () => Navigator.pop(context), // remueve la caja de dialogo
        ),
      ],
    );

    showDialog(
      //funcion de alert dialog
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("${widget.list[widget.index]}")),
      body: new Container(
        height: 270.0,
        padding: const EdgeInsets.all(20.0),
        child: new Card(
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                ),
                new Text(
                  widget.list[widget.index],
                  style: new TextStyle(fontSize: 20.0),
                ),
                Divider(),
                new Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                ),
                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new RaisedButton(
                      child: new Text("Edit"), // boton para editar el url
                      color: Colors.blueAccent,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () =>
                          Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new EditCamera(
                          // una vez presionado nos lleva a la paigna de edicion de la url con el inidice como parametro
                          list: widget.list,
                          index: widget.index,
                        ),
                      )),
                    ),
                    VerticalDivider(),
                    new RaisedButton(
                      child: new Text("Delete"),
                      color: Colors.redAccent,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () =>
                          confirm(), //una vez presionado llama ala funcion para elmiminar el registro
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
