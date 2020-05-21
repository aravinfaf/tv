import 'package:flutter/material.dart';

class CustomAlertDialog {
  static Future<void> alertDialogSingleChoice(BuildContext context,
      String title, List<String> list, AlertDialogListener listener) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(contentPadding: EdgeInsets.all(20.0),
            title: Text('$title'),
            content: Container(
              width: double.maxFinite,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length ?? 0,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        listener.onSelectAlertDialog(
                            index, list.elementAt(index), list);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Radio(
                            value: index,
                            groupValue: list.elementAt(index),
                            onChanged: (val) {
                              Navigator.pop(context);
                              listener.onSelectAlertDialog(
                                  index, list.elementAt(index), list);
                            },
                          ),
                          new Text(
                            list.elementAt(index),
                            style: new TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          );
        });
  }
}

class AlertDialogListener {
  void onSelectAlertDialog(int index, String value, List<String> list) {}
}
