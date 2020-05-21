import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmptyView extends StatelessWidget {
  String text;

  EmptyView({this.text = 'No records found!'});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Icon(
                Icons.sentiment_dissatisfied,
                size: 35,
                color: Colors.grey,
              ),
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0),
            )
          ],
        ),
      ),
    );
  }
}
