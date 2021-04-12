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
  DataBaseHelper dataB = DataBaseHelper(); // objeto de la clase DatabaseHelper
  var estado = true; // estado de la camara
  var nombreDeUsuario =
      ''; // variable que guarda le nombre del usuario loggeado
  Future<List<dynamic>> getData() async {
    // funcion que jala las url de las camaras
    Dio dio = new Dio();
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance(); //objeto con los atirbutos del usuario
    var username = sharedPreferences
        .getString("username"); // se obtiene el username loggeado
    nombreUsuario = sharedPreferences.getString("username");
    var data = []; // se crea arreglo para iterar las camaras
    var respuesta = await dio.get(
        "https://img-detlos.herokuapp.com/obtener_estado/" +
            '$username'); // peticion que obtiene el estado
    estado = respuesta == 'True'
        ? true
        : false; // dependiendo del estado en la abse de datos asigna un verdadero o falso
    var response = await dio.post(
        // peticion que obtiene las urls de las camaras
        "https://img-detlos.herokuapp.com/get_hardware",
        data: {'username': username});
    Map<String, dynamic> map =
        response.data['objeto']; // mapeo de los diccionarios
    map.forEach((k, v) => data.add(v)); // conversion de diccionario a arreglo
    return data; // devuelve los urls ya en un arreglo
  }

  getUsername() async {
    // se obtiene el username
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    nombreDeUsuario = sharedPreferences.getString("username");
  }

  Future apagadoYEncendido() async {
    // funcion para cambiar el estado de la camara
    Dio dio = Dio(); //objeto para realizar peticiones
    getUsername(); // obtener usrname
    if (estado) {
      // si el estado es true entonces el boton mandar una peticion de apagado
      try {
        estado = false;
        await dio.post("https://img-detlos.herokuapp.com/apagar_alarma",
            data: {'username': nombreDeUsuario});
      } catch (e) {
        print(e);
      }
    } else {
      // si la camara esta apagada, entonces la peticion de encender con el boton
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
      // estructura de la pagina
      appBar: new AppBar(
        // barra de la pagina
        title: new Text("LiveCams"), // titulos de la pagina
        centerTitle: true, // centra el titulo
      ),
      floatingActionButton: FloatingActionButton(
        // boton que cambia el estado de las camaras
        backgroundColor: Color(0xff011e30),
        onPressed: () async => {
          apagadoYEncendido()
        }, // atributo que manda a llamar a la funcion que cambia el estado
        tooltip: 'Apagar/Encender',
        child: Icon(Icons.settings_power), // icono de encendido
      ),
      body: new FutureBuilder<List>(
        // cuerpo de la pagina donde se colocaran las camaras enlistadas
        future: getData(), // se manda a llamar la funcion para obtener las urls
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot
                  .hasData // regresa la informacion enlistada si es que se encuentra
              ? new ItemList(
                  list: snapshot.data,
                )
              : new Center(
                  // de lo contrario se imprime que no se encontro informaicon
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
      // regresa la vista de las camaras
      itemCount: list == null
          ? 0
          : list
              .length, // si es igual a null entonces el tama;o es igual a 0, sinose obtiene el tamaño
      itemBuilder: (context, i) {
        //se iteran las camaras
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: MjpegView(
              url: list[
                  i]), // funcion que despliega las camaras a traves del url
        );
      },
    );
  }
}
