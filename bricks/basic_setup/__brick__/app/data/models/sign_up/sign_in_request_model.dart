class SignUpRequest {
  String? email;
  String? password;
  String? passwordConfirmation;
  String? fullName;
  String? deviceType;
  String? platform;
  String? deviceToken;
  String? phone;

  SignUpRequest({
    this.email,
    this.password,
    this.passwordConfirmation,
    this.fullName,
    this.deviceType,
    this.deviceToken,
    this.platform,
    this.phone,
  });

  SignUpRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
    fullName = json['full_name'];
    deviceType = json['device_type'];
    platform = json['platform'];
    deviceToken = json['device_token'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['password_confirmation'] = passwordConfirmation;
    data['full_name'] = fullName;
    data['device_type'] = deviceType;
    data['device_token'] = deviceToken;
    data['platform'] = platform;
    data['phone'] = phone;
    return data;
  }
}
