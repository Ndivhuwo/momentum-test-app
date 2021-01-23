import 'package:momentum_test/core/enumaration/view_state.dart';
import 'package:momentum_test/core/model/local_user.dart';
import 'package:momentum_test/core/services/authentication_service.dart';
import 'package:momentum_test/core/viewmodel/base_model.dart';

import '../../locator.dart';

class LoginModel extends BaseModel{
  final AuthenticationService _authenticationService =
  locator<AuthenticationService>();

  String errorMessage;

  void login(String emailText, String passwordText,
      final Function(LocalUser) navigateToHome) {
    setState(ViewState.Busy);

    errorMessage = null;
    bool emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailText);

    if (emailText.isEmpty || !emailValid) {
      errorMessage = 'Please Enter a valid Email';
      setState(ViewState.Idle);
    } else if (passwordText.isEmpty) {
      errorMessage = 'Please Enter Password';
      setState(ViewState.Idle);
    } else {
      _authenticationService.login(emailText, passwordText).then((userObj) {
        setState(ViewState.Idle);
        navigateToHome(userObj);
      }).catchError((error) {
        errorMessage = '${error.toString()}';
        setState(ViewState.Idle);
      });
    }
  }
}