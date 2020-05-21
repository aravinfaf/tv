import 'package:jaguar_resty/response/response.dart';
import 'package:tvs_visibility/src/visibility/apiinterface/apiinterface.dart';
import 'package:tvs_visibility/src/visibility/dataprovider/sharedprefs.dart';
import 'package:tvs_visibility/src/visibility/exceptionHandler/FetchDataException.dart';
import 'package:tvs_visibility/src/visibility/model/despatchlistmodel/activetaskresponsemodel.dart';
import 'package:tvs_visibility/src/visibility/model/despatchlistmodel/despatchdetailstatusmodel.dart';
import 'package:tvs_visibility/src/visibility/model/despatchlistmodel/dispatchdetailsmodel.dart';
import 'package:tvs_visibility/src/visibility/model/despatchlistmodel/scandespatchmodel.dart';
import 'package:tvs_visibility/src/visibility/model/getdispatchdetailsmodel/getdispatchdetailsmodel.dart';
import 'package:tvs_visibility/src/visibility/model/getmodeoftransportmodel/getmodeoftransportmodel.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/filedownload/pdfdownload.dart';

class DispatchProvider {
  ApiInterface mApiInterface;
  CustomSharedPrefs mCustomSharedPrefs;
  String token;

  DispatchProvider(this.mApiInterface, this.mCustomSharedPrefs);

  Future<List<DispatchListDTO>> onDispatchList(DispatchDetailsDto model) async {
    try {
      token = await mCustomSharedPrefs.getToken();
      DispatchDetailsDto data = DispatchDetailsDto();
      data = await mApiInterface.generateDispatchDetails(token, model);
      return data.mGenericDTOList ?? [];
    } on Response catch (e) {
      var val = await FetchDataException(mCustomSharedPrefs, mApiInterface, e)
          .exceptionHandling();
      return val == FetchDataException.SUCCESS ? onDispatchList(model) : val;
    }
  }

  Future<List<ActiveTaskConsolidationModel>> onActiveList(
      String consolidationId) async {
    try {
      token = await mCustomSharedPrefs.getToken();
      List<ActiveTaskConsolidationModel> data = [];
      data = await mApiInterface.getActiveConsolidationDetails(
          token, consolidationId);
      return data;
    } on Response catch (e) {
      var val = await FetchDataException(mCustomSharedPrefs, mApiInterface, e)
          .exceptionHandling();
      return val == FetchDataException.SUCCESS
          ? onActiveList(consolidationId)
          : val;
    }
  }

  Future<DespatchDetailStatus> getDespatchDetailStatus(
      String consolidationId) async {
    try {
      token = await mCustomSharedPrefs.getToken();
      DespatchDetailStatus data = DespatchDetailStatus();
      data =
          await mApiInterface.getDespatchDetailStatus(token, consolidationId);
      return data;
    } on Response catch (e) {
      var val = await FetchDataException(mCustomSharedPrefs, mApiInterface, e)
          .exceptionHandling();
      return val == FetchDataException.SUCCESS
          ? onActiveList(consolidationId)
          : val;
    }
  }

  Future<GetDispatchDetailsModel> getDispatchDetails(String deliveryType,
      String consolidationId, String actorType, String orderMasterId) async {
    GetDispatchDetailsModel dispatchDetailsList = GetDispatchDetailsModel();
    try {
      token = await mCustomSharedPrefs.getToken();
      dispatchDetailsList = await mApiInterface.getDispatchDropdownList(
          token,
          deliveryType,
          await mCustomSharedPrefs.getSiteID(),
          consolidationId,
          actorType,
          orderMasterId);
      return dispatchDetailsList;

    } on Response catch (e) {
      var val = await FetchDataException(mCustomSharedPrefs, mApiInterface, e)
          .exceptionHandling();
      return val == FetchDataException.SUCCESS
          ? getDispatchDetails(
              deliveryType, consolidationId, actorType, orderMasterId)
          : val;
    }
  }

  Future<List<GetModeOfTransportModel>> onModeOfTransportDetails() async {
    List<GetModeOfTransportModel> modeOfTransport = [];

    try {
      token = await mCustomSharedPrefs.getToken();
      modeOfTransport = await mApiInterface.getModeOfTransportDetails(token);
      return modeOfTransport;
    } on Response catch (e) {
      var val = await FetchDataException(mCustomSharedPrefs, mApiInterface, e)
          .exceptionHandling();
      return val == FetchDataException.SUCCESS
          ? onModeOfTransportDetails()
          : val;
    }
  }

  Future<DespatchDetailStatus> scanDespatch(ScanDespatchModel model) async {
    try {
      token = await mCustomSharedPrefs.getToken();
      DespatchDetailStatus despatchDetailStatus = DespatchDetailStatus();
      despatchDetailStatus = await mApiInterface.scanDespatch(token, model);
      return despatchDetailStatus;
    } on Response catch (e) {
      var val = await FetchDataException(mCustomSharedPrefs, mApiInterface, e)
          .exceptionHandling();
      return val == FetchDataException.SUCCESS ? scanDespatch(model) : val;
    }
  }

  Future<String> generatePackingSlip(String userId, String vNo,
      String cId,String modId) async {
    PDFDownload pdfDownload = PDFDownload();
    try {
      var url = mApiInterface.mBase.get.getUrl +
          'api/visibility/api/generatePackageSlip/userId/$userId/vNo/$vNo/cId/$cId/modId/$modId';
      var file = await pdfDownload.getPDFFile(url);
      return file != null ? file.path : null;
    } on Response catch (e) {
      var val = await FetchDataException(mCustomSharedPrefs, mApiInterface, e)
          .exceptionHandling();
      return val == FetchDataException.SUCCESS
          ? generatePackingSlip(userId, vNo, cId,modId)
          : val;
    }
  }
}
