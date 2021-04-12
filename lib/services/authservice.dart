import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  Dio dio = new Dio();

  login(correo, password) async {
    //funcion para la peticion de inicio de sesion
    try {
      return await dio.post('https://img-detlos.herokuapp.com/login',
          data: {"correo": correo, "password": password});
    } catch (e) {
      if (e is DioError) {
        //This is the custom message coming from the backend
        Fluttertoast.showToast(
            msg: e.response.data['msg'], //si hay un problema imprime el error
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        throw Exception("Error");
      }
    }
  }

  registerUser(data) async {
    //funcion para el registro de usuarios
    try {
      return await dio.post('https://img-detlos.herokuapp.com/register',
          data: data);
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data['msg'], //si hay un problema imprime el error
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
