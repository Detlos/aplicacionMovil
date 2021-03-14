import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:integradora/services/authservice.dart';

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
        title: Text("Inicio de sesion"),
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
            ElevatedButton(
                child: Text('Iniciar sesion'),
                onPressed: () {
                  AuthService().login(correo, password).then((val) {
                    if (val.data['success']) {
                      token = val.data['token'];
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
