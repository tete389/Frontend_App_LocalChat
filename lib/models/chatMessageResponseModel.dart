
import 'package:intl/intl.dart';

class ChatMessageResponseModel {
  List<Result>? result;

  ChatMessageResponseModel({this.result});

  ChatMessageResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  DateTime? cmCreated;
  String? cmId;
  String? cmMessage;
  bool? cmStatus;
  String? cmChatRoomId;
  String? cmImage;
  String? cmTypeMessage;
  String? upImage;
  String? upName;
  String? upStatus;
  String? cmUserProfileId;

  Result(
      {this.cmCreated,
        this.cmId,
        this.cmMessage,
        this.cmStatus,
        this.cmChatRoomId,
        this.cmImage,
        this.cmTypeMessage,
        this.upImage,
        this.upName,
        this.upStatus,
        this.cmUserProfileId});

  Result.fromJson(Map<String, dynamic> json) {
    cmCreated =  DateFormat("yyyy-MM-dd hh:mm:ss").parse(json['cm_Created']);
    cmId = json['cm_Id'];
    cmMessage = json['cm_Message'];
    cmStatus = json['cm_Status'];
    cmChatRoomId = json['cm_Chat_Room_Id'];
    cmImage = json['cm_Image'];
    cmTypeMessage = json['cm_Type_Message'];
    upImage = json['up_Image'];
    upName = json['up_Name'];
    upStatus = json['up_Status'];
    cmUserProfileId = json['cm_User_Profile_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cm_Created'] = cmCreated;
    data['cm_Id'] = cmId;
    data['cm_Message'] = cmMessage;
    data['cm_Status'] = cmStatus;
    data['cm_Chat_Room_Id'] = cmChatRoomId;
    data['cm_Image'] = cmImage;
    data['cm_Type_Message'] = cmTypeMessage;
    data['up_Image'] = upImage;
    data['up_Name'] = upName;
    data['up_Status'] = upStatus;
    data['cm_User_Profile_Id'] = cmUserProfileId;
    return data;
  }
}
