import 'dart:async';
import 'package:flutter/material.dart';
import 'package:momentum_test/ui/shared/ui_helper.dart';
import 'package:momentum_test/ui/widgets/plain_text_field.dart';

import '../shared/app_colors.dart';
import '../shared/text_styles.dart';

class AddAccountContent extends StatelessWidget {
  final String errorMessage;
  final Function onClickAddAccount;
  final TextEditingController nameController;
  final TextEditingController accountNumberController;
  final TextEditingController balanceController;
  final TextEditingController overdraftController;


  AddAccountContent(
      {this.errorMessage,
      this.onClickAddAccount,
      this.nameController,
      this.accountNumberController,
      this.balanceController,
      this.overdraftController});

  @override
  Widget build(BuildContext context) {
    double widgetWidth = 400;
    return Column(
      children: [
        UIHelper.verticalSpaceMedium(),
        PlainTextField(
          controller: nameController,
          boarder: true,
          hint: "Account Name",
          horizontalPadding: 0,
          horizontalContentPadding: 16,
          customHint: false,
          borderRadiusPresent: true,
          width: widgetWidth,
          color: widgetBgColor,
        ),
        UIHelper.verticalSpaceSmall(),
        PlainTextField(
          controller: accountNumberController,
          boarder: true,
          hint: "Account Number",
          horizontalPadding: 0,
          horizontalContentPadding: 16,
          customHint: false,
          borderRadiusPresent: true,
          width: widgetWidth,
          color: widgetBgColor,
        ),
        UIHelper.verticalSpaceSmall(),
        PlainTextField(
          controller: balanceController,
          boarder: true,
          hint: "Initial Balance",
          horizontalPadding: 0,
          horizontalContentPadding: 16,
          customHint: false,
          borderRadiusPresent: true,
          width: widgetWidth,
          color: widgetBgColor,
        ),
        UIHelper.verticalSpaceSmall(),
        PlainTextField(
          controller: overdraftController,
          boarder: true,
          hint: "Initial Overdraft",
          horizontalPadding: 0,
          horizontalContentPadding: 16,
          customHint: false,
          borderRadiusPresent: true,
          width: widgetWidth,
          color: widgetBgColor,
        ),
        UIHelper.verticalSpaceMedium(),
        errorMessage != null
            ? Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        )
            : Container(),
        UIHelper.verticalSpaceMedium(),
        SizedBox(
          width: 300,
          height: 50,
          child: Container(
            child: RaisedButton(
                color: secondaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: Text('Save Account',
                  style: titleStyleWhite,
                ),
              onPressed: onClickAddAccount, ),
          ),
        ),
      ],
    );
  }
}
