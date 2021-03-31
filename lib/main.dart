import 'package:flutter/material.dart';
import 'package:integradora/pages/camarasPage.dart';
import 'package:integradora/pages/detailCamera.dart';
import 'package:integradora/pages/loginPage.dart';
import 'package:integradora/pages/streamingPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color(0xff011e30)),
      home: MainPage(),
      routes: {
        "camerasPage": (BuildContext context) => CamerasPage(),
        "detailCameras": (BuildContext context) => Detail(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  SharedPreferences sharedPreferences;
  String username;
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }
    username = sharedPreferences.getString('username');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Opciones Principales",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: 1000,
        margin: const EdgeInsets.all(10.0),
        child: Column(children: [
          Container(
            height: 250,
            child: Card(
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
                        builder: (BuildContext context) => StreamingPage(),
                      )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          new ListTile(
                            contentPadding: EdgeInsets.only(left: 70),
                            title: new Text(
                              'LiveCams',
                              style: TextStyle(
                                  fontSize: 25, color: Colors.grey[900]),
                            ),
                            leading: new Icon(
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
            height: 25,
          ),
          Container(
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
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("DETLOS USER"),
              accountEmail:
                  username != null ? Text('$username') : Text("NO USER FOUND"),
            ),
            new ListTile(
              title: new Text("Camaras"),
              trailing: new Icon(Icons.filter_center_focus),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => CamerasPage(),
              )),
            ),
            new ListTile(
              title: new Text("Cerrar sesion"),
              trailing: new Icon(Icons.logout),
              onTap: () => {
                sharedPreferences.clear(),
                // ignore: deprecated_member_use
                sharedPreferences.commit(),
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()),
                    (Route<dynamic> route) => false)
              },
            ),
          ],
        ),
      ),
    );
  }
}
