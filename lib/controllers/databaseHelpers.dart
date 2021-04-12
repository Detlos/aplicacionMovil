import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DataBaseHelper {
  Dio dio = new Dio();
  //funciton getData

  //funcion para agregar urls nuevas
  Future<void> addIp(String username) async {
    final prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username');
    try {
      return await dio.post('https://img-detlos.herokuapp.com/insert_hardware',
          data: {"username": username}); // envia el username
    } on DioError catch (e) {
      // si hay un error lo imprime
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //funcion para la edicion de una url
  Future<void> editarCamara(String indice, String ip) async {
    final prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username');
    try {
      return await dio.put('https://img-detlos.herokuapp.com/edit_hardware',
          data: {
            "username": username,
            "ip": ip,
            "indice": indice
          }); //envia el username, ip e indice
    } on DioError catch (e) {
      // si hay un error, imprime el error
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //funcion para eliminar registros
  Future<void> removeRegister(String indice, String username) async {
    try {
      //funcion para realizar la peticion para eliminar un registro
      return await dio.put('https://img-detlos.herokuapp.com/delete_hardware',
          data: {
            "indice": indice,
            "username": username
          }); //envia el username e indice
    } on DioError catch (e) {
      //si hay un error muestra un mensaje imprimiendolo
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
