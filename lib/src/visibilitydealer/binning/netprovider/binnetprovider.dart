import 'package:tvs_visibility/src/visibility/dataprovider/sharedprefs.dart';
import 'package:tvs_visibility/src/visibility/exceptionHandler/FetchDataException.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/model/binlocationmodel/binScanningRequest.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/model/binlocationmodel/binScanningResponse.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/model/binlocationmodel/binlocationmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/model/partorbinvalidationmodel/partorbinvalidationmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/model/postbindetailsmodel/postbindetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/bintobintransfer/model/binmasterdetailsmodel/binmasterdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/bintobintransfer/model/binmasterdetailsrequestmodel/binmasterdetailsrequestmodel.dart';
import 'package:tvs_visibility/src/visibility/apiinterface/apiinterface.dart';
import 'package:jaguar_resty/jaguar_resty.dart' as resty;

class BinNetProvider {
  ApiInterface mApiInterface;
  CustomSharedPrefs mSharedPrefs;

  BinNetProvider(this.mApiInterface, this.mSharedPrefs);

  Future<List<BinLocationModel>> onBinLocationList(String binLocation) async {
    List<BinLocationModel> binningSearchList = [];
    String token = await mSharedPrefs.getToken();
    String siteId = await mSharedPrefs.getSiteId();

    try {
      binningSearchList = await mApiInterface.searchBinLocation(token, binLocation, siteId);
    } on resty.Response catch (e) {
      var val = await FetchDataException(mSharedPrefs, mApiInterface, e).exceptionHandling();
      if(FetchDataException.SUCCESS==val)
        onBinLocationList(binLocation);
    }
    return binningSearchList;
  }

  Future<PostBinDetailsModel> partBinning(PostBinDetailsModel postBinningDetailModel) async {
    String token = await mSharedPrefs.getToken();
    String siteMasterId=await mSharedPrefs.getSiteId();
    postBinningDetailModel.mSiteMasterId=siteMasterId;
    PostBinDetailsModel binnedDetails=PostBinDetailsModel();
    try {
      binnedDetails = await mApiInterface.partBinning(token, postBinningDetailModel);
    } on resty.Response catch (e) {
      var val = await FetchDataException(mSharedPrefs, mApiInterface, e).exceptionHandling();
      if(FetchDataException.SUCCESS==val)
        partBinning(postBinningDetailModel);
      else
        binnedDetails..mError=true;
    }
    return binnedDetails;
  }

  Future<PartOrBinValidationModel> onValidatePartOrBin(String binOrPart, String orderId,String partNumber) async{
    PartOrBinValidationModel partOrBinModel=PartOrBinValidationModel();
    String siteMasterId=await mSharedPrefs.getSiteId();
    String token=await mSharedPrefs.getToken();

    partOrBinModel.mScanText=binOrPart;
    partOrBinModel.mOrderId=orderId;
    partOrBinModel.mPartNumber=partNumber;
    partOrBinModel.mSiteMasterId=siteMasterId;

    try{
      partOrBinModel=await mApiInterface.validatePartOrBin(token,partOrBinModel);

    }on resty.Response catch(e){
      var val = await FetchDataException(mSharedPrefs, mApiInterface, e).exceptionHandling();
      if(FetchDataException.SUCCESS==val)
        onValidatePartOrBin(binOrPart,orderId,partNumber);
      else
        partOrBinModel.mError=true;
    }
    return partOrBinModel;
  }

  Future<BinScanningResponse> onValidatePartOrBin1(BinScanningRequest request) async{
    String token=await mSharedPrefs.getToken();
    BinScanningResponse response;
    try{
      response = await mApiInterface.validatePartOrBin1(token, request);

    }on resty.Response catch(e){
      var val = await FetchDataException(mSharedPrefs, mApiInterface, e).exceptionHandling();
      if(FetchDataException.SUCCESS==val)
        onValidatePartOrBin1(request);
      else
        response = null;
    }
    return response;
  }


  Future<BinScanningResponse> vPartBinning(BinScanningRequest request) async{
    String token=await mSharedPrefs.getToken();
    BinScanningResponse response;
    try{
      response = await mApiInterface.vPartBinning(token, request);

    }on resty.Response catch(e){
      var val = await FetchDataException(mSharedPrefs, mApiInterface, e).exceptionHandling();
      if(FetchDataException.SUCCESS==val)
        onValidatePartOrBin1(request);
      else
        response = null;
    }
    return response;
  }


  Future<BinMasterDetailsModel> onSingleBinToBinTransfer(String binOrPart, String binId) async{
    BinMasterDetailsModel binMasterDetails=BinMasterDetailsModel();
    BinMasterDetailsRequestModel binMasterDetailsRequestModel=BinMasterDetailsRequestModel();
    String siteMasterId=await mSharedPrefs.getSiteId();
    String token=await mSharedPrefs.getToken();
    binMasterDetailsRequestModel.mScanText=binOrPart;
    binMasterDetailsRequestModel.mSiteMasterId=siteMasterId;
    binMasterDetailsRequestModel.mBinsMasterId=binId;

    try{
      binMasterDetails=await mApiInterface.singleBinToBinTransfer(token,binMasterDetailsRequestModel);
    }on resty.Response catch(e){
      var val = await FetchDataException(mSharedPrefs, mApiInterface, e).exceptionHandling();
      if(FetchDataException.SUCCESS==val)
        onSingleBinToBinTransfer(binOrPart,binId);
      else
        binMasterDetails.mError=true;
    }
    return binMasterDetails;
  }

}
