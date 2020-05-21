import 'package:jaguar_resty/response/response.dart';
import 'package:tvs_visibility/src/visibility/apiinterface/apiinterface.dart';
import 'package:tvs_visibility/src/visibility/dataprovider/sharedprefs.dart';
import 'package:tvs_visibility/src/visibility/exceptionHandler/FetchDataException.dart';
import 'package:tvs_visibility/src/visibility/model/gateinout/creategatein.dart';
import 'package:tvs_visibility/src/visibility/model/gateinout/creategateout.dart';
import 'package:tvs_visibility/src/visibility/model/podmodel/postfiltermodel.dart';
import 'package:tvs_visibility/src/visibility/utililty/utils.dart';

class GateNetProvider {
  ApiInterface mApiInterface;
  CustomSharedPrefs mCustomSharedPrefs;
   String tokenSample='';

  GateNetProvider(this.mApiInterface, this.mCustomSharedPrefs);

  Future<PostFilterModel> onGateLists(PostFilterModel model) async {
    String token = await mCustomSharedPrefs.getToken();
    try {
      PostFilterModel data = await mApiInterface.getGateLists(token, model);
      return data;
    } on Response catch (e) {
      var val = await FetchDataException(mCustomSharedPrefs, mApiInterface, e)
          .exceptionHandling();
      return val == FetchDataException.SUCCESS ? onGateLists(model) : null;
    }
  }

  Future<int> onGateIn(CreateGateInModel model) async {
    String token = await mCustomSharedPrefs.getToken();

    model.vehicleInTime = Utils.getCurrentDateTimeInUTCFormat();
    model.siteMasterId = await mCustomSharedPrefs.getSiteID();
    model.workFlowTenantId = await mCustomSharedPrefs.getWorkFlowTenantId();

    try {
      var response = await mApiInterface.ongatein(token, model);
      return response;
    } on Response catch (e) {

        var val = await FetchDataException(mCustomSharedPrefs, mApiInterface, e)
            .exceptionHandling();
        return val == FetchDataException.SUCCESS ?  onGateIn(model) : val;
    }
  }

  Future<bool> onGateOut(CreateGateOutModel createGateOutModel) async {
    String token = await mCustomSharedPrefs.getToken();
    createGateOutModel.gateOutTime = await  Utils.getCurrentDateTimeInUTCFormat();

    try {
      bool data = await mApiInterface.onGateOut(token,createGateOutModel);
      return data;
    } on Response catch (e) {
        var val = await FetchDataException(mCustomSharedPrefs, mApiInterface, e)
            .exceptionHandling();
        return val == FetchDataException.SUCCESS ? onGateOut(createGateOutModel) : val;

    }
  }
}



