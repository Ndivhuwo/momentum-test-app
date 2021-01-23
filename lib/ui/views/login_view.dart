import 'package:flutter/material.dart';
import 'package:momentum_test/core/viewmodel/login_model.dart';
import 'package:momentum_test/ui/shared/app_colors.dart';
import 'package:momentum_test/ui/shared/ui_helper.dart';
import 'package:momentum_test/ui/widgets/login_content.dart';

import 'base_view.dart';

class LoginView extends StatelessWidget{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      builder: (BuildContext context, LoginModel model, Widget child) {
        return Scaffold(
            backgroundColor: widgetBgColor,
            body: NestedScrollView(
              physics:
              ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    iconTheme: IconThemeData(
                      color: widgetBgColor, //change your color here
                    ),
                    forceElevated: innerBoxIsScrolled,
                    backgroundColor: primaryColor,
                    title: Text("Login", style: TextStyle(color: textColorWhite),),
                  ),
                ];
              },
              body: ListView(
                children: <Widget>[
                  UIHelper.verticalSpaceMediumLarge(),
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 16.0),

                      child: LoginContent(
                        emailController: emailController,
                        passwordController: passwordController,
                        onClickLogin: () {
                          model.login(emailController.text, passwordController.text,
                                  (userObj) {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/', (Route<dynamic> route) => false,
                                    arguments: userObj);
                              });
                        },
                        errorMessage: model.errorMessage,
                        state: model.state,
                      ))
                ],
              ),
            )/**/
        );
      },
    );
  }
}