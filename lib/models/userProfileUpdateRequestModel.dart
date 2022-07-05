class UserProfileUpdateRequestModel {
  String? name;
  String? status;
  String? image;

  UserProfileUpdateRequestModel({this.name, this.status, this.image});

  UserProfileUpdateRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    status = json['status'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['status'] = this.status;
    data['image'] = this.image;
    return data;
  }
}
