import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:tvs_visibility/src/visibility/bloc/loginbloc.dart';
import 'package:tvs_visibility/src/visibility/constants/StringConstants.dart';
import 'package:tvs_visibility/src/visibility/constants/baseconstants.dart';
import 'package:tvs_visibility/src/visibility/model/authorizationresponsemodel/authorizationresponsemodel.dart';
import 'package:tvs_visibility/src/visibility/model/draweritemmodel/draweritemmodel.dart';
import 'package:tvs_visibility/src/visibility/model/loginresponsemodel/loginresponsemodel.dart';
import 'package:tvs_visibility/src/visibility/ui/homeview.dart';
import 'package:tvs_visibility/src/visibility/ui/updateview.dart';
import 'package:tvs_visibility/src/visibility/utililty/utils.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customprogressindicator/customprogress.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customprogressindicator/customretry.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customview/customalertdialog.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customview/customtoast.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customview/customwebview.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/navigaton/navigationutils.dart';

class LoginView extends StatefulWidget {
  LoginViewState mLoginViewState;

  @override
  LoginViewState createState() {
    mLoginViewState = LoginViewState();
    return mLoginViewState;
  }
}

class LoginViewState extends State<LoginView> implements AlertDialogListener {
  final formKey = new GlobalKey<FormState>();
  LoginBloc mLoginBloc;
  List<DrawerItemModel> mDrawerItemModel = [];
  HashMap<String, List<DrawerItemModel>> roleMap;
  String mUsername;
  String mPassword;

  String mFCMToken;
  String appVersion;

  LoginViewState() {
    var container = kiwi.Container();
    mLoginBloc = container<LoginBloc>();
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  void dispose() {
    mLoginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
          initialData: true,
          stream: mLoginBloc.isLoading,
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data != null && !snapshot.data)
              return Center(
                child: Form(
                  key: formKey,
                  child: Container(
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("images/login_bg.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: ListView(
                      shrinkWrap: false,
                      children: <Widget>[
                        Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(height: 25.0),
                                image(),
                                SizedBox(height: 30.0),
                                tffUserName(),
                                SizedBox(height: 25.0),
                                tffPassword(),
                                SizedBox(height: 25.0),
                                rbSubmit(),
                                SizedBox(height: 100.0),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceAround,
                                  children: <Widget>[
                                    textVersion(),
                                    textBtnPrivacyPolicy()
                                  ],
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              );
            else if (snapshot.hasError)
              return CustomRetry(
                isTitleRequired: true,
                retry: submit,
              );
            else
              return CustomProgress();
          }),
    );
  }

  Widget image() {
    return Hero(
      tag: 'hero',
      child: new Container(
        color: Colors.transparent,
        child: new Image.asset('images/visibility_app_icon.png'),
        width: 175.0,
        height: 175.0,
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      ),
    );
  }

  Widget tffUserName() {
    return Container(
      margin: EdgeInsets.only(left: 40, right: 40),
      child: TextFormField(
          keyboardType: TextInputType.text,
          validator: (val) => val.length == 0 ? "Enter UserName" : null,
          onSaved: (val) => this.mUsername = val,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              fillColor: Colors.white,
              hintText: 'User Name',
              filled: true)),
    );
  }

  Widget tffPassword() {
    return Container(
      margin: EdgeInsets.only(left: 40, right: 40),
      child: TextFormField(
          keyboardType: TextInputType.text,
          obscureText: true,
          validator: (val) => val.length == 0 ? 'Enter Password' : null,
          onSaved: (val) => this.mPassword = val,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              fillColor: Colors.white,
              hintText: 'Password',
              filled: true)),
    );
  }

  Widget textVersion() {
    return Text(
      'Version: $appVersion',
      style: TextStyle(color: Colors.white),
    );
  }

  Widget textBtnPrivacyPolicy() {
    return InkWell(
      child: Text(
        'Privacy policy',
        style: TextStyle(
            color: Colors.white, decoration: TextDecoration.underline),
      ),
      onTap: () {
        navigateToPrivacyPolicy();
      },
    );
  }

  Widget rbSubmit() {
    return new Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 110, right: 110),
      child: new RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        onPressed: () {
          if (this.formKey.currentState.validate()) {
            formKey.currentState.save();
          } else {
            return null;
          }
          submit();
        },
        padding: EdgeInsets.all(12.0),
        elevation: 5.0,
        color: Colors.blue[900],
        child: Text('LOGIN', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  initialize() {
    getAppInfo();
    checkUserLogged();
  }

  submit() async {
    if (await Utils.onCheckNetworkConnection()) {
      LoginResponseModel loginResponse = LoginResponseModel();
      loginResponse = await mLoginBloc.onLogin(mUsername, mPassword);
      if (Utils.isEmpty(loginResponse.tocken) && !loginResponse.error) {
        mLoginBloc.showProgress(false);
        CustomToast.showToast('Invalid credentials');
      } else {
        authorize(loginResponse);
      }
    } else {
      mLoginBloc.showProgress(false);
      CustomToast.showToast(StringConstants.NO_INTERNET_CONNECTION);
    }
  }

  authorize(LoginResponseModel loginResponse) async {
    AuthorizationResponseModel authorizeResponse =
    await mLoginBloc.authorizeResponse(loginResponse, mFCMToken);
    if (!authorizeResponse.error) {
      roleMap = mLoginBloc.authorizationValidation(authorizeResponse);
      if (!Utils.isEmpty(authorizeResponse.appVersion) && appVersion != authorizeResponse.appVersion) {
        navigateToUpdateView();
      } else if (roleMap.length > 0) {
          navigateInboundOutBound(roleMap: roleMap);
        } else {
          mLoginBloc.showProgress(false);
          CustomToast.showToast(
              "No InBound and OutBound Role is Assigned to Current User");
          mLoginBloc.deleteLoggedUserDetails();
        }
    }
  }

  navigateInboundOutBound(
      {HashMap<String, List<DrawerItemModel>> roleMap}) async {
    List<DrawerItemModel> drawerList = [];
    roleMap.values.map((menus) {
      if (menus != null) {
        drawerList.addAll(menus);
      }
    }).toList();

    if (drawerList.length != 0) {
      await mLoginBloc.createActivityDetails(roleMap);
      navigateToHomeView();
    } else {
      mLoginBloc.showProgress(false);
      CustomToast.showToast("No InBound Role is Assign to Current User");
      mLoginBloc.deleteLoggedUserDetails();
    }
  }

  inBoundNavigate({HashMap<String, List<DrawerItemModel>> roleMap}) async {
    List<DrawerItemModel> inBoundList =
    roleMap["InBound"] != null ? roleMap["InBound"].toList() : [];
    if (inBoundList.length != 0) {
      await mLoginBloc.createActivityDetails(roleMap);
      navigateToHomeView();
    } else {
      mLoginBloc.showProgress(false);
      CustomToast.showToast("No InBound Role is Assign to Current User");
      mLoginBloc.deleteLoggedUserDetails();
    }
  }

  outBoundNavigate(
      {HashMap<String, List<DrawerItemModel>> roleMap, int index}) async {
    List<DrawerItemModel> outBoundList =
    roleMap["OutBound"] != null ? roleMap["OutBound"].toList() : [];
    if (outBoundList.length != 0) {
      await mLoginBloc.createActivityDetails(roleMap);
      navigateToHomeView();
    } else {
      mLoginBloc.showProgress(false);
      CustomToast.showToast("No OutBound Role is Assign to Current User");
      mLoginBloc.deleteLoggedUserDetails();
    }
  }

  navigateToHomeView() {
    NavigationUtils.pushReplacement(context, HomeView());
  }

  navigateToUpdateView() {
    NavigationUtils.pushReplacement(context, UpdateActivity());
  }

  @override
  void onSelectAlertDialog(int index, String activity, List<String> list) {
    if (activity == 'OutBound')
      outBoundNavigate(roleMap: roleMap);
    else
      inBoundNavigate(roleMap: roleMap);
  }

  void navigateToPrivacyPolicy() {
    NavigationUtils.push(
        context,
        CustomWebView(
            title: 'Privacy Policy',
            path: BaseConstants.PRIVACY_DOCUMENT,
            isAssets: true,
            isPrintable: false));
  }

  checkUserLogged() async {
    if (await Utils.onCheckNetworkConnection()) {
      mLoginBloc.showProgress(true);
      LoginResponseModel model = await mLoginBloc.onCheckUserLogged();
      if (!Utils.isEmpty(model.tocken)) authorize(model);
    } else
      mLoginBloc.showProgress(false);
  }

  getAppInfo() async {
    var appInfo = await Utils.getApplicationInfo();
    appVersion = appInfo.version;
  }

}
