import 'package:flutter/material.dart';

class NavigationUtils {
  static Future pushReplacement(BuildContext context, dynamic data) {
    return Navigator.pushReplacement(
      context,
      new MaterialPageRoute(builder: (context) => data),
    );
  }

  static Future push(BuildContext context, dynamic data) {
    return Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => data),
    );
  }

  static Future pushAndRemoveUntil(BuildContext context, dynamic data,) {
    return Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => data),
        ModalRoute.withName("/Home"));
  }
}
