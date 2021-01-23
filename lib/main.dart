import 'package:flutter/material.dart';
import 'package:momentum_test/ui/shared/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/model/local_user.dart';
import 'core/services/authentication_service.dart';
import 'locator.dart';
import 'ui/custom_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  setupLocator(sharedPreferences: sharedPreferences);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<LocalUser>(
        initialData: locator<AuthenticationService>().getLocalUser(),
        create: (context) =>
        locator<AuthenticationService>().userController.stream,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Momentum Test App',
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: primaryColor,
            canvasColor: lightShadowColor,
          ),
          initialRoute: 'login',
          onGenerateRoute: CustomRouter.generateRoute,
        ));
  }
}