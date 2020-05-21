import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/base/baseinterface.dart';

class CustomEditFormText extends StatelessWidget {
  String text;
  String hint;
  TextEditingController controller;
  TextInputType inputType;
  Function validator;
  Function onTextSaved;
  int maxLength;
  int maxLines;
  Icon prefixIcon;
  Icon suffixIcon;
  bool numbersOnly;
  bool textCaps;
  bool enable;
  String label;
  bool allowOnlyAlphabets;
  bool allowOnlyAlphaNumerals;

  CustomEditFormText(
      {
      this.text,
      this.hint,
      this.prefixIcon,
      this.suffixIcon,
      this.maxLength,
      this.maxLines,
      @required this.controller,
      this.inputType,
      this.enable = true,
      this.validator,
      this.onTextSaved,
      this.numbersOnly = false,
      this.textCaps = false,
      this.allowOnlyAlphabets=false,
      this.allowOnlyAlphaNumerals=false,
      this.label});

  @override
  Widget build(BuildContext context) {
    controller.text = text;
    return Container(
        child: Column(children: <Widget>[
      SizedBox(height: 10.0),
      Align(
        alignment: Alignment.topLeft,
        child: Text(
          label??'',
          textAlign: TextAlign.start,
        ),
      ),
      Padding(
        child: TextFormField(
          enabled: enable != null ? enable : true,
          maxLength: maxLength ?? null,
          textCapitalization: textCaps != null && textCaps
              ? TextCapitalization.characters
              : TextCapitalization.none,
          maxLines: maxLines ?? null,
          controller: controller,
          keyboardType: inputType ?? null,
          inputFormatters: numbersOnly != null && numbersOnly
              ? <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly]
              : allowOnlyAlphabets?<TextInputFormatter>[WhitelistingTextInputFormatter(RegExp(r"[A-Za-z\\ ]"))]
              :allowOnlyAlphaNumerals?<TextInputFormatter>[WhitelistingTextInputFormatter(RegExp(r"[A-Za-z0-9\\ ]"))]:null,
          decoration: InputDecoration(
            counterText: '',
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            border: OutlineInputBorder(),
            prefixIcon: prefixIcon ?? null,
            suffixIcon: suffixIcon ?? null,
            hintText: hint,
          ),
          validator: (val) {
            var validationContent;
            return (this.validator != null &&
                (validationContent = this.validator(val)) != null
                ? validationContent
                : null);
          },
          onSaved: (val) => this.onTextSaved != null ? this.onTextSaved(val) : '',
        ),
        padding: EdgeInsets.symmetric(vertical: 5),
      )
    ]));
  }
}
