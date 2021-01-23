import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:momentum_test/ui/shared/app_colors.dart';
import 'package:momentum_test/ui/shared/text_styles.dart';
import 'package:momentum_test/ui/shared/ui_helper.dart';

class EmailTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final double horizontalPadding;
  final double verticalPadding;
  final double horizontalContentPadding;
  final double horizontalMargin;
  final double verticalMargin;
  final bool showPrefixIcon;
  final bool boarder;
  final TextCapitalization textCapitalization;
  final double width;
  final Color color;
  final bool borderRadiusPresent;
  final BorderRadius borderRadius;
  final bool customHint;
  final Function(String) onTextChange;
  final bool enable;

  EmailTextField({this.controller, this.hint = "Email", this.horizontalPadding = 15,
    this.verticalPadding = 0, this.horizontalMargin = 0, this.verticalMargin = 0,
    this.showPrefixIcon = false, this.boarder = false, this.textCapitalization = TextCapitalization.none,
    this.onTextChange, this.width = 400, this.color = widgetBgColor, this.borderRadiusPresent = true,
    this.borderRadius = UIHelper.textFieldBorderRadiusAllCircular,
    this.customHint = false, this.horizontalContentPadding = 0, this.enable = true});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      child: IntrinsicHeight(
        child: Row(
          children: [
            customHint ? Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: borderRadiusPresent ? BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)) : null,
                ),
                child: Center(
                  child: Text(hint, style: textStyleWhiteLight,),
                ),
              ),
            ): Container(),
            Expanded(
              flex: 7,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                margin: EdgeInsets.symmetric(horizontal: horizontalMargin, vertical: verticalMargin),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: borderRadiusPresent ? borderRadius: null,
                ),
                child: TextFormField(
                  maxLines: 1,
                  inputFormatters: [LengthLimitingTextInputFormatter(100)],
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: textCapitalization,
                  autofocus: false,
                  enabled: enable,
                  decoration: InputDecoration(
                    hintText: !customHint ? hint: null,
                    labelText: !customHint ? hint: null,
                    icon: showPrefixIcon
                        ? Icon(
                      Icons.email,
                      color: primaryColor,
                    )
                        : null,
                    contentPadding: EdgeInsets.symmetric(horizontal: horizontalContentPadding, vertical: 4),
                    border: !boarder
                        ? InputBorder.none
                        : OutlineInputBorder(
                        borderSide: BorderSide(color: widgetGreyColor, width: 3),
                        borderRadius: borderRadiusPresent ? borderRadius : null
                    ),
                    focusedBorder: !boarder
                        ? InputBorder.none
                        : OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor, width: 3),
                        borderRadius: borderRadiusPresent ? borderRadius : null
                    ),
                  ),
                  controller: controller,
                  onChanged: onTextChange,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}