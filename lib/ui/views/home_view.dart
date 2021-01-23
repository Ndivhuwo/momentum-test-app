import 'package:flutter/material.dart';
import 'package:momentum_test/core/enumaration/view_state.dart';
import 'package:momentum_test/core/model/account.dart';
import 'package:momentum_test/core/model/client_details.dart';
import 'package:momentum_test/core/model/local_user.dart';
import 'package:momentum_test/core/viewmodel/home_model.dart';
import 'package:momentum_test/ui/shared/app_colors.dart';
import 'package:momentum_test/ui/shared/text_styles.dart';
import 'package:momentum_test/ui/shared/ui_helper.dart';
import 'package:momentum_test/ui/widgets/account_item.dart';
import 'package:provider/provider.dart';

import 'base_view.dart';

class HomeView extends StatelessWidget{
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    LocalUser user = Provider.of<LocalUser>(context, listen: true);
    return BaseView<HomeModel>(
      onModelReady: (model) {
        model.getClientDetails(user);
      },
      builder: (context, model, child) => Scaffold(
        backgroundColor: widgetBgColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: widgetBgColor),
          title: Text("My Accounts", style: appBarTitleStyle),
          backgroundColor: primaryColor,
        ),
        body: Container(
          //padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              UIHelper.verticalSpaceMedium(),
              model.errorMessage != null
                  ? Container(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    model.errorMessage,
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ))
                  : Container(),
              UIHelper.verticalSpaceSmall(),
              model.state == ViewState.Busy
                  ? Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
                  : model.accounts != null && model.accounts.isNotEmpty
                  ? Expanded(
                child: getClientDetailsUi(model.accounts, context,
                    model, _refreshIndicatorKey, user),
              )
                  : Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "No Accounts added yet. Please add your first account by clicking the add button below.",
                      style: appSubHeaderStyle,
                      textAlign: TextAlign.center,
                    ),
                  )),
              UIHelper.verticalSpaceSmall(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Container(
                      child: RaisedButton(
                          color: secondaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'Add Account',
                            style: titleStyleWhite,
                          ),
                          onPressed: () async {
                            await Navigator.pushNamed(context, 'addAccount');
                            model.getClientDetails(user);
                          }),
                    )),
              ),
              UIHelper.verticalSpaceMediumLarge()
            ],
          ),
        ),
      ),
    );
  }

  Widget getClientDetailsUi(List<Account> accounts, BuildContext context,
      HomeModel model, Key key, LocalUser user) {
    return RefreshIndicator(
      key: key,
      onRefresh: () {
        return model.getClientDetails(user);
      },
      child: ListView.builder(
        itemCount: accounts.length,
        itemBuilder: (context, index) => AccountItem(
          account: accounts[index],
          onTap: (account) async {
            await Navigator.of(context)
                .pushNamed("account", arguments: account.id);
            print("Return From forward");
            model.getClientDetails(user);
          },
        ),
      ),
    );
  }
}