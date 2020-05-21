import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';

class Utils {
  static bool isEmpty(String val) {
    return (val != null && val.isNotEmpty) ? false : true;
  }

  static bool isValidMobileNumber(String text) {
    Pattern pattern = r'^[9876]{1}[0-9]{9}$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(text);
  }

  static int parseStringToInt(String val) {
    return !isEmpty(val) ? int.parse(val) : 0;
  }

  static int parseIntToString(int val) {
    return val != null ? String.fromCharCode(val) : 0;
  }

  static Future<bool> onCheckNetworkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  static Future getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo;
    }
  }

  static Future<PackageInfo> getApplicationInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    return packageInfo;
  }





  static String convertToHumanDate(String date) {
    String serverFormat;
    initializeDateFormatting(Intl.systemLocale, null);
    if (!isEmpty(date)) {
      try {
        DateTime dateTime = DateTime.parse(date);
       // print(dateTime);
        serverFormat = DateFormat('dd-MM-yyyy hh:mm:ss a').format(dateTime);
       // print(serverFormat);
        return serverFormat;
      } on FormatException catch (e) {
        print(e.toString());
        return null;
      }
    }
    return null;
  }

  static String convertServerDatetime(String str) {
    String dateTime;
    initializeDateFormatting(Intl.systemLocale, null);
    if (!isEmpty(str)) {
      try {
        DateTime date = DateTime.parse(str);
        dateTime = DateFormat("E, dd MMM yyyy HH:mm:ss 'GMT+00:00'").format(date);
      //  print(dateTime);
        return dateTime;
      } on FormatException catch (e) {
        print(e.toString());
        return null;
      }
    }
    return null;
  }

  static String getCurrentDateTime() {
    String dateFormat;
    initializeDateFormatting(Intl.systemLocale, null);
    try {
      //"Tue, 18 Jun 2019 05:14:31 GMT+00:00"
      DateTime now = DateTime.now();
      dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss").format(now);
      return dateFormat;
    } on FormatException catch (e) {
      print(e.toString());
      return null;
    }
  }

  static DateTime getCurrentDate() {
    String dateFormat;
    initializeDateFormatting(Intl.systemLocale, null);
    try {
      DateTime date = new DateTime.now();
      dateFormat = DateFormat.yMMMMEEEEd().add_Hms().format(date);
      print("getCurrentDate: ${dateFormat}");
      return DateTime.tryParse(dateFormat);
    } on FormatException catch (e) {
      print(e.toString());
      return null;
    }
  }


  static String getCurrentDateTimeInUTCFormat() {
    String dateFormat;
    initializeDateFormatting(Intl.systemLocale, null);
    try {
      DateTime now = new DateTime.now().toUtc();
      dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(now);
      print("getCurrentDate: ${dateFormat}");
      return dateFormat;
    } on FormatException catch (e) {
      print(e.toString());
      return null;
    }

  }

  static Future getTimeZone() async {
    String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    return currentTimeZone;
  }

  static bool regexCompare(String string) {
    var regex = new RegExp(r"[&+,:;=\\\\?@#|/'<>.^*()%!_]$");
    return regex.hasMatch(string);
  }

  static String regexRemoveWhitespace(String inputString) {
    var outputString =  inputString.replaceAll(new RegExp(r"\s\b|\b\s"), "");
    return outputString;
  }

  static bool containsNumber(String barCode){
    return RegExp(r"[0-9]").hasMatch("$barCode");
  }
}
