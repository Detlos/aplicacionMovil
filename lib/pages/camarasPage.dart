import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'detailCamera.dart';

class CamerasPage extends StatefulWidget {
  @override
  _CamerasPageState createState() => _CamerasPageState();
}

class _CamerasPageState extends State<CamerasPage> {
  Future<List<dynamic>> getData() async {
    Dio dio = new Dio();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var username = sharedPreferences.getString("username");
    var response = await dio.post(
        "https://detlosapi.herokuapp.com/get_hardware",
        data: {'username': username});
    print(response.data['objeto']);
    Map<String, dynamic> map = response.data['objeto'];
    var data = [];
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
        title: new Text("Camaras"),
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
          child: new GestureDetector(
            onTap: () => Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (BuildContext context) => new Detail(
                        list: list,
                        index: i,
                      )),
            ),
            child: new Card(
              color: Colors.grey[900],
              child: new ListTile(
                title: new Text(
                  list[i],
                  style: TextStyle(
                      fontSize: 25.0,
                      backgroundColor: Colors.grey[900],
                      color: Colors.lightGreenAccent[400]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
