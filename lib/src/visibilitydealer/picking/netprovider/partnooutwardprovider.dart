import 'package:tvs_visibility/src/visibility/apiinterface/apiinterface.dart';
import 'package:tvs_visibility/src/visibility/dataprovider/sharedprefs.dart';
import 'package:tvs_visibility/src/visibility/exceptionHandler/FetchDataException.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/postdispatchmasterdetailsmodel/postdispatchmasterdetailsmodel.dart';
import 'package:jaguar_resty/jaguar_resty.dart' as resty;

class PartNumberOutwardProvider {
  ApiInterface mApiInterface;
  CustomSharedPrefs mSharedPrefs;

  PartNumberOutwardProvider(this.mApiInterface,this.mSharedPrefs);

  Future<List<PostDispatchMasterDetailsModel>> onDispatchMaster(String dispatchTypeMasterId, String orderNumber,
      List<PostDispatchMasterDetailsModel> scanList,String userName,String mobile) async {
    String token=await mSharedPrefs.getToken();
    String siteMasterId=await mSharedPrefs.getSiteId();
    List<PostDispatchMasterDetailsModel> dispatchResponseList=[];
    scanList.forEach((model){
      model.mSiteMasterId=siteMasterId;
      model.mDeliveryTypeMasterId=dispatchTypeMasterId;
      model.mOrderId=orderNumber;
      model.mDespatchMobile=mobile;
      model.mDespatchName=userName;
    });

    try{
      dispatchResponseList=await mApiInterface.postDispatchMaster(token, scanList);
    }on resty.Response catch(e){
      var val = await FetchDataException(mSharedPrefs, mApiInterface, e).exceptionHandling();
      if(FetchDataException.SUCCESS==val)
        onDispatchMaster(dispatchTypeMasterId,orderNumber, scanList,userName,mobile);
      else
      dispatchResponseList.add(PostDispatchMasterDetailsModel()..mError=true);
    }
    return dispatchResponseList;
  }

}

