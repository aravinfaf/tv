import 'package:tvs_visibility/src/visibility/dataprovider/sharedprefs.dart';
import 'package:tvs_visibility/src/visibility/exceptionHandler/FetchDataException.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/model/ordermastermodel/ordermastermodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/model/postfilterdetailsmodel/postfilterdetailsmodel.dart';
import 'package:tvs_visibility/src/visibility/apiinterface/apiinterface.dart';
import 'package:jaguar_resty/jaguar_resty.dart' as resty;

class OrderMasterNetProvider {
  ApiInterface mApiInterface;
  CustomSharedPrefs mSharedPrefs;

  OrderMasterNetProvider(this.mApiInterface, this.mSharedPrefs);

  Future<List<OrderMasterModel>> getOrderMasterDetails(PostFilterDetailsModel postFilterModel) async {
    List<OrderMasterModel> orderMasterDetails = [];
    String token = await mSharedPrefs.getToken();
    postFilterModel.mUserId = await mSharedPrefs.getUserId();
    postFilterModel.mSiteId = await mSharedPrefs.getSiteId();
    try {
      orderMasterDetails = await mApiInterface.getOrderMasterDetails(token, postFilterModel);
    } on resty.Response catch (e) {
      var val = await FetchDataException(mSharedPrefs, mApiInterface, e).exceptionHandling();
      if(FetchDataException.SUCCESS==val)
        getOrderMasterDetails(postFilterModel);
      else
        orderMasterDetails..add(OrderMasterModel()..mError=true);
    }
    return orderMasterDetails;
  }

}
