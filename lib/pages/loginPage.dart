import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle estilo = TextStyle(color: Colors.white);
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
                Expanded(child: Text('Correo')),
                Expanded(child: TextField())
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(child: Text('Contraseña')),
                Expanded(
                    child: TextField(
                  obscureText: true,
                ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(child: Text('Iniciar sesion'), onPressed: () {})
          ],
        ),
      ),
    );
  }
}
