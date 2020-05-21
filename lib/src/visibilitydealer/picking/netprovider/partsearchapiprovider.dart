import 'package:tvs_visibility/src/visibility/apiinterface/apiinterface.dart';
import 'package:tvs_visibility/src/visibility/dataprovider/sharedprefs.dart';
import 'package:tvs_visibility/src/visibility/exceptionHandler/FetchDataException.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/partnumberdetailsmodel/partnumberdetailsmodel.dart';
import 'package:jaguar_resty/jaguar_resty.dart' as resty;

class PartSearchApiProvider {
  ApiInterface mApiInterface;
  CustomSharedPrefs mSharedPrefs;

  PartSearchApiProvider(this.mApiInterface,this.mSharedPrefs);

  Future<List<PartNumberDetailsModel>> getPartNumberSearchDetails(String partNumber,int pageNumber,int pageSize) async{
    List<PartNumberDetailsModel> list = [];
    String token=await mSharedPrefs.getToken();
    String accountId = await mSharedPrefs.getSiteID();
    try {
      list=await mApiInterface.getPartNumberSearchDetails(token, partNumber,pageNumber,pageSize);
    } on resty.Response catch (e) {
      var val = await FetchDataException(mSharedPrefs, mApiInterface, e).exceptionHandling();
      if(FetchDataException.SUCCESS==val)
        list=await getPartNumberSearchDetails(partNumber,pageNumber,pageSize);
      else
        list..add(PartNumberDetailsModel()..mError=true);
    }
    return list;
  }
}