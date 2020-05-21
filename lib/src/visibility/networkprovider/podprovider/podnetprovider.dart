import 'package:tvs_visibility/src/visibility/apiinterface/apiinterface.dart';
import 'package:tvs_visibility/src/visibility/constants/baseconstants.dart';
import 'package:tvs_visibility/src/visibility/dataprovider/sharedprefs.dart';
import 'package:tvs_visibility/src/visibility/exceptionHandler/FetchDataException.dart';
import 'package:tvs_visibility/src/visibility/model/podmodel/checkpodkeymodel.dart';
import 'package:tvs_visibility/src/visibility/model/podmodel/postfiltermodel.dart';
import 'package:jaguar_resty/response/response.dart';

class PodNetProvider {
  CustomSharedPrefs mCustomSharedPrefs;
  ApiInterface mApiInterface;

  PodNetProvider(this.mApiInterface,this.mCustomSharedPrefs);

  Future<PostFilterModel> onPodLists(PostFilterModel model) async {
    String token = await mCustomSharedPrefs.getToken();
    model.userid=await mCustomSharedPrefs.getUserId();
    model.siteId = await mCustomSharedPrefs.getSiteID();
    model.statusMasterId = BaseConstants.PODStatusMasterId;
    try {
      PostFilterModel data = await mApiInterface.getPodLists(token, model);
      return data;
    } on Response catch (e) {

        var val = await FetchDataException(mCustomSharedPrefs, mApiInterface, e)
            .exceptionHandling();
        return val == FetchDataException.SUCCESS ? onPodLists(model) : val;

    }
  }

  Future<List<CheckPodKeyModel>> onActiveTaskByVehicleInOutId(String vehicleInOutId) async {
    String token =await mCustomSharedPrefs.getToken();

/*    List<CheckPodKeyModel> checkPodKeyModelList=[];
    CheckPodKeyModel podKeyStatusModel=CheckPodKeyModel();
    await mApiInterface.getCheckPodKeyStatus(token, vehicleInOutId).then((d) {
      podKeyStatusModel=d[0];
    }).catchError((onError) {
      podKeyStatusModel = null;
    });
    checkPodKeyModelList.add(podKeyStatusModel);
    return checkPodKeyModelList;
    */

    List<CheckPodKeyModel> checkPodKeyModelList=[];
    CheckPodKeyModel podKeyStatusModel=CheckPodKeyModel();
    try {
      await mApiInterface.getCheckPodKeyStatus(token, vehicleInOutId).then((d) {
        podKeyStatusModel=d[0];
      }).catchError((onError) {
        podKeyStatusModel = null;
      });
    } on Response catch (e) {
        var val = await FetchDataException(mCustomSharedPrefs, mApiInterface, e)
            .exceptionHandling();
         val == FetchDataException.SUCCESS ? onActiveTaskByVehicleInOutId(vehicleInOutId) : val;
        podKeyStatusModel=val[0];
    }
    checkPodKeyModelList.add(podKeyStatusModel);
    return checkPodKeyModelList;
  }
}
