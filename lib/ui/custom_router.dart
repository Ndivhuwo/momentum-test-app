import 'package:flutter/material.dart';
import 'package:momentum_test/ui/views/add_account_view.dart';

import 'views/account_view.dart';
import 'views/home_view.dart';
import 'views/login_view.dart';

class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case "login" :
        return MaterialPageRoute(builder: (_) => LoginView());
      case "/" :
        return MaterialPageRoute(builder: (_) => HomeView());
      case "addAccount" :
        return MaterialPageRoute(builder: (_) => AddAccountView());
      case "account" :
        var accountId = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => AccountView(accountId: accountId,));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }
}