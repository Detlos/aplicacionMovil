import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:integradora/pages/registroPage.dart';
import 'package:integradora/services/authservice.dart';
import 'package:integradora/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var correo, password, token;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff011e30),
        centerTitle: true,
        title: Text("DETLOS"),
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        width: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(labelText: 'Correo'),
                  onChanged: (val) {
                    correo = val;
                  },
                ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(labelText: 'Contraseña'),
                  onChanged: (val) {
                    password = val;
                  },
                  obscureText: true,
                ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage()))
                },
                child: Text(
                  "Registrarse",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2661fa)),
                ),
              ),
            ),
            ElevatedButton(
                child: Text('Iniciar sesion'),
                onPressed: () {
                  AuthService().login(correo, password).then((val) async {
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();

                    if (val.data['success']) {
                      sharedPreferences.setString("token", val.data['token']);
                      sharedPreferences.setString(
                          "username", val.data['respuesta']);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (BuildContext context) => MainPage()),
                          (Route<dynamic> route) => false);
                      Fluttertoast.showToast(
                          msg: val.data['msg'],
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  });
                })
          ],
        ),
      ),
    );
  }
}
