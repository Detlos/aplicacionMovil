import 'package:flutter/material.dart';
import 'package:integradora/pages/camarasPage.dart';
import 'package:integradora/pages/detailCamera.dart';
import 'package:integradora/pages/galleryPage.dart';
import 'package:integradora/pages/loginPage.dart';
import 'package:integradora/pages/streamingPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp()); // inicia nuestra aplicacion
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // se remueve el banner de debugmode
      theme: ThemeData(
          primaryColor:
              Color(0xff011e30)), // se asigna un color para toda la app
      home: MainPage(), // se asigna la main page como la pagina home
      routes: {
        // se crean rutas para el acceso con el navigator
        "camerasPage": (BuildContext context) => CamerasPage(),
        "detailCameras": (BuildContext context) => Detail(),
        "liveCams": (BuildContext context) => StreamingPage(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  SharedPreferences
      sharedPreferences; // objeto que obtiene la informaicon almacenada en el dispositivo
  String username; // usuario
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    // funcion que verifica si un usuario ha iniciado sesion
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      // si no hay un token guardado la funcion nos manda
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  LoginPage()), // a la paigna de inicio de sesion
          (Route<dynamic> route) => false);
    }
    username = sharedPreferences.getString('username'); //almacena el usuario
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // estructura de la pagina
      appBar: AppBar(
        title: Text(
          "Pagina de Inicio", // titurlo de la pagina
          style: TextStyle(color: Colors.white), // color del texto
        ),
        centerTitle: true, // centra el titulo en la barra
      ),
      body: Container(
        // cuerpo de la pagina principal
        height: 1000, //altura del cuerpo de la pagina principal
        margin: const EdgeInsets.all(10.0), // margen de 10
        child: Column(children: [
          //se colocaran las targetas en columnas
          Container(
            // contenedor de targetas
            height: 250, // altura de la targeta de 250
            child: Card(
              elevation:
                  30, // sombra que simula que se encuentra elevada la targeta
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  //se le da a las targetas una forma rectangular con las esquinas redondeadas
                  borderRadius: BorderRadius.circular(8.0)),
              color: Colors.grey[200], // color de la targeta
              child: Row(
                // arreglo de children para colocar ambas targetas
                crossAxisAlignment:
                    CrossAxisAlignment.center, // se colocan centradas
                children: <Widget>[
                  // atributo children dodne iran
                  Container(
                    color: Colors.grey[900], // color del borde de la targeta
                    width: 10, // ancho
                  ),
                  SizedBox(
                    //separacion de 10 px
                    width: 10.0,
                  ),
                  Expanded(
                    child: GestureDetector(
                      //funcion que brinda a la targeta de dinamismo
                      onTap: () =>
                          Navigator.of(context).push(new MaterialPageRoute(
                        //al clickearla nos envia a la pagina streaming
                        builder: (BuildContext context) => StreamingPage(),
                      )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // centra el texto d ela targeta
                        crossAxisAlignment: CrossAxisAlignment
                            .center, // centra el texto d ela targeta
                        children: [
                          new ListTile(
                            contentPadding: EdgeInsets.only(left: 70),
                            title: new Text(
                              'LiveCams', //titulo de la targeta
                              style: TextStyle(
                                  fontSize: 25, color: Colors.grey[900]),
                            ),
                            leading: new Icon(
                              //icono de la targeta
                              Icons.filter_center_focus,
                              color: Colors.grey[900],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 25, // separaicon entre targetas
          ),
          Container(
              // esta targeta es practicamente lo mismo, con una variacion en la ruta y el nombre
              height: 254,
              child: new Card(
                elevation: 30,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                color: Colors.grey[200],
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      color: Colors.grey[900],
                      width: 10,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () =>
                            Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => GalleryPage(),
                        )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            new ListTile(
                              contentPadding: EdgeInsets.all(80),
                              title: new Text(
                                'Galeria',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.grey[900]),
                              ),
                              leading: new Icon(
                                Icons.crop_original,
                                color: Colors.grey[900],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ]),
      ),
      drawer: Drawer(
        // aqui empieza el menu lateral
        child: new ListView(
          // enlista los elementos enlistados
          children: <Widget>[
            // crea hijos para colocar los elemntos
            new UserAccountsDrawerHeader(
              // header del menu lateral
              accountName: new Text("DETLOS USER"), // titulo del header
              accountEmail: username != null
                  ? Text('$username')
                  : Text(
                      "NO USER FOUND"), // muestra el usuario que inicio sesion
            ),
            new ListTile(
              //elemento que te lleva a la configuracion de los url de las camaras
              title: new Text("Camaras"), // nombre del elemento clickeable
              trailing:
                  new Icon(Icons.filter_center_focus), //icono del elemento
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => CamerasPage(),
              )),
            ),
            new ListTile(
              //elemento para cerrar sesion
              title: new Text("Cerrar sesion"), // nombre del elemnto
              trailing: new Icon(Icons.logout),
              onTap: () => {
                sharedPreferences
                    .clear(), // al ser presionado limpia la informacion guardada en el dipositivo del usuario que inicio sesion
                // ignore: deprecated_member_use
                sharedPreferences
                    .commit(), // lleva a cabo los cambios en la memoria y notifica si hay un error
                Navigator.of(context).pushAndRemoveUntil(
                    // una vez limpiadada la sesion iniciada la pagina de inidio de sesion es colocada
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()),
                    (Route<dynamic> route) =>
                        false) // el false se coloca para deshabilitar la opcion de regreso, asi deberan iniciar sesion para acceder a otras funciones
              },
            ),
          ],
        ),
      ),
    );
  }
}
