class ResetPasswordRequest {
  String? email;
  int? otpCode;
  String? password;
  String? passwordConfirmation;

  ResetPasswordRequest({
    this.email,
    this.otpCode,
    this.password,
    this.passwordConfirmation,
  });

  ResetPasswordRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    otpCode = json['otp_code'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['otp_code'] = otpCode;
    data['password'] = password;
    data['password_confirmation'] = passwordConfirmation;
    return data;
  }
}
