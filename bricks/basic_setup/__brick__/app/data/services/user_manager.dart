import '../models/user_model.dart';

abstract class IUserRepository {
  Future<bool> saveUser(User user);
  Future<bool> updateUser(User user);
  Future<User> getUser();
}

class UserManager implements IUserRepository {
  static final UserManager _singleton = UserManager._internal();

  factory UserManager() {
    return _singleton;
  }

  UserManager._internal();
  static const String _keyUser = '_keyUser';

  @override
  Future<User> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<bool> saveUser(User user) {
    // TODO: implement saveUser
    throw UnimplementedError();
  }

  @override
  Future<bool> updateUser(User user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
