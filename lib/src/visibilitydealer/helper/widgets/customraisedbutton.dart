import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  String text;
  Color buttonColor;
  Color textColor;
  Function onPress;
  bool isWrap;
  bool isCircularBorder;

  CustomRaisedButton({
    @required this.text,
    @required this.buttonColor,
    this.textColor,
    this.onPress,
    this.isWrap=false,
    this.isCircularBorder=false
  });

  @override
  Widget build(BuildContext context) {
    return this.isWrap?Container(
      child: RaisedButton(color: buttonColor,
        shape: RoundedRectangleBorder(borderRadius: this.isCircularBorder? BorderRadius.all(Radius.circular(3)): BorderRadius.zero),
        onPressed: this.onPress,
        child: Text("${text ?? ""}",
            style: TextStyle(color: textColor ?? Colors.white,)),),):Container(
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(color: buttonColor,padding: EdgeInsets.all(14),
      shape: RoundedRectangleBorder(borderRadius: this.isCircularBorder? BorderRadius.all(Radius.circular(3)): BorderRadius.zero),
      onPressed: this.onPress,materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Text("${text ?? ""}",
          style: TextStyle(color: textColor ?? Colors.white,)),),);
  }

}
