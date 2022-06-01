class RegisterApi {
  //String id;
  String firstName;
  String lastName;
  String email;
  String password;

  RegisterApi({
    //required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["first_name"] = firstName;
    data["last_name"] = lastName;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
