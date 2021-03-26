import 'package:flutter/material.dart';
import 'package:integradora/controllers/databaseHelpers.dart';
import 'package:integradora/pages/camarasPage.dart';
import 'package:integradora/pages/editCamera.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({this.index, this.list});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  DataBaseHelper databaseHelper = new DataBaseHelper();
  //create function delete
  void confirm() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    AlertDialog alertDialog = new AlertDialog(
      content:
          new Text("Esta seguto de eliminar '${widget.list[widget.index]}'"),
      actions: <Widget>[
        new RaisedButton(
          child: new Text(
            "Si, remover!",
            style: new TextStyle(color: Colors.black),
          ),
          color: Colors.red,
          onPressed: () {
            print(widget.index.toString().runtimeType);
            var username = sharedPreferences.getString('username');
            databaseHelper.removeRegister(widget.index.toString(), username);
            for (var i = 0; i < 2; i++) {
              Navigator.of(context).pop();
            }
            Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new CamerasPage(),
            ));
          },
        ),
        new RaisedButton(
          child:
              new Text("Cancelar", style: new TextStyle(color: Colors.black)),
          color: Colors.green,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(
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
                      child: new Text("Edit"),
                      color: Colors.blueAccent,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () =>
                          Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new EditCamera(
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
                      onPressed: () => confirm(),
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
