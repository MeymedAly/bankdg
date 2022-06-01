import 'dart:convert';

import 'package:bankdg/model/login_model.dart';
import 'package:bankdg/ressources/api_manager.dart';
import 'package:http/http.dart';

class ApiLoginService {
  Future getApi() async {
    var utilisateur_list = [];
    var path = Uri.parse(Api.loginApi);
    var response = await get(path);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (Map<String, dynamic> item in data) {
        utilisateur_list.add(ApiLoginModel.formJson(item));
      }
    }
    return utilisateur_list;
  }
}
