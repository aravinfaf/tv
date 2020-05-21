import 'package:jaguar_resty/response/response.dart';
import 'package:tvs_visibility/src/visibility/apiinterface/apiinterface.dart';
import 'package:tvs_visibility/src/visibility/dataprovider/sharedprefs.dart';
import 'package:tvs_visibility/src/visibility/exceptionHandler/FetchDataException.dart';
import 'package:tvs_visibility/src/visibility/model/bininfodetailsmodel/bininfodetailsmodel.dart';
import 'package:tvs_visibility/src/visibility/model/binmodel/binningScanHQ.dart';
import 'package:tvs_visibility/src/visibility/model/binmodel/binsavepart.dart';
import 'package:tvs_visibility/src/visibility/model/binmodel/binvalidationresult.dart';
import 'package:tvs_visibility/src/visibility/model/binninglistmodel/binninglistmodel.dart';
import 'package:tvs_visibility/src/visibility/model/checkpodbybusinesskeymodel/checkpodbybusinesskeymodel.dart';
import 'package:tvs_visibility/src/visibility/model/postbinningfiltermodel/postbinningfiltermodel.dart';
import 'package:tvs_visibility/src/visibility/model/vpartspostresponsemodel/vpartspostresponsemodel.dart';
import 'package:tvs_visibility/src/visibility/utililty/utils.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/filedownload/pdfdownload.dart';

class BinNetProvider {
  ApiInterface mApiInterface;
  CustomSharedPrefs mCustomSharedPrefs;

  BinNetProvider(this.mApiInterface, this.mCustomSharedPrefs);

  Future<List<BinningListModel>> onBinLists(PostBinningFilterModel model) async {
    PostBinningFilterModel binningModel=PostBinningFilterModel();
    try {
      String token = await mCustomSharedPrefs.getToken();
      model.mUserid=await mCustomSharedPrefs.getUserId();

      binningModel= await mApiInterface.getBinLists(token, model);
      return binningModel.mBinningListModel??[];
    } on Response catch (e) {
      var val = await FetchDataException(mCustomSharedPrefs, mApiInterface, e)
          .exceptionHandling();
      if(val == FetchDataException.SUCCESS)
       await onBinLists(model);

      return  binningModel.mBinningListModel;
    }
  }

  Future <BinValidationResult> getBinNumberValidationResult(BinSavePart model) async {
    try {
      String token = await mCustomSharedPrefs.getToken();
      model.mUserId=await mCustomSharedPrefs.getUserId();
      model.mSiteMasterId=await mCustomSharedPrefs.getSiteID();
      model.mBinnedDate = await Utils.getCurrentDateTimeInUTCFormat();
      BinValidationResult binResponse = new BinValidationResult();
      binResponse = await mApiInterface.getBinValidationDetails(token, model);
      return binResponse;
    } on Response catch (e) {
      var val = await FetchDataException(mCustomSharedPrefs, mApiInterface, e)
          .exceptionHandling();
      return val == FetchDataException.SUCCESS ? getBinNumberValidationResult(
          model) : val;
    }
  }


  Future<VPartsPostResponseModel> onValidateVPartsQuantity(BinSavePart model) async {
    try {
      VPartsPostResponseModel vPartsPostResponseModel=VPartsPostResponseModel();
      String token = await mCustomSharedPrefs.getToken();
      model.mBinnedDate = Utils.getCurrentDateTimeInUTCFormat();
      model.mTenantId=await mCustomSharedPrefs.getTenantId();
      model.mUserId=await mCustomSharedPrefs.getWareHouseManagerId();
      model.mRequestorUserId=await mCustomSharedPrefs.getUserId();
      model.mSiteId=await mCustomSharedPrefs.getSiteID();

      vPartsPostResponseModel= await mApiInterface.getVPartsQty(token, model);
      return vPartsPostResponseModel;
    } on Response catch (e) {
      var val = await FetchDataException(mCustomSharedPrefs, mApiInterface, e)
          .exceptionHandling();
      return val == FetchDataException.SUCCESS ? onValidateVPartsQuantity(model) : val;
    }
  }

  Future <BinningScanHQ> onBinningScanHQ(BinningScanHQ model) async {
    try {
      String token = await mCustomSharedPrefs.getToken();
      return await mApiInterface.getbinningScanHQ(token, model);
    } on Response catch (e) {
      var val = await FetchDataException(mCustomSharedPrefs, mApiInterface, e).exceptionHandling();
      return val == FetchDataException.SUCCESS ? onBinningScanHQ(model) : val;
    }
  }


  Future<String> generateHusquvarnaVPartsLabel(String orderMasterId,
      String partsInOrderId, int labelCount, String partsMasterId) async {
    PDFDownload pdfDownload = PDFDownload();
    try {
      var url = mApiInterface.mBase.get.getUrl +
          'api/visibility/api/generateHusquvarnaVPartsLabel/orderMasterId/${orderMasterId}/partsInOrderId/${partsInOrderId}/labelCount/${labelCount}/partsMasterId/${partsMasterId}';
      var file = await pdfDownload.getPDFFile(url);
      return file.path;
    } on Response catch (e) {
      var val = await FetchDataException(mCustomSharedPrefs, mApiInterface, e)
          .exceptionHandling();
      return val == FetchDataException.SUCCESS ? generateHusquvarnaVPartsLabel(
          orderMasterId,
          partsInOrderId, labelCount, partsMasterId) : val;
    }
  }

  Future<List<CheckPODByBusinessKeyModel>> onCheckPODStatusByBusinessKey(String orderId) async{
    List<CheckPODByBusinessKeyModel> podStatus=[];
    try {
      String token = await mCustomSharedPrefs.getToken();
      podStatus = await mApiInterface.checkPODStatusByBusinessKey(token,orderId);
    } on Response catch (e) {
      var val = await FetchDataException(mCustomSharedPrefs, mApiInterface, e).exceptionHandling();
       if(val == FetchDataException.SUCCESS)
         onCheckPODStatusByBusinessKey(orderId);
       else
         podStatus..add(CheckPODByBusinessKeyModel()..mError=true);
    }
    return podStatus;
  }

  Future<List<BinInfoDetailsModel>> getBinInfoDetailsModel(String partsInOrderId) async{
    List<BinInfoDetailsModel> infoDetails=[];
    try{
      String token = await mCustomSharedPrefs.getToken();
      infoDetails=await mApiInterface.getBinInfoDetails(token, partsInOrderId);
    }on Response catch(e){
      var val = await FetchDataException(mCustomSharedPrefs, mApiInterface, e).exceptionHandling();
      if(val == FetchDataException.SUCCESS)
        getBinInfoDetailsModel(partsInOrderId);
      else
        infoDetails..add(BinInfoDetailsModel()..mError=true);
    }
    return infoDetails;
  }

}
