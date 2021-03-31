import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:integradora/controllers/mjpeg_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:integradora/controllers/databaseHelpers.dart';
import 'detailCamera.dart';

var nombreUsuario;

class StreamingPage extends StatefulWidget {
  @override
  _StreamingPageState createState() => _StreamingPageState();
}

class _StreamingPageState extends State<StreamingPage> {
  DataBaseHelper dataB = DataBaseHelper();
  Future<List<dynamic>> getData() async {
    Dio dio = new Dio();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var username = sharedPreferences.getString("username");
    nombreUsuario = sharedPreferences.getString("username");
    var data = [];
    var response = await dio.post(
        "https://detlosapi.herokuapp.com/get_hardware",
        data: {'username': username});
    Map<String, dynamic> map = response.data['objeto'];
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
        title: new Text("LiveCams"),
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
          padding: const EdgeInsets.all(10.0),
          child: MjpegView(url: list[i]),
        );
      },
    );
  }
}
