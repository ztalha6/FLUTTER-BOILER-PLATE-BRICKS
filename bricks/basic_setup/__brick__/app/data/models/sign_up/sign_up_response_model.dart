import '../response_model.dart';
import '../user_model.dart';

class AccessResponse extends BaseApiResponse {
  Data? data;

  AccessResponse({this.data});

  AccessResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] is List) {
      data = null;
    } else {
      data = json['data'] != null ? Data.fromJson(json['data']) : null;
    }
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
  AccessToken? accessToken;
  User? user;

  Data({this.accessToken, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'] != null
        ? AccessToken.fromJson(json['access_token'])
        : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (accessToken != null) {
      data['access_token'] = accessToken!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class AccessToken {
  String? type;
  String? token;

  AccessToken({this.type, this.token});

  AccessToken.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['token'] = token;
    return data;
  }
}

class Meta {
  int? pivotRoleId;
  int? pivotModuleId;
  int? pivotCreate;
  int? pivotRead;
  int? pivotUpdate;
  int? pivotDelete;

  Meta({
    this.pivotRoleId,
    this.pivotModuleId,
    this.pivotCreate,
    this.pivotRead,
    this.pivotUpdate,
    this.pivotDelete,
  });

  Meta.fromJson(Map<String, dynamic> json) {
    pivotRoleId = json['pivot_role_id'];
    pivotModuleId = json['pivot_module_id'];
    pivotCreate = json['pivot_create'];
    pivotRead = json['pivot_read'];
    pivotUpdate = json['pivot_update'];
    pivotDelete = json['pivot_delete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pivot_role_id'] = pivotRoleId;
    data['pivot_module_id'] = pivotModuleId;
    data['pivot_create'] = pivotCreate;
    data['pivot_read'] = pivotRead;
    data['pivot_update'] = pivotUpdate;
    data['pivot_delete'] = pivotDelete;
    return data;
  }
}
