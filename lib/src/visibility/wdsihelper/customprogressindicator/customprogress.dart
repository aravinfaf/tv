import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/constants/constants.dart';

class CustomProgress extends StatelessWidget {
  String title;
  String content;
  bool isTitleRequired;

  CustomProgress(
      {this.title = MESSAGES.APP_TITLE,
      this.content = 'Please wait...!',
      this.isTitleRequired = true});

  Widget getBody() {
    return Container(
        color: Colors.white,alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: CircularProgressIndicator(),
            ),
            SizedBox(
              height: 25,
            ),
            Center(
              child: Text(content ?? null,style: TextStyle(color: Colors.black87,fontSize: 15.0,fontWeight: FontWeight.normal),textAlign: TextAlign.center,),
            )
          ],
        ));
  }

  Widget getWithAppBar() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
            child: Text(
          title,
          textAlign: TextAlign.center,
        )),
        automaticallyImplyLeading: false,
      ),
      body: getBody(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isTitleRequired ? getWithAppBar() : getBody();
  }
}
