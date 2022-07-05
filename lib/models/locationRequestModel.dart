class LocationRequestModel {
  String? ldId;
  String? ldAddress;
  double? ldLongitude;
  String? ldDetail;
  String? ldName;
  double? ldLatitude;
  String? ldImage;

  LocationRequestModel(
      {this.ldId,
        this.ldAddress,
        this.ldLongitude,
        this.ldDetail,
        this.ldName,
        this.ldLatitude,
        this.ldImage});

  LocationRequestModel.fromJson(Map<String, dynamic> json) {
    ldId = json['ldId'];
    ldAddress = json['ldAddress'];
    ldLongitude = json['ldLongitude'];
    ldDetail = json['ldDetail'];
    ldName = json['ldName'];
    ldLatitude = json['ldLatitude'];
    ldImage = json['ldImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ldId'] = ldId;
    data['ldAddress'] = ldAddress;
    data['ldLongitude'] = ldLongitude;
    data['ldDetail'] = ldDetail;
    data['ldName'] = ldName;
    data['ldLatitude'] = ldLatitude;
    data['ldImage'] = ldImage;
    return data;
  }
}
