import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/assetsconstants.dart';

class CustomTextField extends StatelessWidget {
  String text;
  String hint;
  String validationMessage;
  TextEditingController controller;
  TextInputType inputType;
  int maxLength;
  int maxLines;
  Icon prefixIcon;
  Icon suffixIcon;
  bool numbersOnly;
  bool textCaps;
  bool enable;
  String title;
  bool isTitleRequired;
  bool isObscureText;
  Function onChanged;
  Function onPressSuffixIcon;

  CustomTextField({this.isTitleRequired = true,
    this.text,
    this.hint,
    this.validationMessage = "Please enter ...",
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
    this.maxLines,
    @required this.controller,
    this.onPressSuffixIcon,
    this.inputType,
    this.enable = true,
    this.numbersOnly = false,
    this.textCaps = false,
    this.title,
    this.isObscureText = false,
    this.onChanged,});

  @override
  Widget build(BuildContext context) {
   // controller?.text = text;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          isTitleRequired == true
              ? Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title ?? "",style: TextStyle(fontSize: 16,fontFamily: AssetsConstants.OPEN_SANS_SEMI_BOLD),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          )
              : Container(),
          TextField(
            obscureText: this.isObscureText,
            enabled: enable != null ? enable : true,
            maxLength: maxLength,
            textCapitalization: textCaps != null && textCaps
                ? TextCapitalization.characters
                : TextCapitalization.none,
            maxLines: maxLines,
            controller: controller,
            keyboardType: inputType,
            inputFormatters: numbersOnly != null && numbersOnly
                ? <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly]
                : null,
            decoration: InputDecoration(
              filled: true,
              errorStyle: !enable
                  ? TextStyle(
                color: Theme
                    .of(context)
                    .errorColor,) : null,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
              disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,)),
              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
              counterText: "",
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon!=null?IconButton(icon: suffixIcon, onPressed: (){
                this.onPressSuffixIcon();
              }):suffixIcon,
              hintText: hint,
            ),
            onChanged: (str){
              this.onChanged(str);
            },
          ),
        ]);
  }
}
