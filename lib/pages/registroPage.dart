import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:integradora/services/authservice.dart';
import 'package:flutter/services.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var email, password, name, lastName, gender, verification, userName;
  List _genero = ["Hombre", "Mujer"];
  String currentValue = "Hombre";
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
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(labelText: 'Nombre'),
                  onChanged: (val) {
                    name = val;
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
                  decoration: InputDecoration(labelText: 'Apellido'),
                  onChanged: (val) {
                    lastName = val;
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
                  decoration: InputDecoration(labelText: 'Username'),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-z A-Z 0-9]")),
                    LengthLimitingTextInputFormatter(15)
                  ],
                  onChanged: (val) {
                    userName = val;
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
                  decoration: InputDecoration(labelText: 'Correo'),
                  onChanged: (val) {
                    email = val;
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
                    child: DropdownButton(
                  value: currentValue,
                  hint: Text("Genero"),
                  isExpanded: true,
                  onChanged: (value) {
                    setState(() {
                      currentValue = value;
                      if (currentValue == "Hombre") {
                        gender = "1";
                      } else {
                        gender = "0";
                      }
                    });
                  },
                  items: _genero.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
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
            Row(
              children: [
                Expanded(
                    child: TextField(
                  decoration:
                      InputDecoration(labelText: 'Confirmar contraseña'),
                  onChanged: (val) {
                    verification = val;
                  },
                  obscureText: true,
                ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                child: Text('Crear cuenta'),
                onPressed: () {
                  if (password == verification) {
                    Map<String, dynamic> data = {
                      'username': userName,
                      'email': email,
                      'password': password,
                      'nombre': name,
                      'apellido': lastName,
                      'genero': gender
                    };
                    AuthService().registerUser(data).then((val) {
                      if (val.data['success']) {
                        print("prueba1");
                        Fluttertoast.showToast(
                            msg: val.data['msg'],
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    });
                  } else {
                    Fluttertoast.showToast(
                        msg: 'Las contrseñas no coinciden',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                })
          ],
        ),
      ),
    );
  }
}
