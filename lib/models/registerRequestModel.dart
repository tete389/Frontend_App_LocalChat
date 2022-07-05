
class RegisterRequestModel {
  String? email;
  String? password;
  String? name;

  RegisterRequestModel({this.email, this.password, this.name});

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['name'] = this.name;
    return data;
  }
}