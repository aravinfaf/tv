import 'dart:collection';
import 'package:tvs_visibility/src/visibility/model/authorizationresponsemodel/authorizationresponsemodel.dart';
import 'package:tvs_visibility/src/visibility/model/draweritemmodel/draweritemmodel.dart';
import 'package:tvs_visibility/src/visibility/model/loginrequestmodel/loginrequestmodel.dart';
import 'package:tvs_visibility/src/visibility/model/loginresponsemodel/loginresponsemodel.dart';
import 'package:tvs_visibility/src/visibility/model/notificationData/notificationDataModel.dart';
import 'package:tvs_visibility/src/visibility/networkprovider/loginnetprovider.dart';

class LoginRepository{
 LoginNetProvider mLoginNetProvider;

 LoginRepository(this.mLoginNetProvider);

 Future<LoginResponseModel> login(LoginRequestModel model)=>mLoginNetProvider.loginResult(model);

 Future<List<NotificationDataModel>>  getUnreadNotificationsForUser() =>getUnreadNotificationsForUser();

 Future<AuthorizationResponseModel> authorization(LoginResponseModel model,String fcmToken)=>mLoginNetProvider.getAuthorizationResult(model,fcmToken);

 Future<LoginResponseModel> getUserLoggedDetails() =>mLoginNetProvider.checkUserLogged();

  Future<bool> deleteUserLoggedDetails() => mLoginNetProvider.clearUserProfile();

  Future<bool> createActivityDetails(HashMap<String,List<DrawerItemModel>> roleMap) async=>mLoginNetProvider.onCreateActivityDetailsList(roleMap);
}