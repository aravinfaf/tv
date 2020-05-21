import 'package:jaguar_resty/jaguar_resty.dart';
import 'package:tvs_visibility/src/visibility/apiinterface/apiinterface.dart';
import 'package:tvs_visibility/src/visibility/dataprovider/sharedprefs.dart';
import 'package:tvs_visibility/src/visibility/exceptionHandler/FetchDataException.dart';
import 'package:tvs_visibility/src/visibility/model/podmodel/postpoddetailsmodel.dart';
import 'package:jaguar_resty/jaguar_resty.dart' as resty;
import 'package:tvs_visibility/src/visibility/utililty/utils.dart';

class SavePodProvider {
  CustomSharedPrefs mCustomSharedPrefs;
  ApiInterface mApiInterface;

  SavePodProvider(this.mCustomSharedPrefs, this.mApiInterface);

  Future<String> getSavePodResult(PostPodDetailsModel podDetailsModel) async {
    String token = await mCustomSharedPrefs.getToken();

    podDetailsModel.siteMasterId = await mCustomSharedPrefs.getSiteID();
    podDetailsModel.userId = await mCustomSharedPrefs.wareHouseManagerUserId();
    podDetailsModel.podIssueDate =  Utils.getCurrentDateTimeInUTCFormat();

    try {
      StringResponse htmlData;
      htmlData = await mApiInterface.getGeneratedPOD(token, podDetailsModel);
      print('StringResponse= ${htmlData.body}');
      return htmlData.body;
    } on Response catch (e) {
      print('StringResponse= ${e.body}');
        var val = await FetchDataException(mCustomSharedPrefs, mApiInterface, e)
            .exceptionHandling();
        return val == FetchDataException.SUCCESS ? getSavePodResult(podDetailsModel) : "ERROR";

    }
  }
}
