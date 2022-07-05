
import 'configHTTP.dart';

class ConfigImageUrl {

  //var url = ConfigHTTP.apiUrl;
  /// Url
  static const String apiUrl = "http://192.168.4.140:8080";
  static const String imagePath = "/upload";

  //ImageCall
  static const String imageChatRoom = apiUrl + imagePath + "/imgChatRoom/";
  static const String imageUserProfile = apiUrl + imagePath + "/imgUserProfile/";
  static const String imageChatMessage = apiUrl + imagePath + "/imgChatMessage/";
  static const String imageLocation = apiUrl + imagePath + "/imgLocationData/";

}