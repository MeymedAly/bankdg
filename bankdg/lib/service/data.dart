import 'package:bankdg/controller/register_controler.dart';
import 'package:bankdg/model/register_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataClass extends ChangeNotifier {
  bool loading = false;
  bool isBack = false;
  Future<void> postData(RegisterApi body) async {
    loading = true;
    notifyListeners();
    http.Response response = (await register(body))!;
    if (response.statusCode == 200) {
      isBack = false;
    }
    loading = false;
    notifyListeners();
  }

  DataClass? post;
  getPostData() async {
    loading = true;
    post = (await getAllRegister())!;
    loading = false;

    notifyListeners();
  }

  static DataClass? formJson(item) {
    return null;
  }
}
