import 'package:jaguar_resty/response/response.dart';
import 'package:tvs_visibility/src/visibility/apiinterface/apiinterface.dart';
import 'package:tvs_visibility/src/visibility/dataprovider/sharedprefs.dart';
import 'package:tvs_visibility/src/visibility/exceptionHandler/FetchDataException.dart';
import 'package:tvs_visibility/src/visibility/model/picking/CustomPickList.dart';
import 'package:tvs_visibility/src/visibility/model/picking/PartScanningInbound.dart';
import 'package:tvs_visibility/src/visibility/model/picking/PickingAlternateLocationResult.dart';
import 'package:tvs_visibility/src/visibility/model/picking/PickingExcessMaster.dart';
import 'package:tvs_visibility/src/visibility/model/picking/PickingResult.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/filedownload/pdfdownload.dart';

class PickingProvider {
  ApiInterface mApiInterface;
  CustomSharedPrefs mCustomSharedPrefs = CustomSharedPrefs();

  PickingProvider(this.mApiInterface,this.mCustomSharedPrefs);

  Future<CustomPickList> onpickingList(CustomPickList model) async {
    String token = await mCustomSharedPrefs?.getToken();
    try {
    //  var api = await apiModule.getBaseApi(repo);
      CustomPickList data=CustomPickList();
      data= await mApiInterface.getpickingList(token, model);
      return data;
    } on Response catch (e) {
        var val = await FetchDataException(mCustomSharedPrefs, mApiInterface, e)
            .exceptionHandling();
        return val == FetchDataException.SUCCESS ? onpickingList(model) : val;
    }
  }

  Future<int> onShortPick(ExcessMaster model) async {
    String token = await mCustomSharedPrefs.getToken();
    try {
    //  var api = await apiModule.getBaseApi(repo);
      int data = await mApiInterface.shortPickQty(token, model);
      return data;
    } on Response catch (e) {

        var val = await FetchDataException(mCustomSharedPrefs, mApiInterface, e)
            .exceptionHandling();
        return val == FetchDataException.SUCCESS ? onShortPick(model) : val;
    }
  }

  Future<PickScanningResult> partScanningInbound(PartScanningInbound partScanningInboundModel) async {
    String token = await mCustomSharedPrefs.getToken();
    try {
     // var api = await apiModule.getBaseApi(repo);
      PickScanningResult pickScanningResult=new PickScanningResult();
      pickScanningResult = await mApiInterface.partScanningInbound(
          token, partScanningInboundModel);
      return pickScanningResult;

    } on Response catch (e) {

        var val = await FetchDataException(mCustomSharedPrefs, mApiInterface, e)
            .exceptionHandling();
        return val == FetchDataException.SUCCESS ? partScanningInbound(partScanningInboundModel) : val;

    }
  }

  Future<PickScanningResult> partScaningOutbound(PartScanningInbound partScanningInboundModel) async {
    String token = await mCustomSharedPrefs.getToken();
    try {
     // var api = await apiModule.getBaseApi(repo);

      PickScanningResult partScanningInbound=new PickScanningResult();
      partScanningInbound = await mApiInterface.partScanningOutbound(
          token,partScanningInboundModel);
      return partScanningInbound;

    } on Response catch (e) {

        var val = await FetchDataException(mCustomSharedPrefs, mApiInterface, e)
            .exceptionHandling();
        return val == FetchDataException.SUCCESS ? partScaningOutbound(partScanningInboundModel) : val;
    }
  }

  Future<AlternateLocationResult> getAlternateLocation(PartScanningInbound partScanningInbound) async {
    String token = await mCustomSharedPrefs?.getToken();
    try {
    //  var api = await apiModule.getBaseApi(repo);
      AlternateLocationResult alternateLocationResult=new AlternateLocationResult();
      alternateLocationResult = await mApiInterface.getAlternateLocations(token, partScanningInbound);
      return alternateLocationResult;

    } on Response catch (e) {

        var val = await FetchDataException(mCustomSharedPrefs, mApiInterface, e)
            .exceptionHandling();
        return val == FetchDataException.SUCCESS ? getAlternateLocation(partScanningInbound) : val;

    }
  }

  Future<String> getVpartPickingLabel(String siteMasterId,
      String warehouseInboundId, String noOfLabel, String partsInOrderId) async {
    PDFDownload pdfDownload = PDFDownload();
    try {
      var url = mApiInterface.mBase.get.getUrl +
          'api/visibility/api/generateVpartPickingLabel/siteId/${siteMasterId}/wareHouseInboundId/${warehouseInboundId}/labels/${noOfLabel}/partsInOrderId/${partsInOrderId}';
      var file = await pdfDownload.getPDFFile(url);
      return file.path;
    } on Response catch (e) {
      var val = await FetchDataException(mCustomSharedPrefs, mApiInterface, e)
          .exceptionHandling();
      return val == FetchDataException.SUCCESS ? getVpartPickingLabel(siteMasterId,
           warehouseInboundId,noOfLabel,partsInOrderId) : val;
    }
    /*try {
      var api = await apiModule.getBaseApiPdf();
      ByteData data = await api.getVpartPickingLabel(
          siteMasterId, warehouseInboundId, binLabel, partsInOrderId);
      data.offsetInBytes;
      //  generateVpartPickingLabel/siteId/SIT-7/wareHouseInboundId/WHIB9005/labels/1/partsInOrderId/PINO9006
      File file = File(directory.path + '/');
      file.writeAsBytes(data.buffer.asUint8List());
      return file.path;
    } on resty.Response catch (e) {
      print(e.statusCode);
      return null;
    }*/
  }

  Future<int> onRandomPickRequest(PartScanningInbound partScanningInbound) async {
    String token = await mCustomSharedPrefs?.getToken();
    try {
      int data = await mApiInterface.randomPickRequest(token, partScanningInbound);
      return data;

    } on Response catch (e) {
        var val = await FetchDataException(mCustomSharedPrefs, mApiInterface, e)
            .exceptionHandling();
        return val == FetchDataException.SUCCESS ? onRandomPickRequest(partScanningInbound) : val;

    }
  }
}
