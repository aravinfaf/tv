import 'dart:collection';

import 'package:device_info/device_info.dart';
import 'package:jaguar_resty/response/response.dart';
import 'package:tvs_visibility/src/visibility/apiinterface/apiinterface.dart';
import 'package:tvs_visibility/src/visibility/constants/baseconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/baseconstants.dart' as baseConstants;
import 'package:tvs_visibility/src/visibility/dataprovider/sharedprefs.dart';
import 'package:tvs_visibility/src/visibility/exceptionHandler/FetchDataException.dart';
import 'package:tvs_visibility/src/visibility/model/authorizationrequestmodel/authorizationrequestmodel.dart';
import 'package:tvs_visibility/src/visibility/model/authorizationresponsemodel/authorizationresponsemodel.dart';
import 'package:tvs_visibility/src/visibility/model/draweritemmodel/draweritemmodel.dart';
import 'package:tvs_visibility/src/visibility/model/loginrequestmodel/loginrequestmodel.dart';
import 'package:tvs_visibility/src/visibility/model/loginresponsemodel/loginresponsemodel.dart';
import 'package:tvs_visibility/src/visibility/model/notificationData/notificationDataModel.dart';
import 'package:tvs_visibility/src/visibility/utililty/utils.dart';

class LoginNetProvider {
  CustomSharedPrefs mCustomSharedPrefs;
  ApiInterface mApiInterface;

  LoginNetProvider(this.mCustomSharedPrefs, this.mApiInterface);

  Future<LoginResponseModel> loginResult(LoginRequestModel model) async {
    LoginResponseModel loginResponse = LoginResponseModel();

    try {
      model.userName = model.userName ?? await mCustomSharedPrefs.userProfile();
      model.password =
          model.password ?? await mCustomSharedPrefs.userPassword();
      loginResponse = await mApiInterface.getLoginResult(model);
      loginResponse.userName = model.userName;
      loginResponse.password = model.password;
      return loginResponse;
    } on Response catch (e) {
      if (e.statusCode == 401) {
        return loginResponse;
      } else {
        loginResponse.error = true;
        return loginResponse;
      }
    }
  }

  Future<List<NotificationDataModel>> getUnreadNotificationsForUser() async {
    List<NotificationDataModel> notificationDataModelList = List<NotificationDataModel>();

    try {
      String userId = await mCustomSharedPrefs.getUserId();
      notificationDataModelList = await mApiInterface.getUnreadNotificationsForUser(userId);

      return notificationDataModelList;
    } on Response catch (e) {
      if (e.statusCode == 401) {
        return notificationDataModelList;
      } else {
        return notificationDataModelList;
      }
    }
  }

  Future<AuthorizationResponseModel> getAuthorizationResult(
      LoginResponseModel model, String fcmToken) async {
    AuthorizationResponseModel authorizeResponse = AuthorizationResponseModel();

    try {
      var deviceInfo = await Utils.getDeviceInfo();
      String deviceId;
      if(deviceInfo is AndroidDeviceInfo){
        deviceId = deviceInfo.androidId;
      }else if(deviceInfo is IosDeviceInfo){
        deviceId = deviceInfo.identifierForVendor;
      }
      authorizeResponse = await mApiInterface.getAuhorizationResponse(
          BaseConstants.AUTHORIZATION_PREFIX + model.tocken,
          BaseConstants.APP_ID,
          AuthorizationRequestModel(
              deviceId: deviceId,
              fcmToken: fcmToken,
              username: model.userName));

      baseConstants.BaseConstants.regexAlphaNumericLiteral=authorizeResponse.mAllowedCharacters;
      await mCustomSharedPrefs.createUserProfile(
          authorizeResponse.userId,
          model.userName,
          model.password,
          model.tocken,
          authorizeResponse.tenantId,
          authorizeResponse.siteId,
          authorizeResponse.workflowTenantId,
          authorizeResponse.warehouseManagerUserId);

       await mCustomSharedPrefs.setUserInfo(authorizeResponse);

      return authorizeResponse;
    } on Response catch (e) {
      if (e.statusCode == 401) {
        var val = await FetchDataException(mCustomSharedPrefs, mApiInterface, e)
            .exceptionHandling();
        return val == FetchDataException.SUCCESS
            ? getAuthorizationResult(model, fcmToken)
            : val;
      } else {
        authorizeResponse.error = true;
        return authorizeResponse;
      }
    }
  }

  Future<LoginResponseModel> checkUserLogged() async {
    try {
      if (await mCustomSharedPrefs.isUserLogged()) {
        LoginResponseModel loginUserResponse = await loginResult(
            LoginRequestModel(
                userName: await mCustomSharedPrefs.userProfile(),
                password: await mCustomSharedPrefs.userPassword()));
        return loginUserResponse;
      } else
        return LoginResponseModel();
    } catch (e) {
      return LoginResponseModel();
    }
  }

  Future<bool> clearUserProfile() async {
    return await mCustomSharedPrefs.deleteUserProfile();
  }

  Future<bool> onCreateActivityDetailsList(
      HashMap<String, List<DrawerItemModel>> roleMap) async {
    return await mCustomSharedPrefs.createActivityDetailsList(roleMap);
  }
}
