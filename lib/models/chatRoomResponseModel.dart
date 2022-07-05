class ChatRoomResponseModel {
  List<ResultChatRoom>? resultChatRoom;

  ChatRoomResponseModel({this.resultChatRoom});

  ChatRoomResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      resultChatRoom = <ResultChatRoom>[];
      json['result'].forEach((v) {
        resultChatRoom!.add(new ResultChatRoom.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resultChatRoom != null) {
      data['result'] = this.resultChatRoom!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultChatRoom {
  String? crId;
  String? crName;
  String? crImage;
  String? crLocationId;

  ResultChatRoom({this.crId, this.crName, this.crImage, this.crLocationId});

  ResultChatRoom.fromJson(Map<String, dynamic> json) {
    crId = json['crId'];
    crName = json['crName'];
    crImage = json['crImage'];
    crLocationId = json['crLocationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['crId'] = this.crId;
    data['crName'] = this.crName;
    data['crImage'] = this.crImage;
    data['crLocationId'] = this.crLocationId;
    return data;
  }
}
