import 'package:jaguar_resty/jaguar_resty.dart' as resty;
import 'package:tvs_visibility/src/visibility/apiinterface/apiinterface.dart';
import 'package:tvs_visibility/src/visibility/dataprovider/sharedprefs.dart';
import 'package:tvs_visibility/src/visibility/exceptionHandler/FetchDataException.dart';

class SingleBinToBinProvider {
  CustomSharedPrefs mCustomSharedPrefs;
  ApiInterface mApiInterface;
  int statusCode;

  SingleBinToBinProvider(this.mCustomSharedPrefs, this.mApiInterface);

  Future<int> onSingleBinToBinTransfer(String binOrPart, String binId) async {
    String siteMasterId = await mCustomSharedPrefs.getSiteId();
    String token = await mCustomSharedPrefs.getToken();

    try {
      statusCode = await mApiInterface.singleBintoBinVisibility(
          token,binId,binOrPart,siteMasterId);
    } on resty.Response catch (e) {
      var val = await FetchDataException(mCustomSharedPrefs, mApiInterface, e)
          .exceptionHandling();
      return val == FetchDataException.SUCCESS
          ? onSingleBinToBinTransfer(binOrPart, binId)
          : null;
    }
    return statusCode;
  }
}
