import 'package:flutter/material.dart';

class UIHelper {
  static const BorderRadius textFieldBorderRadiusAllCircular = const BorderRadius.all(Radius.circular(8));
  static const BorderRadius textFieldBorderRadiusRightSideCircular =  const BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8));

  static const double _VerticalSpaceXSmall = 5.0;
  static const double _VerticalSpaceSmall = 10.0;
  static const double _VerticalSpaceMedium = 20.0;
  static const double _VerticalSpaceLarge = 60.0;
  static const double _VerticalSpaceXLarge = 120.0;
  static const double _VerticalSpaceMediumLarge = 40.0;

  static const double _HorizontalSpaceSmall = 10.0;
  static const double _HorizontalSpaceMedium = 20.0;
  static const double _HorizontalSpaceLarge = 60.0;
  static Widget verticalSpaceMediumLarge() {
    return verticalSpace(_VerticalSpaceMediumLarge);
  }
  static Widget verticalSpaceXSmall() {
    return verticalSpace(_VerticalSpaceXSmall);
  }

  static Widget verticalSpaceSmall() {
    return verticalSpace(_VerticalSpaceSmall);
  }

  static Widget verticalSpaceMedium() {
    return verticalSpace(_VerticalSpaceMedium);
  }

  static Widget verticalSpaceLarge() {
    return verticalSpace(_VerticalSpaceLarge);
  }

  static Widget verticalSpaceXLarge() {
    return verticalSpace(_VerticalSpaceXLarge);
  }

  static Widget verticalSpace(double height) {
    return Container(height: height);
  }

  static Widget horizontalSpaceSmall() {
    return horizontalSpace(_HorizontalSpaceSmall);
  }

  static Widget horizontalSpaceMedium() {
    return horizontalSpace(_HorizontalSpaceMedium);
  }

  static Widget horizontalSpaceLarge() {
    return horizontalSpace(_HorizontalSpaceLarge);
  }

  static Widget horizontalSpace(double width) {
    return Container(width: width);
  }

  static void showDialogOneAction(BuildContext context, Text title,
      Widget content, Function onClickButton, String buttonText) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: title,
            content: content,
            actions: <Widget>[
              FlatButton(
                child: Text(buttonText),
                onPressed: () {
                  Navigator.of(context).pop();
                  onClickButton();
                },
              )
            ],
          );
        });
  }
}