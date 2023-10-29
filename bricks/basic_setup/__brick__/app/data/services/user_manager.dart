import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

abstract class IUserRepository {
  Future<bool> saveUser(User user);
  Future<bool> updateUser(User user);
  Future<User?> getUser();
}

class UserManager implements IUserRepository {
  static final UserManager _singleton = UserManager._internal();

  factory UserManager() {
    return _singleton;
  }

  UserManager._internal();
  static const String _keyUser = '_keyUser';

  @override
  Future<User?> getUser() async {
    final String savedUserString =
        (await SharedPreferences.getInstance()).getString(_keyUser) ?? '';
    return savedUserString.isNotEmpty
        ? User.fromJson(json.decode(savedUserString))
        : null;
  }

  @override
  Future<bool> saveUser(User user) async {
    return (await SharedPreferences.getInstance()).setString(
      _keyUser,
      json.encode(user.toJson()),
    );
  }

  @override
  Future<bool> updateUser(User newUser) async {
    final User? user = await getUser();
    if (user != null) {
      if (newUser.name != null) {
        user.name = newUser.name;
      }
      saveUser(user);
      return true;
    }
    return false;
  }
}
