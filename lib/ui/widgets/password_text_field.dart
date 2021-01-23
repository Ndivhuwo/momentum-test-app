import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:momentum_test/ui/shared/app_colors.dart';
import 'package:momentum_test/ui/shared/text_styles.dart';
import 'package:momentum_test/ui/shared/ui_helper.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final double horizontalPadding;
  final double horizontalContentPadding;
  final double verticalPadding;
  final double horizontalMargin;
  final double verticalMargin;
  final bool showPrefixIcon;
  final bool showSuffixIcon;
  final bool boarder;
  final double width;
  final Color color;
  final bool borderRadiusPresent;
  final BorderRadius borderRadius;
  final bool customHint;

  PasswordTextField(
      {@required this.controller,
        this.hint = "Enter Password",
        this.horizontalPadding = 15,
        this.verticalPadding = 0,
        this.horizontalMargin = 0,
        this.verticalMargin = 0,
        this.showPrefixIcon = false,
        this.showSuffixIcon = true,
        this.boarder = false,
        this.horizontalContentPadding = 0,
        this.width = 400,
        this.color = widgetBgColor,
        this.borderRadiusPresent = true,
        this.borderRadius = UIHelper.textFieldBorderRadiusAllCircular,
        this.customHint = false});

  @override
  State<StatefulWidget> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool passwordVisible = false;

  @override
  void initState() {
    passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: widget.width,
      child: IntrinsicHeight(
        child: Row(
          children: [
            widget.customHint ? Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: widget.borderRadiusPresent ? BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)) : null,
                ),
                child: Center(
                  child: Text(widget.hint, style: textStyleWhiteLight, textAlign: TextAlign.center,),
                ),
              ),
            ): Container(),
            Expanded(
              flex: 7,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
                margin: EdgeInsets.symmetric(
                    horizontal: widget.horizontalMargin, vertical: widget.verticalMargin),
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: widget.borderRadiusPresent ? widget.borderRadius : null,
                ),
                alignment: Alignment.centerLeft,
                child: TextFormField(
                  maxLines: 1,
                  inputFormatters: [LengthLimitingTextInputFormatter(30)],
                  obscureText: !passwordVisible,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: !widget.customHint ? widget.hint: null,
                    labelText: !widget.customHint ? widget.hint: null,
                    fillColor: widgetBgColor,
                    icon: widget.showPrefixIcon
                        ? Icon(
                      Icons.lock,
                      color: secondaryColor,
                    )
                        : null,
                    suffixIcon: widget.showSuffixIcon
                        ? IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        passwordVisible ? Icons.visibility : Icons.visibility_off,
                        color: primaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    )
                        : null,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: widget.horizontalContentPadding, vertical: 4),
                    border: !widget.boarder
                        ? InputBorder.none
                        : OutlineInputBorder(
                        borderSide: BorderSide(color: widgetGreyColor, width: 3),
                        borderRadius:
                        widget.borderRadiusPresent ? widget.borderRadius : null),
                    focusedBorder: !widget.boarder
                        ? InputBorder.none
                        : OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor, width: 3,),
                        borderRadius:
                        widget.borderRadiusPresent ? widget.borderRadius : null),
                  ),
                  controller: widget.controller,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}