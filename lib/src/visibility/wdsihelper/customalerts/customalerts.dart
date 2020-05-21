import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomAlerts {
  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 3,
        backgroundColor: Colors.black26,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Future<void> showAlert(BuildContext context, String message) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: new Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showAlertWithDynamicAction(
      BuildContext context, String message, dynamic fetch) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: new Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                fetch();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showAlertWithFunctionAction(
      BuildContext context, String message, Function fetch) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: new Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                fetch();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showAlertWithCancel(
      BuildContext context, String message, Function fetch, Function cancel) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: new Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                fetch();
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
                cancel();
              },
            ),
          ],
        );
      },
    );
  }

  static Future showAlertWithOkCancel(
      BuildContext context,
      String message,
      String positiveButton,
      String negativeButton,
      Function fetch,
      Function cancel) {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                new Text(message,
                    textAlign: TextAlign.start,
                    softWrap: true,
                    style: TextStyle(fontSize: 17.0)),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(positiveButton),
              onPressed: () {
                Navigator.of(context).pop();
                fetch();
              },
            ),
            FlatButton(
              child: Text(negativeButton),
              onPressed: () {
                Navigator.of(context).pop();
                cancel();
              },
            ),
          ],
        );
      },
    );
  }

}
