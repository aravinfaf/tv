import 'package:flutter/material.dart';

class CustomText extends StatelessWidget{
  String text;
  var fontFamily;
  double fontSize;
  var textColor;
  double textSize;
  var textAlign;
  var fontWeight;
  var fontStyle;
  var softWrap;

  CustomText({this.text,this.textColor,this.textSize,this.fontSize,this.fontFamily,this.fontWeight,this.fontStyle,this.textAlign,this.softWrap});

  @override
  Widget build(BuildContext context) {
    return Text("$text",style: TextStyle(color: textColor,fontSize: fontSize,fontFamily: fontFamily,fontWeight: fontWeight,fontStyle: fontStyle),softWrap: softWrap,textAlign: textAlign,);
  }
}