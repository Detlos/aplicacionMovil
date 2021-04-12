import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:integradora/controllers/databaseHelpers.dart';
import 'detailCamera.dart';

var nombreUsuario;

class CamerasPage extends StatefulWidget {
  @override
  _CamerasPageState createState() => _CamerasPageState();
}

class _CamerasPageState extends State<CamerasPage> {
  DataBaseHelper dataB = DataBaseHelper(); // objeto del tipo databasehelper
  Future<List<dynamic>> getData() async {
    //funcion para obtener elementos con http requests
    Dio dio = new Dio(); // objeto del tipo dio para realizar las http requests
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance(); // objeto con los valores almacenados en la memoria del telefono
    var username =
        sharedPreferences.getString("username"); //se almacena el usuario
    nombreUsuario = sharedPreferences.getString("username");
    var data = []; //arreglo de urls
    var response = await dio.post(
        //peticion de urls de las camaras
        "https://img-detlos.herokuapp.com/get_hardware",
        data: {'username': username});
    Map<String, dynamic> map =
        response.data['objeto']; //mapeo de elementos en dicccionario
    map.forEach((k, v) =>
        data.add(v)); //se agregan los elementos al arreglo sin las llaves
    return data; //regresa el arreglo de elementos
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
        title: new Text("Camaras"), // titulo
        centerTitle: true, //centrado de titulo
      ),
      floatingActionButton: FloatingActionButton(
        // boton para agregar nuevos elementos
        backgroundColor: Color(0xff011e30),
        onPressed: () => {
          dataB.addIp(
              nombreUsuario), // funcion que realiza una peticion para agregar un nuevo elemento
          Navigator.of(context)
              .pushReplacementNamed('camerasPage') //refresca la pagina
        },
        tooltip: 'Agregar nueva IP', //titulo
        child: Icon(Icons.add), // icono de mas
      ),
      body: new FutureBuilder<List>(
        // lista de elementos en el cuerpo de la apgina
        future: getData(), //funcion que obtiene los elementos
        builder: (context, snapshot) {
          if (snapshot.hasError)
            print(snapshot.error); // conficional que meustra elementos si hay
          return snapshot.hasData //regresa los elementos encontrados
              ? new ItemList(
                  // si encuentra los elementos lalma a la funcion item list con el elemento
                  list: snapshot.data,
                )
              : new Center(
                  child: Text(
                      'No data found'), // si no encuentra elementos indica que no se encontraron
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
      //construye una vista de los elementos
      itemCount: list == null
          ? 0
          : list
              .length, // cuenta la cantidad de elementos. si es nula entonces es igual a 0
      itemBuilder: (context, i) {
        //construye los elementos seugn el contexto y con el iterador
        return new Container(
          // contenedor de elementos
          padding: const EdgeInsets.all(10.0), // padding de el contenedor
          child: new GestureDetector(
            // hace dinamicas las targetas
            onTap: () => Navigator.of(context).pushReplacement(
              // al clickear una de las targetas nos manda a una apgina nueva con detalles de la targeta
              new MaterialPageRoute(
                  builder: (BuildContext context) => new Detail(
                        list: list,
                        index: i,
                      )),
            ),
            child: new Card(
              //targetas de las url
              color: Colors.grey[900], //color de la targeta
              child: new ListTile(
                title: new Text(
                  list[
                      i], // titulo de la targeta, la cual se llamara segun su url
                  style: TextStyle(
                      // estilo de la letra de la tarjeta
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
