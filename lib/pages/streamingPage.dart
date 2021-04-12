import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:integradora/controllers/mjpeg_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:integradora/controllers/databaseHelpers.dart';

var nombreUsuario;

class StreamingPage extends StatefulWidget {
  @override
  _StreamingPageState createState() => _StreamingPageState();
}

class _StreamingPageState extends State<StreamingPage> {
  DataBaseHelper dataB = DataBaseHelper();
  var estado = true;
  var nombreDeUsuario = '';
  Future<List<dynamic>> getData() async {
    Dio dio = new Dio();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var username = sharedPreferences.getString("username");
    nombreUsuario = sharedPreferences.getString("username");
    var data = [];
    var respuesta = await dio
        .get("https://img-detlos.herokuapp.com/obtener_estado/" + '$username');
    estado = respuesta == 'True' ? true : false;
    var response = await dio.post(
        "https://img-detlos.herokuapp.com/get_hardware",
        data: {'username': username});
    Map<String, dynamic> map = response.data['objeto'];
    map.forEach((k, v) => data.add(v));
    return data;
  }

  getUsername() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    nombreDeUsuario = sharedPreferences.getString("username");
  }

  Future apagadoYEncendido() async {
    Dio dio = Dio();
    getUsername();
    if (estado) {
      try {
        estado = false;
        await dio.post("https://img-detlos.herokuapp.com/apagar_alarma",
            data: {'username': nombreDeUsuario});
      } catch (e) {
        print(e);
      }
    } else {
      try {
        estado = true;
        await dio.post("https://img-detlos.herokuapp.com/encender_alarma",
            data: {'username': nombreDeUsuario});
      } catch (e) {
        print(e);
      }
    }
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
        title: new Text("LiveCams"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff011e30),
        onPressed: () async => {apagadoYEncendido()},
        tooltip: 'Apagar/Encender',
        child: Icon(Icons.power),
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
          padding: const EdgeInsets.all(10.0),
          child: MjpegView(url: list[i]),
        );
      },
    );
  }
}
