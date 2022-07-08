
class ConfigHTTP {
  /// Url
  static const String apiUrl = "http://192.168.43.90:8080";

  /// Page
  static const String pageUser = "/user";
  static const String pageAuth = "/auth";
  static const String pageLocation = "/location";
  static const String pageChat = "/chat";

  /// Auth
  static const String apiRegister = apiUrl + pageAuth + "/register";
  static const String apiLogin = apiUrl + pageAuth + "/login";
  static const String apiLoginGoogle = apiUrl + pageAuth + "/loginGoogle";

  /// User
  static const String apiGetUserProfile = apiUrl + pageUser + "/getUserProfileCurrent";
  static const String apiUpdateUserProfile = apiUrl + pageUser + "/updateUserProfileCurrent";
  static const String apiUploadImageUserProfile = apiUrl + pageUser + "/uploadImageUserProfile";
  static const String apiGetUserData = apiUrl + pageUser + "/getUserDataCurrent";
  static const String apiGetAllUserProfile = apiUrl + pageUser + "/getAllUserProfile";

  /// Location deleteLocation
  static const String apiCreateLocation = apiUrl + pageLocation + "/createLocation";
  static const String apiGetLocation = apiUrl + pageLocation + "/getLocation";
  static const String apiUpdateLocation= apiUrl + pageLocation + "/updateLocation";
  static const String apiUploadImageLocation = apiUrl + pageLocation + "/uploadImageLocation";
  static const String apiDeleteLocation = apiUrl + pageLocation + "/deleteLocation";

  /// Chat
  // chat room
  static const String apiCreateChatRoom = apiUrl + pageChat + "/createChatRoom";
  static const String apiGetChatRoomsByLocation = apiUrl + pageChat + "/getChatRoomsByLocation";
  static const String apiUpdateChatRoom = apiUrl + pageChat + "/updateChatRoom";
  static const String apiUploadImageChatRoom = apiUrl + pageChat + "/uploadImageChatRoom";
  static const String apiDeleteChatRoomById = apiUrl + pageChat + "/deleteChatRoomById";
  static const String apiDeleteChatRoomByLocation = apiUrl + pageChat + "/deleteChatRoomByLocation";
  // chat message
  static const String apiSendMessageInChatRoom = apiUrl + pageChat + "/saveMessageToChatRoom";
  static const String apiGetMessageInChatRoom = apiUrl + pageChat + "/getMessageByChatRoom";
  static const String apiDeleteMessageInChatRoom = apiUrl + pageChat + "/deleteMessageInChatRoom";
  static const String sendImageMessageToChatRoom = apiUrl + pageChat + "/getMessageByChatRoom";

}