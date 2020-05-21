import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/base/baseinterface.dart';

class CustomAutoCompleteTextField extends StatefulWidget {
  BaseAutoCompleteItem text;
  String hint;
  String validationMessage;
  TextEditingController controller;
  TextInputType inputType;
  Validator validator;
  int id;
  int maxLength;
  int maxLines;
  Icon prefixIcon;
  Icon suffixIcon;
  AutoCompleteInterFace autoCompleteInterFace;
  String _setText;
  bool numbersOnly;

  CustomAutoCompleteTextField(
      {@required this.id,
      this.text,
      this.hint = "",
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
      hint,
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
  String hint;
  String validationMessage;
  TextEditingController controller;
  TextInputType inputType;
  Validator validator;
  int id;
  int maxLength;
  int maxLines;
  Icon prefixIcon;
  Icon suffixIcon;
  AutoCompleteInterFace autoCompleteInterFace;
  String _setText;
  bool numbersOnly;

  CustomAutoComplete(
      this.id,
      this.text,
      this.hint,
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
    id = text?.getID();
    autoCompleteInterFace.onItemSelected(text, id);
    return Container(
        child: Column(children: <Widget>[
      SizedBox(height: 10.0),
      Align(
        alignment: Alignment.topLeft,
        child: Text(
          hint,
          textAlign: TextAlign.start,
        ),
      ),
      Padding(
        child: TypeAheadFormField<T>(
          getImmediateSuggestions: false,
          validator: (val) {
            if (_setText != null && _setText == val) {
              return validator.getValidation(val, validationMessage);
            } else {
              return validationMessage;
            }
          },
          textFieldConfiguration: TextFieldConfiguration(
              controller: controller,
              autofocus: true,
              maxLength: maxLength ?? null,
              maxLines: maxLines ?? null,
              inputFormatters: numbersOnly != null && numbersOnly
                  ? <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ]
                  : null,
              decoration: InputDecoration(
                  counterText: '',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  border: OutlineInputBorder(),
                  prefixIcon: prefixIcon ?? null,
                  suffixIcon: suffixIcon ?? null,
                  hintText: hint)),
          hideOnEmpty: true,
          hideOnLoading: true,
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
        ),
        padding: EdgeInsets.symmetric(vertical: 5),
      )
    ]));
  }
}
