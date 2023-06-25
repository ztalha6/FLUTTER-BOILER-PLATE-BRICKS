class ChangePasswordRequest {
  String? currentPassword;
  String? password;
  String? passwordConfirmation;

  ChangePasswordRequest({
    this.currentPassword,
    this.password,
    this.passwordConfirmation,
  });

  ChangePasswordRequest.fromJson(Map<String, dynamic> json) {
    currentPassword = json['current_password'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_password'] = currentPassword;
    data['password'] = password;
    data['password_confirmation'] = passwordConfirmation;
    return data;
  }
}
