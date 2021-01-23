import 'dart:async';
import 'dart:convert';

import 'package:momentum_test/core/model/local_user.dart';
import 'package:momentum_test/core/model/login_request.dart';
import 'package:momentum_test/core/shared/core_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../locator.dart';
import 'momentum_api.dart';

class AuthenticationService {
  SharedPreferences sharedPreferences = locator<SharedPreferences>();
  MomentumApi momentumApi = locator<MomentumApi>();
  StreamController<LocalUser> userController = StreamController<LocalUser>();

  LocalUser getLocalUser() {
    final String savedUser =
        sharedPreferences.getString(CoreHelper.savedUserKey);
    if (savedUser != null) {
      LocalUser clientUserDto = LocalUser.fromJson(json.decode(savedUser));
      return clientUserDto;
    } else {
      return LocalUser.initial();
    }
  }

  Future<LocalUser> login(String email, String password) async {
    var user;
    LoginRequest loginRequest = LoginRequest(email: email, password: password);

    var localUser = await momentumApi.login(loginRequest);
    if (localUser != null) {
      print(
          "AuthenticationService login User Obj: ${json.encode(localUser.toJson())}");
      userController.add(localUser);
      await sharedPreferences.setString(
          CoreHelper.savedUserKey, json.encode(localUser.toJson()));
      user = localUser;
    }
    return user;
  }
}
