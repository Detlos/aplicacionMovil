import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DataBaseHelper {
  var status;
  var token;
  Dio dio = new Dio();
  String serverUrlproducts = "http://192.168.1.69:3000/products";

  //funciton getData
  Future<List> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrlproducts";
    http.Response response = await http.get(myUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    });
    return json.decode(response.body);
    // print(response.body);
  }

  //function for register products
  Future<void> addIp(String username) async {
    final prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username');
    try {
      return await dio.post('https://img-detlos.herokuapp.com/insert_hardware',
          data: {"username": username});
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

  //function for update or put
  Future<void> editarCamara(String indice, String ip) async {
    final prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username');
    try {
      return await dio.put('https://img-detlos.herokuapp.com/edit_hardware',
          data: {"username": username, "ip": ip, "indice": indice});
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

  //function for delete
  Future<void> removeRegister(String indice, String username) async {
    try {
      return await dio.put('https://img-detlos.herokuapp.com/delete_hardware',
          data: {"indice": indice, "username": username});
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

//function read
  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    print('read : $value');
  }
}
