import 'dart:collection';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvs_visibility/src/visibility/constants/StringConstants.dart';
import 'package:tvs_visibility/src/visibility/constants/baseconstants.dart';
import 'package:tvs_visibility/src/visibility/model/authorizationresponsemodel/authorizationresponsemodel.dart';
import 'package:tvs_visibility/src/visibility/model/draweritemmodel/draweritemmodel.dart';

class CustomSharedPrefs {
  Future<bool> createUserProfile(
      String userId,
      String userName,
      String password,
      String token,
      String tenantId,
      String siteId,
      String workflowTenantId,
      String warehouseManagerUserId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    sharedPreferences.setBool("isLogged", true);
    sharedPreferences.setString("token", token);
    sharedPreferences.setString("userId", userId);
    sharedPreferences.setString("userName", userName);
    sharedPreferences.setString("password", password);
    sharedPreferences.setString("tenantId", tenantId);
    sharedPreferences.setString("siteId", siteId);
    sharedPreferences.setString("workflowTenantId", workflowTenantId);
    sharedPreferences.setString(
        "warehouseManagerUserId", warehouseManagerUserId);

    return sharedPreferences != null ? true : false;
  }

  Future<bool> updateToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString("token", token);

    return sharedPreferences != null ? true : false;
  }

  Future<bool> createActivityDetailsList(HashMap<String,List<DrawerItemModel>> roleMap) async{
    List<String> activityList = [];
    List<String> lists = [];

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(roleMap["InBound"]!=null){
      for (DrawerItemModel model in roleMap["InBound"]) {
        if (!activityList.contains(model.mTitle)) activityList.add(model.mTitle);
      }
      if (activityList.contains("Gate In")) lists.add("Gate In");
      if (activityList.contains("POD")) lists.add('POD');
      if (activityList.contains('Binning')) lists.add('Binning');
      if (activityList.contains("White Marking")) lists.add("White Marking");

      for (String menu in activityList) {
        if (!lists.contains(menu)) lists.add(menu);
      }



      await sharedPreferences.setStringList("InBound", lists);
    }
    if(roleMap["OutBound"]!=null){
      activityList=[];
      for (DrawerItemModel model in roleMap["OutBound"]) {
        if (!activityList.contains(model.mTitle)) activityList.add(model.mTitle);
      }
      await sharedPreferences.setStringList("OutBound", activityList);
    }
    if(roleMap["Dealer"]!=null){
      activityList=[];
      for (DrawerItemModel model in roleMap["Dealer"]) {
        if (!activityList.contains(model.mTitle)) activityList.add(model.mTitle);
      }
      await sharedPreferences.setStringList("Dealer", activityList);
    }

    return sharedPreferences!=null?true:false;
  }

  Future<List<String>> getActivityDetailsList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> roleList = [];
    if (await sharedPreferences.getStringList("InBound") != null)
      roleList.addAll(await sharedPreferences.getStringList("InBound"));
    if (await sharedPreferences.getStringList("OutBound") != null)
      roleList.addAll(await sharedPreferences.getStringList("OutBound"));
    if (await sharedPreferences.getStringList("Dealer") != null)
      roleList.addAll(await sharedPreferences.getStringList("Dealer"));
    return roleList;
  }

  Future<bool> isUserLogged() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.get('isLogged'));
    return sharedPreferences.get('isLogged') != null &&
            sharedPreferences.get('isLogged')
        ? true
        : false;
  }

  Future<bool> userLogged() async {
    bool isLogged = await isUserLogged();
    return isLogged;
  }

  Future<HashMap<String, dynamic>> getUserDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    HashMap<String, dynamic> userDetails = HashMap();
    userDetails.putIfAbsent(
        "isLogged", () async => await sharedPreferences.getBool('isLogged'));
    userDetails.putIfAbsent(
        "token", () async => await sharedPreferences.getString('token'));
    userDetails.putIfAbsent(
        "userId", () async => await sharedPreferences.getString('userId'));
    userDetails.putIfAbsent(
        "userName", () async => await sharedPreferences.getString('username'));
    userDetails.putIfAbsent(
        "password", () async => await sharedPreferences.getString('password'));
    userDetails.putIfAbsent(
        "tenantId", () async => await sharedPreferences.getString('tenantId'));
    userDetails.putIfAbsent(
        "siteId", () async => await sharedPreferences.getString('siteId'));
    userDetails.putIfAbsent("workflowTenantId",
        () async => await sharedPreferences.getString('workflowTenantId'));
    userDetails.putIfAbsent(
        "warehouseManagerUserId",
        () async =>
            await sharedPreferences.getString('warehouseManagerUserId'));
    return userDetails;
  }

  Future<String> wareHouseManagerUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get('warehouseManagerUserId') ?? '';
  }

  Future<String> getSiteId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get('siteId') ?? '';
  }

  Future<String> userProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get('userName') ?? '';
  }

  Future<String> userPassword() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get('password') ?? '';
  }

  Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.get('token');
    return BaseConstants.AUTHORIZATION_PREFIX + token ?? '';
  }

  Future<String> getTenantId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get('tenantId') ?? '';
  }

  Future<String> getWareHouseManagerId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get('warehouseManagerUserId') ?? '';
  }

  Future<String> getSiteID() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get('siteId') ?? '';
  }

  Future<String> getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get('userId') ?? '';
  }

  Future<String> getWorkFlowTenantId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get('workflowTenantId') ?? '';
  }

  Future<bool> deleteUserProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.clear();
  }


  Future setUserInfo(AuthorizationResponseModel model) async{
    AuthorizationResponseModelSerializer serializer = new AuthorizationResponseModelSerializer();
    Map<String, dynamic> map = serializer.toMap(model);
    String userDetails = jsonEncode(map);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("UserInfo", userDetails);
  }


  Future<AuthorizationResponseModel> getUserInfo() async{
    AuthorizationResponseModelSerializer serializer = new AuthorizationResponseModelSerializer();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userDetails =  sharedPreferences.getString("UserInfo");
    AuthorizationResponseModel model = serializer.fromMap(jsonDecode(userDetails));
    return model;
  }

}
