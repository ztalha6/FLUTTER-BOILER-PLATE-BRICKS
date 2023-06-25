import '../response_model.dart';
import '../user_model.dart';

class OtpRespponse extends BaseApiResponse {
  Data? data;

  OtpRespponse({this.data});

  OtpRespponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = hasError
        ? null
        : json['data'] != null
            ? Data.fromJson(json['data'])
            : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
