import 'dart:convert';

import 'package:jaguar_resty/jaguar_resty.dart' as resty;
import 'package:tvs_visibility/src/visibility/apiinterface/apiinterface.dart';
import 'package:tvs_visibility/src/visibility/dataprovider/sharedprefs.dart';
import 'package:tvs_visibility/src/visibility/model/exceptionmodel/ExceptionModel.dart';
import 'package:tvs_visibility/src/visibility/model/loginrequestmodel/loginrequestmodel.dart';
import 'package:tvs_visibility/src/visibility/model/loginresponsemodel/loginresponsemodel.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customalerts/customalerts.dart';

class FetchDataException implements resty.ErrorResponse {
  static final int UNSUPPORTED_MEDIA_TYPE  = 415;
  static final int AUTHENTICATION_ERROR = 401;
  static final int INTERNAL_SERVER_ERROR = 500;
  static final int URL_NOT_FOUND = 404;
  static final int BAD_REQUEST = 400;
  static final String SUCCESS = 'success';
  final CustomSharedPrefs mCustomSharedPrefs;
  final ApiInterface mApiInterface;
  resty.Response _response;
  String message;
  ExceptionModel exceptionBody;

  FetchDataException(this.mCustomSharedPrefs, this.mApiInterface,
      this._response);

  exceptionHandling() async {

    if (response == null) {
      CustomAlerts.showToast('Something went wrong');
      return message = "Exception";
    }

    if (statusCode == INTERNAL_SERVER_ERROR) {
      message = "Inernal server error";
      CustomAlerts.showToast('Something went wrong...');
      return message;
    }
    if (statusCode == URL_NOT_FOUND) {
      message = "URL not found";
      CustomAlerts.showToast('Something went wrong');
      return message;
    }
    if (statusCode == BAD_REQUEST) {
      message = "Bad request";
      CustomAlerts.showToast('Something went wrong');
      return message;
    }
    if (statusCode == UNSUPPORTED_MEDIA_TYPE) {
      message = "Unsupported Media Type";
      CustomAlerts.showToast('Something went wrong');
      return message;
    }
    if (statusCode == AUTHENTICATION_ERROR) {
      message = await getAuthenticationToken();
      return message;
    }
    return message = "${body}";
  }

  Future<String> getAuthenticationToken() async {
    var loginResponse = LoginResponseModel();
    var model = LoginRequestModel();
    try {
      model.userName = await mCustomSharedPrefs.userProfile();
      model.password = await mCustomSharedPrefs.userPassword();
      loginResponse = await mApiInterface.getLoginResult(model);
      loginResponse.userName = model.userName;
      loginResponse.password = model.password;
      await mCustomSharedPrefs.updateToken(loginResponse.tocken);
      return SUCCESS;
    } on resty.Response catch (e) {
      print(e.toString());
      return null;
    }
  }


  Future<String> getExceptionMessage() async {
    if (body != null) {
      final jsonResponse = json.decode(body);
      exceptionBody = new ExceptionModel.fromJson(jsonResponse);
      String errorMsg = (exceptionBody.message).substring(exceptionBody.message.indexOf(':')+1);
      print(errorMsg);
      return errorMsg;
    }
  }


  @override
  String get body => _response.body;

  @override
  resty.Response get response => _response;

  @override
  int get statusCode => _response.statusCode;
}
