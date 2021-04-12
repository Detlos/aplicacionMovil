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
  var correo,
      password,
      token; //variables que almacenaran informacion de los formularios
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
                  // formulario para el correo
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
                  // formulario para la contraseña
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
                  Navigator.push(
                      context, // nos lleva a la pagina de registro
                      MaterialPageRoute(builder: (context) => RegisterPage()))
                },
                child: Text(
                  //ruta para la pagina de registro
                  "Registrarse",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2661fa)),
                ),
              ),
            ),
            ElevatedButton(
                child: Text('Iniciar sesion'), // boton para el inicio de sesion
                onPressed: () {
                  AuthService().login(correo, password).then((val) async {
                    // funcion para el inicio de sesion
                    SharedPreferences sharedPreferences = await SharedPreferences
                        .getInstance(); // objeto que almacena la sesion con el token

                    if (val.data['success']) {
                      // si nos regresa un true este campo
                      sharedPreferences.setString(
                          "token", val.data['token']); // se almacena el token
                      sharedPreferences.setString("username",
                          val.data['respuesta']); // se almacena el usuario
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  MainPage()), //nos lleva a la pagina principal
                          (Route<dynamic> route) => false);
                      Fluttertoast.showToast(
                          //imprime el mensaje que nos retorna la peticion y la imprime en una flutter toast
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
