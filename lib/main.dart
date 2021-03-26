import 'package:flutter/material.dart';
import 'package:integradora/pages/camarasPage.dart';
import 'package:integradora/pages/detailCamera.dart';
import 'package:integradora/pages/loginPage.dart';
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
          "Integradora",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Main Page"),
      ),
      drawer: Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("DETLOS USER"),
              accountEmail:
                  username != null ? Text('$username') : Text("NOUSERFOUND"),
            ),
            new ListTile(
              title: new Text("Camaras"),
              trailing: new Icon(Icons.filter_center_focus),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => CamerasPage(),
              )),
            ),
            new ListTile(
              title: new Text("Perfil"),
              trailing: new Icon(Icons.account_box),
              // onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              //   builder: (BuildContext context) => AddDataProduct(),
              // )),
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
