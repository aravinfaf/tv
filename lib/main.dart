import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tvs_visibility/src/visibility/di/diconfig.dart';
import 'package:tvs_visibility/src/visibility/ui/loginview.dart';

void main() => init();

void init() {
  diConfig();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MainDart());
}

class MainDart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Visibility',
      theme: ThemeData(primaryColor: Colors.blue),
      home: LoginView(),
    );
  }
}
