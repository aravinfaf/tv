import 'package:flutter/material.dart';

class BaseConstants {
  //INTERNET
  static const String STR_INTERNET_ERROR = "No Internet Connection";
  static const String STR_INTERNET_ERROR_RETRY = "No Internet Connection.\nPlease Retry";
  static const String STR_ERROR_RETRY = "Retry";
  static const String STR_NO_INTERNET="Connect to the internet!";
  //BARCODE
  static const String STR_RECAPTURE_BARCODE="Recapture the Barcode";
  static const String STR_CANCELLED="Cancelled";
  static const String STR_PERMISSION_NOT_GRANTED="PERMISSION_NOT_GRANTED";
  //PROJECT
  static const String STR_PROJECT_NAME="Visibility";
  static const String STR_AUTHORIZATION_BEARER="Bearer ";
  //COLOR
  static const Color DARK_BLUE_WHALE=Color(0xff003046);
  static const Color BLUE_WHALE=Color(0xff005479);
  static const Color LIGHT_BLUE=Color(0xff2699FB);
  static const Color LIGHT_VISIBILITY_BLUE=Color(0xFF01579B);
  //REGEX_ALPHA_NUMERIC_LITERAL
  static String regexAlphaNumericLiteral="";
  //URL
  static const String BASE_URL_TEST="http://13.234.51.172:8015";//13.234.51.172//13.233.67.107
  static const String BASE_URL_UAT="http://13.126.173.6:8015";
  static const String BASE_URL_LIVE="http://tulipgateway.iloads.in/";

//Assets
  static const String IMAGES_CAMERA = "images/camera.png";
}

