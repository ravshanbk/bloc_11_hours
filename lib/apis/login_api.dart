
import 'package:bloc11hours/models.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class LoginApiProticol {
  const LoginApiProticol();
  Future<LoginHandle?> login({
    required String email,
    required String password,
  });
}

@immutable
class LoginApi implements LoginApiProticol {
  // singleton pattern
  // const LoginApi._sharedInstance();
  // static const LoginApi _shared = LoginApi._sharedInstance();
  // factory LoginApi.instance() => _shared;

  @override
  Future<LoginHandle?> login({
    required String email,
    required String password,
  }) =>
      Future.delayed(
        Duration(seconds: 2),()=> email == 'foo@bar.com'&& password == 'foobar',
      ).then((isLoggedIn) =>isLoggedIn ? const LoginHandle.fooBar():null);
}
