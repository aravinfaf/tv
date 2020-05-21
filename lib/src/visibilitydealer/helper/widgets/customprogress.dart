import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomProgress extends StatelessWidget {
  String title;
  String content;
  bool isTitleRequired;

  CustomProgress(
      {this.title = 'Visibility',
      this.content = 'Loading Please wait...',
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
      appBar: PreferredSize(child: AppBar(automaticallyImplyLeading: false,
        title: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
            )),
        backgroundColor: Colors.blue,
      ), preferredSize: Size.fromHeight(60)),
      body: getBody(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isTitleRequired ? getWithAppBar() : getBody();
  }
}
