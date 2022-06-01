import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bankdg/model/register_model.dart';
import 'package:bankdg/ressources/api_manager.dart';
import 'package:bankdg/service/data.dart';
import 'package:http/http.dart' as http;

Future<http.Response?> register(RegisterApi data) async {
  http.Response? response;
  try {
    response = await http.post(Uri.parse(Api.registerApi),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(data.toJson()));
  } catch (e) {
    log(e.toString());
  }
  return response;
}

Future<DataClass?> getAllRegister() async {
  DataClass? result;

  try {
    final response = await http.get(
      Uri.parse(Api.registerApiJson),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = DataClass.formJson(item);
    } else {
      print("error");
    }
  } catch (e) {
    log(e.toString());
  }
  // try {
  //   response = await http.post(Uri.parse(Api.registerApi),
  //       headers: {
  //         HttpHeaders.contentTypeHeader: "application/json",
  //       },
  //       body: jsonEncode(data.toJson()));
  // } catch (e) {
  //   log(e.toString());
  // }
  return result;
}
