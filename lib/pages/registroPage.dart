import 'package:flutter/material.dart';

class RegistroPage extends StatelessWidget {
  TextStyle estilo = TextStyle(color: Colors.white);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xff011e30),
        centerTitle: true,
        title: Text("Registro"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
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
                Expanded(child: Text('Nombre')),
                Expanded(child: TextField())
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(child: Text('Apellido')),
                Expanded(child: TextField())
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(child: Text('Usuario')),
                Expanded(child: TextField())
              ],
            ),
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
                Expanded(child: Text('Genero')),
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
            Row(
              children: [
                Expanded(child: Text('ConfirmarContra')),
                Expanded(
                    child: TextField(
                  obscureText: true,
                ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(child: Text('Crear cuenta'), onPressed: () {})
          ],
        ),
      ),
    );
  }
}
