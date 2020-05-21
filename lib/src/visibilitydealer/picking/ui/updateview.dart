import 'package:tvs_visibility/src/visibilitydealer/helper/constants/assetsconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/baseconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/validationconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/utility/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info/package_info.dart';
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
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          image(),
          textContents(),
          new SizedBox(height: 50.0),
          btnDownload(),
        ],
      ),
    );
  }

  Widget image() {
    return Hero(
      tag: 'hero',
      child: new Container(
        color: Colors.transparent,
        child: new Image.asset(AssetsConstants.IMAGE_TVS_SCS_PNG),
        width: 220.0,
        height: 220.0,
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      ),
    );
  }

  Widget textContents() {
    return Center(
      child: new Text(
        ValidationConstants.STR_UPDATE_APP,
        softWrap: true,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 20, fontStyle: FontStyle.normal,fontFamily: AssetsConstants.OPEN_SANS_BOLD, color: BaseConstants.BLUE_WHALE),
      ),
    );
  }

  Widget btnDownload() {
    return RaisedButton(
      color: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      onPressed: () => downloadActions(),
      child: Text("Download", style: TextStyle(color: Colors.white),
      ),
    );
  }

  void downloadActions() async{
    appInfo = await Utility.getApplicationInfo();
    print('${appInfo.packageName}');
    var url = 'https://play.google.com/store/apps/details?id= ${appInfo.packageName}';
    if (await canLaunch(url))
     await launch(url);
    else
     throw 'Could not launch App';
  }
}
