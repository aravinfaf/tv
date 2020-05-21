import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/base/baseinterface.dart';

class CustomButton extends StatelessWidget {
  String text;
  GlobalKey<FormState> formKey;
  Function onPress;
  bool isCircularEdge;

  CustomButton(
      {this.text, this.formKey, this.onPress,this.isCircularEdge=false});

  @override
  Widget build(BuildContext context) {
    return !isCircularEdge?Container(
      child: new RaisedButton(
        shape: Border(),
        onPressed: () {
          if(formKey!=null){
            if (this.formKey.currentState.validate())
              formKey.currentState.save();
            else
              return null;
          }
          this.onPress();
        },
        color: Colors.lightBlueAccent,
        child: Text(text, style: TextStyle(color: Colors.white)),
      ),
    ): Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: new RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          if(formKey!=null){
            if (this.formKey.currentState.validate())
              formKey.currentState.save();
            else
              return null;
          }
          this.onPress();
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text(text, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
