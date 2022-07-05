
class UserProfileResponseModel {
  String? upId;
  String? upName;
  String? upStatus;
  String? upImage;

  UserProfileResponseModel({this.upId, this.upName, this.upStatus, this.upImage});

  UserProfileResponseModel.fromJson(Map<String, dynamic> json) {
    upId = json['upId'];
    upName = json['upName'];
    upStatus = json['upStatus'];
    upImage = json['upImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['upId'] = this.upId;
    data['upName'] = this.upName;
    data['upStatus'] = this.upStatus;
    data['upImage'] = this.upImage;
    return data;
  }
}