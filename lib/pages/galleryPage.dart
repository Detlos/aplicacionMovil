import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:integradora/controllers/databaseHelpers.dart';

var nombreUsuario;

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  DataBaseHelper dataB = DataBaseHelper();
  Future<List<dynamic>> getData() async {
    Dio dio = new Dio();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var username = sharedPreferences.getString("username");
    nombreUsuario = sharedPreferences.getString("username");
    var data = [];
    var response = await dio.post(
        "https://img-detlos.herokuapp.com/obtenerImagenes2",
        data: {'username': username});
    Map<String, dynamic> map = response.data;
    map.forEach((k, v) => data.add(v));
    return data;
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Fotos"),
        centerTitle: true,
      ),
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new ItemList(
                  list: snapshot.data,
                )
              : new Center(
                  child: Text('No data found'),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          height: 150,
          child: Card(
            elevation: 10,
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  flex: 33,
                  child: Image.network(
                    list[i]['imagen'],
                  ),
                ),
                Expanded(
                  flex: 28,
                  child: Column(
                    children: [
                      Expanded(
                          flex: 25,
                          child: Column(
                            children: [
                              ListTile(
                                title: new Text(
                                  'Capturado el:',
                                  style: new TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: new Column(children: <Widget>[
                                  new Text(list[i]['fecha'],
                                      style: new TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.normal)),
                                ]),
                              )
                            ],
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
