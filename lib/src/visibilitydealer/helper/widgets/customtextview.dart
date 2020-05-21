import 'package:tvs_visibility/src/visibilitydealer/helper/constants/assetsconstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextView extends StatelessWidget {
  String text;
  String title;
  bool isTitleRequired;

  CustomTextView({this.isTitleRequired = true,
    this.text,
    this.title,});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          ) : Container(),
          Row(children: <Widget>[
            SizedBox(width: 4,),
            Flexible(child: Text(text,style: TextStyle(fontSize: 14,fontFamily: AssetsConstants.OPEN_SANS_REGULAR,color: Colors.grey[600]),textAlign: TextAlign.start,))
          ],)
        ]);
  }
}
