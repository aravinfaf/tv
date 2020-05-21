import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/assetsconstants.dart';

class CustomTextFormField extends StatelessWidget {
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
  Function onValidate;
  Function onSave;
  Function onChanged;
  Function onPressSuffixIcon;

  CustomTextFormField({this.isTitleRequired = true,
    this.text,
    this.hint,
    this.validationMessage = "Please enter ...",
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
    this.maxLines,
    @required this.controller,
    this.inputType,
    this.enable = true,
    this.numbersOnly = false,
    this.textCaps = false,
    this.title,
    this.isObscureText = false,
    this.onValidate,
    this.onChanged,
    this.onPressSuffixIcon,
    this.onSave});

  @override
  Widget build(BuildContext context) {
    controller?.text = text;
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
          TextFormField(
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
              prefixIcon: prefixIcon,suffixIcon:suffixIcon!=null?IconButton(icon: suffixIcon, onPressed: (){
                this.onPressSuffixIcon();
            }):suffixIcon,
              hintText: hint,
            ),
            validator: (val) {
              var validationContent;
              return (this.onValidate != null &&
                  (validationContent = this.onValidate(val)) != null
                  ? validationContent
                  : null);
            },
            onSaved: (val) => this.onSave != null ? this.onSave(val) : '',
            onChanged: (str){
              this.onChanged(str);
            },
          )
        ]);
  }
}
