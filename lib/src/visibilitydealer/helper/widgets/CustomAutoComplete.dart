import 'package:tvs_visibility/src/visibilitydealer/helper/base/baseautocompleteItem.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/base/baseinterface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CustomAutoCompleteTextField extends StatefulWidget {
  BaseAutoCompleteItem text;
  String title;
  String validationMessage;
  TextEditingController controller;
  TextInputType inputType;
  Validator validator;
  String id;
  int maxLength;
  int maxLines;
  Icon prefixIcon;
  Icon suffixIcon;
  AutoCompleteInterFace autoCompleteInterFace;
  String _setText;
  String hintText;
  bool numbersOnly;

  CustomAutoCompleteTextField(
      {@required this.id,
      this.text,
      this.title = "",
      this.hintText= "",
      this.validationMessage = 'Please select text from drop down',
      this.prefixIcon,
      this.suffixIcon,
      this.maxLength,
      this.maxLines,
      @required this.controller,
      this.inputType,
      @required this.validator,
      @required this.autoCompleteInterFace,
      this.numbersOnly = false});

  @override
  CustomAutoComplete createState() => CustomAutoComplete(
      id,
      text,
      title,
      hintText,
      validationMessage,
      prefixIcon,
      suffixIcon,
      maxLength,
      maxLines,
      controller,
      inputType,
      validator,
      autoCompleteInterFace,
      numbersOnly);
}

class CustomAutoComplete<T extends BaseAutoCompleteItem>
    extends State<CustomAutoCompleteTextField> {
  BaseAutoCompleteItem text;
  String title;
  String validationMessage;
  TextEditingController controller;
  TextInputType inputType;
  Validator validator;
  String id;
  int maxLength;
  int maxLines;
  Icon prefixIcon;
  Icon suffixIcon;
  AutoCompleteInterFace autoCompleteInterFace;
  String _setText;
  String hintText;
  bool numbersOnly;

  CustomAutoComplete(
      this.id,
      this.text,
      this.title,
      this.hintText,
      this.validationMessage,
      this.prefixIcon,
      this.suffixIcon,
      this.maxLength,
      this.maxLines,
      this.controller,
      this.inputType,
      this.validator,
      this.autoCompleteInterFace,
      this.numbersOnly);

  int i = 0;

  @override
  Widget build(BuildContext context) {
    print("controller recreate" + (i++).toString());
    controller.text = text?.getText();
    _setText = controller.text;
    id = text?.getID();
    autoCompleteInterFace.onItemSelected(text, id);
    return Container(
        child: Column(children: <Widget>[
      SizedBox(height: 10.0),
      Align(
        alignment: Alignment.topLeft,
        child: Text(
          title,
          textAlign: TextAlign.start,
        ),
      ),
          SizedBox(height: 5.0),
          TypeAheadFormField<T>(
            getImmediateSuggestions: false,
            validator: (val){
              if (_setText != null && _setText == val) {
                return validator.getValidation(val, validationMessage);
              } else {
                return validationMessage;
              }
            },
            textFieldConfiguration: TextFieldConfiguration(
                controller: controller,
                autofocus: true,
                keyboardType: numbersOnly?TextInputType.number:TextInputType.text,
                maxLength: maxLength ?? null,
                maxLines: maxLines ?? null,
                inputFormatters: numbersOnly != null && numbersOnly
                    ? <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ]
                    : null,
                decoration: InputDecoration(
                    counterText: '',
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding:
                    EdgeInsets.symmetric(
                        horizontal: 10, vertical: 14),
                    border: OutlineInputBorder(),
                    prefixIcon: prefixIcon ?? null,
                    suffixIcon: suffixIcon ?? null,
                    hintText: hintText)),
            hideOnEmpty: false,
            hideOnLoading: true,hideSuggestionsOnKeyboardHide: false,
            suggestionsCallback: (String s) async {
              return await autoCompleteInterFace.getAutoCompleteData(s, id);
            },
            itemBuilder: (context, t) {
              return new ListTile(
                  title: Text(
                      t == null ? "" : t.getText() == null ? "" : t.getText()));
            },
            onSuggestionSelected: (t) {
              _setText = t.getText();
              controller.text = t.getText();
              id = t.getID();
              autoCompleteInterFace.onItemSelected(t, id);
            },
          )
    ]));
  }
}
