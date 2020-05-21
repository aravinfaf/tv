import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info/package_info.dart';
import 'package:tvs_visibility/src/visibility/utililty/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateActivity extends StatefulWidget {
  @override
  _UpdateActivityState createState() => _UpdateActivityState();
}

class _UpdateActivityState extends State<UpdateActivity> {
  PackageInfo appInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: ListView(
          shrinkWrap: false,
          children: <Widget>[
            image(),
            textContents(),
            new SizedBox(height: 50.0),
            btnDownload(context),
          ],
        ),
      ),
    );
  }

  Widget image() {
    return Hero(
      tag: 'hero',
      child: new Container(
        child: new Image.asset(
          'images/visibility_app_icon_blue.png',
        ),
        width: 220.0,
        height: 220.0,
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      ),
    );
  }

  Widget textContents() {
    return Center(
      child: new Text(
        'This version of Visibility app became outdated. Please click the download button to update.',
        softWrap: true,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 20, fontStyle: FontStyle.normal, color: Colors.blue[900]),
      ),
    );
  }

  Widget btnDownload(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: RaisedButton(
        color: Colors.blue[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        onPressed: () => {downloadActions(context)},
        child: Text(
          "Download",
          style: TextStyle(color: Colors.white),
        ),
      ),
      margin: EdgeInsets.all(60.0),
    );
  }

  void downloadActions(BuildContext context) async {
    appInfo = await Utils.getApplicationInfo();
    print('${appInfo.packageName}');
    var url =
        'https://play.google.com/store/apps/details?id=${appInfo.packageName}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch App';
    }
  }
}
