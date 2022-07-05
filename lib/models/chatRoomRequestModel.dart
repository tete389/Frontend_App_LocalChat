class ChatRoomRequestModel {
  String? crId;
  String? crName;
  String? crLocationId;

  ChatRoomRequestModel({this.crId, this.crName, this.crLocationId});

  ChatRoomRequestModel.fromJson(Map<String, dynamic> json) {
    crId = json['crId'];
    crName = json['crName'];
    crLocationId = json['crLocationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['crId'] = crId;
    data['crName'] = crName;
    data['crLocationId'] = crLocationId;
    return data;
  }
}
