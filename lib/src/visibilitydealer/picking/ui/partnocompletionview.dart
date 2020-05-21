import 'package:tvs_visibility/src/visibility/ui/homeview.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/baseconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customraisedbutton.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/navigaton/navigationutils.dart';
import 'package:flutter/material.dart';

class PartNumberCompletionView extends StatefulWidget {

  PartNumberCompletionView();
  @override
  State<StatefulWidget> createState() {
    return PartNumberCompletionViewState();
  }
}

class PartNumberCompletionViewState extends State<PartNumberCompletionView> {

  PartNumberCompletionViewState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: appBar(),
      body: Column(children: <Widget>[
        Expanded(child: Container(
          child: Column(
            children: <Widget>[
              outwardCompleted()
            ],
          ),
        )),
        rbComplete()
      ],),
    );
  }

  appBar(){
    return PreferredSize(child: AppBar(
      title: Text("Dealer Picking"??"PartNumberCompletionView"),
      backgroundColor: Colors.blue,
    ), preferredSize: Size.fromHeight(60));
  }

  outwardCompleted(){
    return Expanded(
        child: Center(
          child: Container(
            child: new Text('   Outward\n Completed\nSuccessfully',
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  color: Colors.green,
                )),
          ),
        ));
  }

  Widget iconCheck() {
    return Icon(
      Icons.check,
      color: Colors.green,
      size: 100,
    );
  }

  Widget rbComplete() {
    return CustomRaisedButton(text: 'OK',
      buttonColor: Colors.blue,
      textColor: Colors.white,
      onPress: () {
        NavigationUtils.pushAndRemoveUntil(context, HomeView());
      },);
  }

}
