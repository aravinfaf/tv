import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/constants/constants.dart';

class CustomRetry extends StatelessWidget {
  String title;
  String content;
  Function retry;
  bool isTitleRequired;

  CustomRetry(
      {this.title = MESSAGES.APP_TITLE,
      this.content = 'Something went wrong..!',
        @required this.retry,
        this.isTitleRequired = true});

  Widget getAppBar() {
    return Scaffold(backgroundColor: Colors.white,
        appBar: AppBar(
          title: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
              )),
          automaticallyImplyLeading: false,
        ),
        body: getBody());
  }

  Widget getBody() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new SizedBox(
            height: 50,
          ),
          new Text(
            content ?? null,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          new SizedBox(
            height: 150,
          ),
          new Icon(
            Icons.sentiment_dissatisfied,
            size: 30,
            color: Colors.grey,
          ),
          new SizedBox(
            height: 50,
          ),
          FlatButton(
            padding: EdgeInsets.only(left: 70.0, right: 70.0),
            child: OutlineButton(
              onPressed: retry,
              splashColor: Colors.blue[500],
              textColor: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.autorenew,
                    size: 25,
                    color: Colors.green,
                  ),
                  Text("Retry", style: TextStyle(fontSize: 18.0))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isTitleRequired ? getAppBar() : getBody();
  }
}
