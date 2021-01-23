import 'package:get_it/get_it.dart';
import 'package:momentum_test/core/viewmodel/account_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/services/authentication_service.dart';
import 'core/services/momentum_api.dart';
import 'core/viewmodel/home_model.dart';
import 'core/viewmodel/login_model.dart';

GetIt locator = GetIt.instance;

void setupLocator({SharedPreferences sharedPreferences}) {
  locator.registerLazySingleton(() => sharedPreferences);
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => MomentumApi());
  locator.registerLazySingleton(() => LoginModel());
  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => AccountModel());
}