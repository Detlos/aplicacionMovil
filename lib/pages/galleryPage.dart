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
    // funcion para al peticion de elementos de la galeria
    Dio dio = new Dio();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var username =
        sharedPreferences.getString("username"); // username del usuario
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
      itemCount: list == null
          ? 0
          : list
              .length, // si list es diferente a null, saca el tama;o de la lista de elementos o si no es igual a 0
      itemBuilder: (context, i) {
        // crea una lista de elementos
        return new Container(
          height: 150, //altura
          child: Card(
            //targeta
            elevation: 10, // efecto de elevado
            color: Colors.white,
            child: Row(
              //grupo de targetas
              children: [
                //hijos para la lista
                Expanded(
                  // expande la tarjeta
                  flex: 33,
                  child: Image.network(
                    // coloca las urls de las imagenes traidas de internet
                    list[i]['imagen'],
                  ),
                ),
                Expanded(
                  flex: 28, // le coloca un flex de 28 a la imagen
                  child: Column(
                    // coloca los elementos dentro de la descripcion en columna
                    children: [
                      Expanded(
                          //expande el apartado de la descripcion
                          flex: 25, // flex e 25 a la descripcion
                          child: Column(
                            children: [
                              ListTile(
                                title: new Text(
                                  'Capturado el:', // titulo de la descripcion
                                  style: new TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: new Column(children: <Widget>[
                                  new Text(
                                      list[i][
                                          'fecha'], // subtitulo con informaicon de la captura
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
