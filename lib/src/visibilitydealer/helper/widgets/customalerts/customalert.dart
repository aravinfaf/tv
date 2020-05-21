import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customtext.dart';
import 'package:flutter/material.dart';

class CustomAlerts {
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

  static Future<void> showListAlert(BuildContext context, String message) {
    List<String> validationMessage=message.split('\n');
    List<Widget> widget=[];



    Widget getListTile(index){
    return Column(children: <Widget>[
      CustomText(text: validationMessage[index],textSize: 16,),
      SizedBox(height: 2,)
    ],);
    }

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: new Text(message),
          actions: [
             ListView.builder(itemCount: validationMessage.length,itemBuilder: (BuildContext context,int index){
            return getListTile(index);
          })]
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
                    textAlign: TextAlign.center,
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

  static Widget showRadioList(List<String> message,
      SearchListener searchListener, BuildContext context) {
    int _radioValue1 = 0;
    return ListView.builder(
        shrinkWrap: true,
        itemCount: message?.length ?? 0,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              searchListener.onSelectAlert(index);
              Navigator.pop(context);
            },
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Radio(
                  value: _radioValue1 == null ? 0 : index,
                  activeColor: Colors.blue,
                  groupValue: _radioValue1,
                  onChanged: (val) {
                    Navigator.pop(context);
                    _radioValue1 = val;
                    searchListener.onSelectAlert(index);
                  },
                ),
                new Text(
                  message.elementAt(index),
                  style: new TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          );
        });
  }

  static Future<void> showAlertWithRadioButton(BuildContext context,
      List<String> message, SearchListener searchListener) {
    return showDialog<void>(
        context: context, // user must tap button!
        builder: (BuildContext context) {
          /* return AlertDialog(
          title: Text('Filter by'),
          content: showRadioList(message, searchListener, context),
        );*/
          return CustomRadio(message, searchListener);
        },
        barrierDismissible: false);
  }
}

class CustomRadio extends StatefulWidget {
  List<String> message;
  SearchListener searchListener;
  static int currentValue = 0;

  CustomRadio(this.message, this.searchListener);

  @override
  _CustomRadioState createState() => _CustomRadioState(message, searchListener);
}

class _CustomRadioState extends State<CustomRadio> {
  List<String> message;
  SearchListener searchListener;

  _CustomRadioState(this.message, this.searchListener);

  @override
  void initState() {
    /* print('Indexed : ${HomeView.viewIndex}');
    if (CustomRadio.viewIndex != HomeView.viewIndex) {
      CustomRadio.currentValue = 0;
      CustomRadio.viewIndex = HomeView.viewIndex;
    }*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Filter by'),
      content: Container(
        width: double.maxFinite,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: message?.length ?? 0,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: RadioListTile(
                    value: index,
                    title: Text(message.elementAt(index),
                        style: new TextStyle(fontSize: 16.0)),
                    groupValue: CustomRadio.currentValue,
                    onChanged: (val) {
                      Navigator.pop(context);
                      setChecked(index);
                      searchListener.onSelectAlert(index);
                    }),
                onTap: () {
                  Navigator.pop(context);
                  setChecked(index);
                  searchListener.onSelectAlert(index);
                },
              );
            }),
      ),
    );
  }

  setChecked(int value) {
    setState(() {
      CustomRadio.currentValue = value;
    });
  }
}


class SearchListener {
  void onSelectAlert(int index) {}
}
