import 'package:flutter/material.dart';
import 'package:momentum_test/core/enumaration/view_state.dart';
import 'package:momentum_test/ui/shared/app_colors.dart';
import 'package:momentum_test/ui/shared/text_styles.dart';
import 'package:momentum_test/ui/shared/ui_helper.dart';

import 'email_text_field.dart';
import 'password_text_field.dart';

class LoginContent extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String errorMessage;
  final ViewState state;
  final Function onClickLogin;

  const LoginContent(
      {Key key,
        this.emailController,
        this.passwordController,
        this.errorMessage,
        this.state,
        this.onClickLogin,
        })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          decoration: new BoxDecoration(
            color: primaryColor,
            borderRadius: new BorderRadius.all(
                Radius.circular(5.0)),
            boxShadow: [
              BoxShadow(
                color: textColorGrey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(
                    0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              UIHelper.verticalSpaceXSmall(),
              EmailTextField(
                  hint: "Email Address",
                  controller: emailController,
                  boarder: true,
                  color: widgetBgColor,
                  horizontalPadding: 0,
                  horizontalContentPadding: 16),
              UIHelper.verticalSpaceMedium(),
              PasswordTextField(
                hint: "Password",
                controller: passwordController,
                color: widgetBgColor,
                boarder: true,
                horizontalPadding: 0,
                horizontalContentPadding: 16,
              ),
              UIHelper.verticalSpaceXSmall(),
            ],
          ),
        ),
        UIHelper.verticalSpaceMedium(),
        errorMessage != null
            ? Center(
            child: Text(
              errorMessage,
              style: errorStyleRed,
              textAlign: TextAlign.center,
            ))
            : Container(),
        UIHelper.verticalSpaceMedium(),
        state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : SizedBox(
            width: 300,
            height: 50,
            child: Container(
              child: RaisedButton(
                  color: secondaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    'Login',
                    style: titleStyleWhite,
                  ),
                  onPressed: onClickLogin),
            )),
        UIHelper.verticalSpaceMedium(),
      ],
    );
  }
}