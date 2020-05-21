import 'dart:async';
import 'dart:collection';

import 'package:rxdart/rxdart.dart';
import 'package:tvs_visibility/src/visibility/constants/businessconstants.dart';
import 'package:tvs_visibility/src/visibility/model/authorizationresponsemodel/authorizationresponsemodel.dart';
import 'package:tvs_visibility/src/visibility/model/draweritemmodel/draweritemmodel.dart';
import 'package:tvs_visibility/src/visibility/model/loginrequestmodel/loginrequestmodel.dart';
import 'package:tvs_visibility/src/visibility/model/loginresponsemodel/loginresponsemodel.dart';
import 'package:tvs_visibility/src/visibility/model/notificationData/notificationDataModel.dart';
import 'package:tvs_visibility/src/visibility/repository/loginrepository.dart';
import 'package:tvs_visibility/src/visibility/utililty/utils.dart';


class LoginBloc {
  var mProgressBar = BehaviorSubject<bool>();
  LoginRepository mLoginRepository;

  dispose() {
    mProgressBar.close();
  }

  LoginBloc(this.mLoginRepository);

  Function(bool) get showProgress => mProgressBar.sink.add;

  Observable<bool> get isLoading => mProgressBar.stream;

  Future<LoginResponseModel> onLogin(String userName, String password) async {
    showProgress(true);
    LoginResponseModel loginResponse = await mLoginRepository.login(
        LoginRequestModel(userName: userName, password: password));
    if(loginResponse.error)
      mProgressBar.addError("Something went wrong!");
    return loginResponse;
  }

  Future<AuthorizationResponseModel> authorizeResponse(
      LoginResponseModel model,String fcmToken) async {
    AuthorizationResponseModel authorizeResponse = await mLoginRepository
        .authorization(model,fcmToken);
    if(authorizeResponse.error)
      mProgressBar.addError("Something went wrong!");
    return authorizeResponse;
  }

  Future<List<NotificationDataModel>>  getUnreadNotificationsForUser() async {
    showProgress(true);
    List<NotificationDataModel> notificationDataModelList = await mLoginRepository.getUnreadNotificationsForUser();
    if(notificationDataModelList!=null && notificationDataModelList[0].error)
      mProgressBar.addError("Something went wrong!");
    else
      showProgress(false);
    return notificationDataModelList;
  }

  HashMap<String,List<DrawerItemModel>> authorizationValidation(AuthorizationResponseModel model) {
    HashMap<String,List<DrawerItemModel>> roleMap=HashMap();
    if (model.workflowProcessMasterDTOList != null &&
        model.workflowProcessMasterDTOList.length > 0) {
      for (WorkflowProcessMasterList process in model.workflowProcessMasterDTOList) {
        if (process.getProcessKey == BusinessConstants.processKey1)
          roleMap.putIfAbsent("InBound", ()=>[]);
        if (process.getProcessKey == BusinessConstants.processKey2)
          roleMap.putIfAbsent("OutBound", ()=>[]);
        if (process.getProcessKey == BusinessConstants.processKey3)
          roleMap.putIfAbsent("Dealer", ()=>[]);
        for (WorkflowActivityMasterList activity in process.getWorkFlowActivityMasterList) {
          if (process.getProcessKey == BusinessConstants.processKey1 && activity.getTaskKey == BusinessConstants.taskKey7)
            roleMap.update("InBound", (v)=>v..add(DrawerItemModel(mTitle: "Gate In",mItemIndex: 0)));
          if (process.getProcessKey == BusinessConstants.processKey1 && activity.getTaskKey == BusinessConstants.taskKey1)
            roleMap.update("InBound", (v)=>v..add(DrawerItemModel(mTitle: "POD",mItemIndex: 1)));
          if (process.getProcessKey == BusinessConstants.processKey1 && activity.getTaskKey == BusinessConstants.taskKey3)
            roleMap.update("InBound", (v)=>v..add(DrawerItemModel(mTitle: "Binning",mItemIndex: 2)));
          if(process.getProcessKey == BusinessConstants.processKey1  && activity.getTaskKey == BusinessConstants.taskKey12)
            roleMap.update("InBound", (v)=>v..add(DrawerItemModel(mTitle: activity.getTaskName, mItemIndex: 7)));
          if(process.getProcessKey == BusinessConstants.processKey1  && activity.getTaskKey == BusinessConstants.taskKey13)
            roleMap.update("InBound", (v)=>v..add(DrawerItemModel(mTitle: activity.getTaskName, mItemIndex: 7)));
          if(process.getProcessKey == BusinessConstants.processKey1  && activity.getTaskKey == BusinessConstants.taskKey14)
            roleMap.update("InBound", (v)=>v..add(DrawerItemModel(mTitle: activity.getTaskName, mItemIndex: 7)));
          if(process.getProcessKey == BusinessConstants.processKey1  && activity.getTaskKey == BusinessConstants.taskKey15)
            roleMap.update("InBound", (v)=>v..add(DrawerItemModel(mTitle: activity.getTaskName, mItemIndex: 7)));
          if(process.getProcessKey == BusinessConstants.processKey1  && activity.getTaskKey == BusinessConstants.taskKey16)
            roleMap.update("InBound", (v)=>v..add(DrawerItemModel(mTitle: activity.getTaskName, mItemIndex: 7)));
          if(process.getProcessKey == BusinessConstants.processKey1  && activity.getTaskKey == BusinessConstants.taskKey17)
            roleMap.update("InBound", (v)=>v..add(DrawerItemModel(mTitle: activity.getTaskName, mItemIndex: 7)));
          if(process.getProcessKey == BusinessConstants.processKey1  && activity.getTaskKey == BusinessConstants.taskKey18)
            roleMap.update("InBound", (v)=>v..add(DrawerItemModel(mTitle: activity.getTaskName, mItemIndex: 7)));
          if(process.getProcessKey == BusinessConstants.processKey1  && activity.getTaskKey == BusinessConstants.taskKey19)
            roleMap.update("InBound", (v)=>v..add(DrawerItemModel(mTitle: activity.getTaskName, mItemIndex: 7)));
          if(process.getProcessKey == BusinessConstants.processKey1  && activity.getTaskKey == BusinessConstants.taskKey20)
            roleMap.update("InBound", (v)=>v..add(DrawerItemModel(mTitle: activity.getTaskName, mItemIndex: 7)));
          if(process.getProcessKey == BusinessConstants.processKey1  && activity.getTaskKey == BusinessConstants.taskKey21)
            roleMap.update("InBound", (v)=>v..add(DrawerItemModel(mTitle: activity.getTaskName, mItemIndex: 7)));
          if(process.getProcessKey == BusinessConstants.processKey1  && activity.getTaskKey == BusinessConstants.taskKey22)
            roleMap.update("InBound", (v)=>v..add(DrawerItemModel(mTitle: activity.getTaskName, mItemIndex: 7)));
          if(process.getProcessKey == BusinessConstants.processKey2 && activity.getTaskKey ==BusinessConstants.taskKey23)
            roleMap.update("OutBound", (v)=>v..add(DrawerItemModel(mTitle: "Single Bin Transfer",mItemIndex: 5)));
          if(process.getProcessKey == BusinessConstants.processKey1 && activity.getTaskKey == BusinessConstants.taskKey24)
            roleMap.update("InBound", (v)=>v..add(DrawerItemModel(mTitle: activity.getTaskName, mItemIndex: 7)));
          if(process.getProcessKey == BusinessConstants.processKey1 && activity.getTaskKey == BusinessConstants.taskKey25)
            roleMap.update("InBound", (v)=>v..add(DrawerItemModel(mTitle: activity.getTaskName, mItemIndex: 7)));
          if(process.getProcessKey == BusinessConstants.processKey2 && activity.getTaskKey == BusinessConstants.taskKey5)
            roleMap.update("OutBound", (v)=>v..add(DrawerItemModel(mTitle: "Picking",mItemIndex: 3)));
          if (process.getProcessKey == BusinessConstants.processKey2 &&
              activity.getTaskKey == BusinessConstants.taskKey11)
            roleMap.update("OutBound", (v) => v..add(DrawerItemModel(mTitle: "Dispatch", mItemIndex: 4)));

          if(process.getProcessKey == BusinessConstants.processKey3 && activity.getTaskKey == BusinessConstants.taskKey8)
            roleMap.update("Dealer", (v)=>v..add(DrawerItemModel(mTitle: "Dealer Binning",mItemIndex: 4)));
          if(process.getProcessKey == BusinessConstants.processKey3 && activity.getTaskKey == BusinessConstants.taskKey9)
            roleMap.update("Dealer", (v)=>v..add(DrawerItemModel(mTitle: "Dealer Picking",mItemIndex: 5)));
          if(process.getProcessKey == BusinessConstants.processKey3 && activity.getTaskKey == BusinessConstants.taskKey10)
            roleMap.update("Dealer", (v)=>v..add(DrawerItemModel(mTitle: "Dealer Bin to Bin",mItemIndex: 6)));
        }
      }
    } else {
      roleMap..putIfAbsent("NO PROCESS", ()=>[]);
    }
    return roleMap;
  }

  Future<LoginResponseModel> onCheckUserLogged() async{
    LoginResponseModel loginResponse = await mLoginRepository.getUserLoggedDetails();
    if(Utils.isEmpty(loginResponse.tocken))
      showProgress(false);
    return loginResponse;
  }

  Future<bool> deleteLoggedUserDetails() async{
    return await mLoginRepository.deleteUserLoggedDetails();
  }

  Future<bool> createActivityDetails(HashMap<String,List<DrawerItemModel>> roleMap) async{
    return await mLoginRepository.createActivityDetails(roleMap);
  }
}
