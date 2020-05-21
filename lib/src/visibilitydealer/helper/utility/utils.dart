import 'dart:io';
import 'package:package_info/package_info.dart';
import 'package:tvs_visibility/src/visibility/constants/baseconstants.dart' as prefix0;
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/baseconstants.dart';

class Utility {
  static bool isEmpty(String val) {
    return (val != null && val.isNotEmpty) ? false : true;
  }

  static int parseStringToInt(String val){
    return !isEmpty(val)?int.parse(val):0;
  }

  static String parseIntToString(int val) {
    return val!=null?String.fromCharCode(val):0;
  }

  static Future<bool> onCheckNetworkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
        return true;
      else
        return false;
    } on SocketException catch (_) {
      return false;
    }
  }

  static bool regexCompare(String barCode){
    return RegExp(r"[&$+,:;=\\\\?@#|/'<>.^*()%!_a-z]").hasMatch("$barCode")?true:false;
  }

  static bool isBarcodeValid(String barCode,bool nosOnly){
    bool isValid=RegExp(r"[&$+,:;=\\\\?@#|/'<>.^*()%!_]").hasMatch("$barCode")?false:true;
    return isValid && nosOnly?!containsAlphabets(barCode):isValid;
  }

  static bool validSpecialCharactersInBackend(String barCode){
    bool isValid=RegExp(BaseConstants.regexAlphaNumericLiteral).hasMatch(barCode);
    return isValid;
  }

  static bool containsAlphabets(String barCode){
    return RegExp(r"[A-Za-z]").hasMatch("$barCode")?true:false;
  }

  static Future<PackageInfo> getApplicationInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo;
  }

}
