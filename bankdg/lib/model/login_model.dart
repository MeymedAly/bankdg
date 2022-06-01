class ApiLoginModel {
  String id;
  String email;
  String motDePasse;

  ApiLoginModel(
      {required this.id, required this.email, required this.motDePasse});

  factory ApiLoginModel.formJson(Map<String, dynamic> json) => ApiLoginModel(
      id: json["id"], email: json["email"], motDePasse: json["motDePasse"]);
}
