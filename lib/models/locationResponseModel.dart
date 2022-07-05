class LocationResponseModel {
  List<ResultLocation>? result;

  LocationResponseModel({this.result});

  LocationResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <ResultLocation>[];
      json['result'].forEach((v) {
        result!.add(ResultLocation.fromJson(v));
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

class ResultLocation {
  String? ldId;
  String? ldName;
  String? ldAddress;
  double? ldLatitude;
  double? ldLongitude;
  String? ldImage;
  String? ldDetail;

  ResultLocation(
      {this.ldId,
      this.ldName,
      this.ldAddress,
      this.ldLatitude,
      this.ldLongitude,
      this.ldImage,
      this.ldDetail});

  ResultLocation.fromJson(Map<String, dynamic> json) {
    ldId = json['ldId'];
    ldName = json['ldName'];
    ldAddress = json['ldAddress'];
    ldLatitude = json['ldLatitude'];
    ldLongitude = json['ldLongitude'];
    ldImage = json['ldImage'];
    ldDetail = json['ldDetail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ldId'] = this.ldId;
    data['ldName'] = this.ldName;
    data['ldAddress'] = this.ldAddress;
    data['ldLatitude'] = this.ldLatitude;
    data['ldLongitude'] = this.ldLongitude;
    data['ldImage'] = this.ldImage;
    data['ldDetail'] = this.ldDetail;
    return data;
  }
}
