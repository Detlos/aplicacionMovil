import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:integradora/services/authservice.dart';
import 'package:flutter/services.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var email,
      password,
      name,
      lastName,
      gender,
      verification,
      userName; // variables con los valores para el registro
  List _genero = ["Hombre", "Mujer"]; // valores para el option list
  String currentValue = "Hombre"; // valor por defecto del option list
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
                  // formulario para el nombre
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
                  // formulario para el apellido
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
                  // formulario para el nombre de usuario
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
                  // formulario para el correo
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
                  // formulario de opciones para el genero
                  value: currentValue, // valor por defecto
                  hint: Text("Genero"), // muestra por defecto Genero
                  isExpanded: true, // expande el formulario
                  onChanged: (value) {
                    setState(() {
                      currentValue = value; // current value sera igual a value
                      if (currentValue == "Hombre") {
                        gender =
                            "1"; // si el valor actual es igual a Hombre devuelve 1
                      } else {
                        gender = "0"; //si no devuelve 0
                      }
                    });
                  },
                  items: _genero.map((value) {
                    // mapea los valores
                    return DropdownMenuItem(
                      // devuelve un dropdownmenu
                      value: value, // value sera igual al value seleccionado
                      child: Text(value), //mostrara el value
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
            Row(
              children: [
                Expanded(
                    child: TextField(
                  // formulario para la confirmacion de la contraseña
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
                child: Text('Crear cuenta'), // boton para crear la cuenta
                onPressed: () {
                  if (password == verification) {
                    // si los contraseñas son correctas mapea los valores en un diccionario
                    Map<String, dynamic> data = {
                      'username': userName,
                      'email': email,
                      'password': password,
                      'nombre': name,
                      'apellido': lastName,
                      'genero': gender
                    };
                    AuthService().registerUser(data).then((val) {
                      //funcion para la peticion de registro
                      if (val.data['success']) {
                        //si se lleva a cabo con exito imprime el mensaje
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
                        // si las contraseñas no coinciden imprime que un mensaje indicandolo
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
