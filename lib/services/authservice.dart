import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  Dio dio = new Dio();

  login(correo, password) async {
    try {
      return await dio.post('https://img-detlos.herokuapp.com/login',
          data: {"correo": correo, "password": password});
    } catch (e) {
      if (e is DioError) {
        //This is the custom message coming from the backend
        Fluttertoast.showToast(
            msg: e.response.data['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        throw Exception("Error");
      }
      // on DioError catch (e) {
      //   print(e);
      //   Fluttertoast.showToast(
      //       msg: e.response.data['msg'],
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.BOTTOM,
      //       backgroundColor: Colors.red,
      //       textColor: Colors.white,
      //       fontSize: 16.0);
      // }
    }
  }

  registerUser(data) async {
    try {
      return await dio.post('https://img-detlos.herokuapp.com/register',
          data: data);
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
