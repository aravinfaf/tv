import 'package:tvs_visibility/src/visibility/apiinterface/apiinterface.dart';
import 'package:tvs_visibility/src/visibility/dataprovider/sharedprefs.dart';
import 'package:tvs_visibility/src/visibility/exceptionHandler/FetchDataException.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/partserialnumberdetailsmodel/partserialnumberdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/postpartmasterdetailsmodel/postpartmasterdetailsmodel.dart';
import 'package:jaguar_resty/jaguar_resty.dart' as resty;

class PartLocationApiProvider {
  ApiInterface mApiInterface;
  CustomSharedPrefs mSharedPreferences;

  PartLocationApiProvider(this.mApiInterface,this.mSharedPreferences);

  Future<List<PostPartMasterDetailsModel>> onPartAvailableBin(List<PostPartMasterDetailsModel> model) async {
    String token=await mSharedPreferences.getToken();
    String siteMasterId=await mSharedPreferences.getSiteId();
    List<PostPartMasterDetailsModel> partMasterDetails=[];
    model.forEach((partMasterDetail){
      partMasterDetail.mSiteId=siteMasterId;
    });

    try{
      partMasterDetails=await mApiInterface.getPartAvailableBin(token, model);
    }on resty.Response catch(e){
      var val = await FetchDataException(mSharedPreferences, mApiInterface, e).exceptionHandling();
      if(FetchDataException.SUCCESS==val)
        onPartAvailableBin(model);
      else
        partMasterDetails.add(PostPartMasterDetailsModel()..mError=true);
    }
    return partMasterDetails;
  }

  Future<PartSerialNumberDetailsModel> onValidateSerialNumber(String serialNumber,int quantity) async{
    String token=await mSharedPreferences.getToken();
    String siteMasterId=await mSharedPreferences.getSiteId();
    PartSerialNumberDetailsModel partSerialNumberDetails=PartSerialNumberDetailsModel();
    PartSerialNumberDetailsModel partSerialNumberRequestDetails=PartSerialNumberDetailsModel();
    partSerialNumberRequestDetails.mScanText=serialNumber;
    partSerialNumberRequestDetails.mQuantity=quantity;
    partSerialNumberRequestDetails.mSiteMasterId=siteMasterId;

    try{
      partSerialNumberDetails=await mApiInterface.validatePartSerialNumberDetails(token, partSerialNumberRequestDetails);
    }on resty.Response catch(e){
      var val = await FetchDataException(mSharedPreferences, mApiInterface, e).exceptionHandling();
      if(FetchDataException.SUCCESS==val)
        onValidateSerialNumber(serialNumber,quantity);
      else
        partSerialNumberDetails..mError=true;
    }
    return partSerialNumberDetails;
  }
}
