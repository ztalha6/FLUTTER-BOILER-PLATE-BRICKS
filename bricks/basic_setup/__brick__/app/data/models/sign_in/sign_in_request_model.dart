class AccessRequest {
  String? email;
  String? password;
  String? deviceType;
  String? deviceToken;
  String? platform;
  String? username;
  String? fullName;
  String? socialPlatform;
  String? clientId;
  String? token;

  AccessRequest({
    this.email,
    this.password,
    this.deviceType,
    this.platform,
    this.deviceToken,
    this.username,
    this.fullName,
    this.socialPlatform,
    this.clientId,
    this.token,
  });

  AccessRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    deviceType = json['device_type'];
    platform = json['platform'];
    deviceToken = json['device_token'];
    username = json['username'];
    fullName = json['full_name'];
    socialPlatform = json['social_platform'];
    clientId = json['client_id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['device_type'] = deviceType;
    data['platform'] = platform;
    data['device_token'] = deviceToken;
    data['username'] = username;
    data['full_name'] = fullName;
    data['social_platform'] = socialPlatform;
    data['client_id'] = clientId;
    data['token'] = token;
    return data;
  }
}
