import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:momentum_test/core/enumaration/view_state.dart';
import 'package:momentum_test/core/model/account.dart';
import 'package:momentum_test/core/model/local_user.dart';
import 'package:momentum_test/core/services/momentum_api.dart';
import 'package:momentum_test/core/shared/core_helper.dart';
import 'package:momentum_test/core/viewmodel/base_model.dart';

import '../../locator.dart';

class AccountModel extends BaseModel {
  String errorMessage;
  final MomentumApi _momentumApi = locator<MomentumApi>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController balanceController =
      TextEditingController(text: "0.00");
  final TextEditingController overdraftController =
      TextEditingController(text: "0.00");
  final TextEditingController depositAmountController =
      TextEditingController(text: "0.00");
  final TextEditingController withdrawalAmountController =
      TextEditingController(text: "0.00");
  Account account;

  void addAccount(LocalUser user, Function onComplete) async {
    setState(ViewState.Busy);
    errorMessage = null;
    String addAccountErrorMessage = CoreHelper.validateAccount(
        nameController.text, accountNumberController.text);
    if (addAccountErrorMessage != null) {
      errorMessage = addAccountErrorMessage;
      setState(ViewState.Idle);
    } else {
      double balance = double.tryParse(balanceController.text);
      double overdraft = double.tryParse(overdraftController.text);
      Account account = Account(
          name: nameController.text,
          accountNumber: accountNumberController.text,
          balance: balance ?? 0.0,
          overdraft: overdraft ?? 0.00);

      _momentumApi
          .addAccount(user.idToken, user.localId, account)
          .then((addedAccount) {
        if (addedAccount == null) {
          errorMessage = "Something went wrong, please retry";
          setState(ViewState.Idle);
        } else {
          setState(ViewState.Idle);
          onComplete();
        }
      }).catchError((error) {
        errorMessage = '${error.toString()}';
        setState(ViewState.Idle);
      });
    }
  }

  void getAccountInfo(LocalUser user, String accountId) async {
    setState(ViewState.Busy);
    errorMessage = null;
    account = null;
    _momentumApi.getAccountInfo(user.idToken, accountId).then((account) {
      if (account == null) {
        errorMessage = "Something went wrong, please retry";
        setState(ViewState.Idle);
      } else {
        print("getAccountInfo: Account: ${json.encode(account.toJson())}");
        this.account = account;
        setState(ViewState.Idle);
      }
    }).catchError((error) {
      errorMessage = '${error.toString()}';
      setState(ViewState.Idle);
    });
  }

  void depositAmount(
      LocalUser user, String accountId, Function onComplete) async {
    setState(ViewState.Busy);
    errorMessage = null;
    String depositAmountErrorMessage =
        CoreHelper.validateAmount(depositAmountController.text, "Deposit");
    if (depositAmountErrorMessage != null) {
      errorMessage = depositAmountErrorMessage;
      setState(ViewState.Idle);
    } else {
      double depositAmount = double.tryParse(depositAmountController.text);

      _momentumApi
          .depositAmount(user.idToken, accountId, depositAmount)
          .then((nothing) {
        setState(ViewState.Idle);
        onComplete();
      }).catchError((error) {
        errorMessage = '${error.toString()}';
        setState(ViewState.Idle);
      });
    }
  }

  void withdrawAmount(
      LocalUser user, String accountId, Function onComplete) async {
    setState(ViewState.Busy);
    errorMessage = null;
    String withdrawAmountErrorMessage = CoreHelper.validateAmount(
        withdrawalAmountController.text, "Withdrawal");
    if (withdrawAmountErrorMessage != null) {
      errorMessage = withdrawAmountErrorMessage;
      setState(ViewState.Idle);
    } else {
      double withdrawAmount = double.tryParse(withdrawalAmountController.text);

      _momentumApi
          .withdrawAmount(user.idToken, accountId, withdrawAmount)
          .then((nothing) {
        setState(ViewState.Idle);
        onComplete();
      }).catchError((error) {
        errorMessage = '${error.toString()}';
        setState(ViewState.Idle);
      });
    }
  }
}
