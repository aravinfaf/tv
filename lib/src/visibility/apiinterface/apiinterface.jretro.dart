// GENERATED CODE - DO NOT MODIFY BY HAND

part of jaguar_http.example;

// **************************************************************************
// JaguarHttpGenerator
// **************************************************************************

abstract class _$ApiInterfaceClient implements ApiClient {
  final String basePath = "";
  Future<LoginResponseModel> getLoginResult(LoginRequestModel model) async {
    var req = base.post
        .path(basePath)
        .path("token/authenticate")
        .json(jsonConverter.to(model));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<AuthorizationResponseModel> getAuhorizationResponse(
      String token, int appId, AuthorizationRequestModel model) async {
    var req = base.post
        .path(basePath)
        .path("api/woc/api/authorizeSprintRequest/appId/:appId")
        .pathParams("appId", appId)
        .header("authorization", token)
        .json(jsonConverter.to(model));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<List<NotificationDataModel>> getUnreadNotificationsForUser(
      String userId) async {
    var req = base.get
        .path(basePath)
        .path(
            "https://tvsscstulip.com:8010/api/getUnreadNotificationsForUser/userId/:userId")
        .pathParams("userId", userId);
    return req.go(throwOnErr: true).map(decodeList);
  }

  Future<PostFilterModel> getPodLists(
      String token, PostFilterModel model) async {
    var req = base.post
        .path(basePath)
        .path("api/visibility/api/podAssignedUserWithVehicleDetails")
        .header("Authorization", token)
        .json(jsonConverter.to(model));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<CustomPickList> getpickingList(
      String token, CustomPickList model) async {
    var req = base.post
        .path(basePath)
        .path("api/visibility/api/generatePicklistgeneric")
        .header("Authorization", token)
        .json(jsonConverter.to(model));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<PostFilterModel> getGateLists(
      String token, PostFilterModel model) async {
    var req = base.post
        .path(basePath)
        .path("api/visibility/api/vehiclesearchGateOut")
        .header("Authorization", token)
        .json(jsonConverter.to(model));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<bool> onGateOut(String token, CreateGateOutModel model) async {
    var req = base.post
        .path(basePath)
        .path("api/visibility/api/changedStatusGateOutFluter")
        .header("Authorization", token)
        .json(jsonConverter.to(model));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<int> ongatein(String token, CreateGateInModel model) async {
    var req = base.post
        .path(basePath)
        .path("api/visibility/api/integrationWithTVS")
        .header("Authorization", token)
        .json(jsonConverter.to(model));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<DispatchDetailsDto> generateDispatchDetails(
      String token, DispatchDetailsDto model) async {
    var req = base.post
        .path(basePath)
        .path("api/visibility/api/dispatch/getDispatchDetails")
        .header("Authorization", token)
        .json(jsonConverter.to(model));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<DespatchDetailStatus> scanDespatch(
      String token, ScanDespatchModel model) async {
    var req = base.post
        .path(basePath)
        .path("api/visibility/api/scanDespatch")
        .header("Authorization", token)
        .json(jsonConverter.to(model));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<DespatchDetailStatus> getDespatchDetailStatus(
      String token, String id) async {
    var req = base.get
        .path(basePath)
        .path(
            "api/visibility/api/getDespatchDetails/consilidationId/:consilidationId")
        .pathParams("consilidationId", id)
        .header("Authorization", token);
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<DispatchListDTO> getDispatchForConsolidation(
      String token, String id) async {
    var req = base.get
        .path(basePath)
        .path(
            "api/visibility/api/getDispatchForConsolidation/consolidationId/:consolidationId")
        .pathParams("consolidationId", id)
        .header("Authorization", token);
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<List<ActiveTaskConsolidationModel>> getActiveConsolidationDetails(
      String token, String id) async {
    var req = base.get
        .path(basePath)
        .path(
            "api/visibility/api/getActiveTaskByConsolidationId/businessKey/:businessKey")
        .pathParams("businessKey", id)
        .header("Authorization", token);
    return req.go(throwOnErr: true).map(decodeList);
  }

  Future<List<CheckPodKeyModel>> getCheckPodKeyStatus(
      String token, String id) async {
    var req = base.get
        .path(basePath)
        .path(
            "api/visibility/api/getActiveTaskByVehicleInOutId/businessKey/:businessKey")
        .pathParams("businessKey", id)
        .header("Authorization", token);
    return req.go(throwOnErr: true).map(decodeList);
  }

  Future<PostBinningFilterModel> getBinLists(
      String token, PostBinningFilterModel model) async {
    var req = base.post
        .path(basePath)
        .path("api/visibility/api/assignedBinnerDetails")
        .header("Authorization", token)
        .json(jsonConverter.to(model));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<BinValidationResult> getBinValidationDetails(
      String token, BinSavePart model) async {
    var req = base.post
        .path(basePath)
        .path("api/visibility/api/scanningValidationForBin")
        .header("Authorization", token)
        .json(jsonConverter.to(model));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<VPartsPostResponseModel> getVPartsQty(
      String token, BinSavePart model) async {
    var req = base.post
        .path(basePath)
        .path("api/visibility/api/VpartsScanPost")
        .header("Authorization", token)
        .json(jsonConverter.to(model));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<BinningScanHQ> getbinningScanHQ(
      String token, BinningScanHQ model) async {
    var req = base.post
        .path(basePath)
        .path("api/visibility/api/binningScanHQ")
        .header("Authorization", token)
        .json(jsonConverter.to(model));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<int> shortPickQty(String token, ExcessMaster model) async {
    var req = base.post
        .path(basePath)
        .path("api/visibility/api/shortPickQtyPost")
        .header("Authorization", token)
        .json(jsonConverter.to(model));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<StringResponse> getGeneratedPOD(
      String token, PostPodDetailsModel model) async {
    var req = base.post
        .path(basePath)
        .path("api/visibility/api/savePOD")
        .header("Authorization", token)
        .json(jsonConverter.to(model));
    return req.go(throwOnErr: true);
  }

  Future<StringResponse> generateVpartPickingLabel(
      String token, OutboundLabel model) async {
    var req = base.post
        .path(basePath)
        .path("api/generateVpartPickingLabel")
        .header("Authorization", token)
        .json(jsonConverter.to(model));
    return req.go(throwOnErr: true);
  }

  Future<AlternateLocationResult> getAlternateLocations(
      String token, PartScanningInbound partScanningInbound) async {
    var req = base.post
        .path(basePath)
        .path("api/visibility/api/getAlternateLocations")
        .header("Authorization", token)
        .json(jsonConverter.to(partScanningInbound));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<PickScanningResult> partScanningInbound(
      String token, PartScanningInbound partScanningInbound) async {
    var req = base.post
        .path(basePath)
        .path("api/visibility/api/partScanningInbound")
        .header("Authorization", token)
        .json(jsonConverter.to(partScanningInbound));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<String> partPicking(
      String token,
      String serialNumber,
      String partNumber,
      int pickedQty,
      String orderId,
      String warehouseInboundId) async {
    var req = base.get
        .path(basePath)
        .path(
            "api/partPicking/serialNumber/:serialNumber/partNumber/:partNumber/pickedQty/:pickedQty/orderId/:orderId/warehouseInboundId/:warehouseInboundId")
        .pathParams("serialNumber", serialNumber)
        .pathParams("partNumber", partNumber)
        .pathParams("pickedQty", pickedQty)
        .pathParams("orderId", orderId)
        .pathParams("warehouseInboundId", warehouseInboundId)
        .header("Authorization", token);
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<int> randomPickRequest(
      String token, PartScanningInbound partScanningInbound) async {
    var req = base.post
        .path(basePath)
        .path("api/visibility/api/randomPickRequest")
        .header("Authorization", token)
        .json(jsonConverter.to(partScanningInbound));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<PickScanningResult> partScanningOutbound(
      String token, PartScanningInbound partScanningInbound) async {
    var req = base.post
        .path(basePath)
        .path("api/visibility/api/partScanningOutbound")
        .header("Authorization", token)
        .json(jsonConverter.to(partScanningInbound));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<ByteData> getVpartPickingLabel(String siteMasterId,
      String warehouseInboundId, String binLabel, String partsInOrderId) async {
    var req = base.get
        .path(basePath)
        .path(
            "api/generateVpartPickingLabel/siteId/:siteId/wareHouseInboundId/:wareHouseInboundId/labels/:labels/partsInOrderId/:partsInOrderId")
        .pathParams("siteId", siteMasterId)
        .pathParams("wareHouseInboundId", warehouseInboundId)
        .pathParams("labels", binLabel)
        .pathParams("partsInOrderId", partsInOrderId);
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<ByteData> generateHusquvarnaVPartsLabel(String orderMasterId,
      String partsInOrderId, int labelCount, String partsMasterId) async {
    var req = base.get
        .path(basePath)
        .path(
            "api/generateHusquvarnaVPartsLabel/orderMasterId/:orderMasterId/partsInOrderId/:partsInOrderId/labelCount/:labelCount/partsMasterId/:partsMasterId")
        .pathParams("orderMasterId", orderMasterId)
        .pathParams("partsInOrderId", partsInOrderId)
        .pathParams("labelCount", labelCount)
        .pathParams("partsMasterId", partsMasterId);
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<List<CheckPODByBusinessKeyModel>> checkPODStatusByBusinessKey(
      String token, String orderMasterId) async {
    var req = base.get
        .path(basePath)
        .path(
            "api/visibility/api/checkPODByBusinessKey/businessKey/:businessKey")
        .pathParams("businessKey", orderMasterId)
        .header("Authorization", token);
    return req.go(throwOnErr: true).map(decodeList);
  }

  Future<List<BinInfoDetailsModel>> getBinInfoDetails(
      String token, String partsInorderId) async {
    var req = base.get
        .path(basePath)
        .path("api/visibility/api/binmaster/info/:partsInorderId")
        .pathParams("partsInorderId", partsInorderId)
        .header("Authorization", token);
    return req.go(throwOnErr: true).map(decodeList);
  }

  Future<AuthorizeSprintDetailsModel> authorizeSprintDetails(
      String token, String appId, AuthorizeSprintRequestModel model) async {
    var req = base.post
        .path(basePath)
        .path("api/woc/api/authorizeSprintRequest/appId/:appId")
        .pathParams("appId", appId)
        .header("Authorization", token)
        .json(jsonConverter.to(model));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<List<OrderMasterModel>> getOrderMasterDetails(
      String token, PostFilterDetailsModel model) async {
    var req = base.post
        .path(basePath)
        .path("api/visibility/api/getHusMobileOrders")
        .header("Authorization", token)
        .json(jsonConverter.to(model));
    return req.go(throwOnErr: true).map(decodeList);
  }

  Future<PartOrBinValidationModel> validatePartOrBin(
      String token, PartOrBinValidationModel model) async {
    var req = base.post
        .path(basePath)
        .path("api/visibility/api/husValidatePartOrBin")
        .header("Authorization", token)
        .json(jsonConverter.to(model));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<BinScanningResponse> validatePartOrBin1(
      String token, BinScanningRequest model) async {
    var req = base.post
        .path(basePath)
        .path("api/visibility/api/husValidatePartOrBin")
        .header("Authorization", token)
        .json(jsonConverter.to(model));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<BinScanningResponse> vPartBinning(
      String token, BinScanningRequest model) async {
    var req = base.post
        .path(basePath)
        .path("api/visibility/api/husPartBinning")
        .header("Authorization", token)
        .json(jsonConverter.to(model));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<PostBinDetailsModel> partBinning(
      String token, PostBinDetailsModel model) async {
    var req = base.post
        .path(basePath)
        .path("api/visibility/api/husPartBinning")
        .header("Authorization", token)
        .json(jsonConverter.to(model));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<List<BinLocationModel>> searchBinLocation(
      String token, String binLocation, String siteId) async {
    var req = base.get
        .path(basePath)
        .path(
            "api/visibility/api/husBinSearch/binlocation/:binlocation/siteId/:siteId")
        .pathParams("binlocation", binLocation)
        .pathParams("siteId", siteId)
        .header("Authorization", token);
    return req.go(throwOnErr: true).map(decodeList);
  }

  Future<GetDispatchDetailsModel> getDispatchDropdownList(
      String token,
      String deliveryType,
      String siteMasterId,
      String cosolidationId,
      String actorType,
      String orderMasterId) async {
    var req = base.get
        .path(basePath)
        .path(
            "api/visibility/api/despatchDropdownList/deliveryType/:deliveryType/SiteMasterId/:siteMasterId/cosolidationId/:cosolidationId/actorType/:actorType/orderMasterId/:orderMasterId")
        .pathParams("deliveryType", deliveryType)
        .pathParams("siteMasterId", siteMasterId)
        .pathParams("cosolidationId", cosolidationId)
        .pathParams("actorType", actorType)
        .pathParams("orderMasterId", orderMasterId)
        .header("Authorization", token);
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<List<GetModeOfTransportModel>> getModeOfTransportDetails(
      String token) async {
    var req = base.get
        .path(basePath)
        .path("api/visibility/api/getModeOfTransport")
        .header("Authorization", token);
    return req.go(throwOnErr: true).map(decodeList);
  }

  Future<List<PostDispatchMasterDetailsModel>> postDispatchMaster(
      String token, List<PostDispatchMasterDetailsModel> model) async {
    var req = base.post
        .path(basePath)
        .path("api/visibility/api/husPartScanningInbound")
        .header("Authorization", token)
        .json(jsonConverter.to(model));
    return req.go(throwOnErr: true).map(decodeList);
  }

  Future<List<PartNumberDetailsModel>> getPartNumberSearchDetails(
      String token, String partNumber, int pageNumber, int pageSize) async {
    var req = base.get
        .path(basePath)
        .path(
            "api/visibility/api/partnumberSearch/pageNumber/:pageNumber/pageSize/:pageSize")
        .pathParams("pageNumber", pageNumber)
        .pathParams("pageSize", pageSize)
        .query("partnumber", partNumber)
        .header("Authorization", token);
    return req.go(throwOnErr: true).map(decodeList);
  }

  Future<List<PostPartMasterDetailsModel>> getPartAvailableBin(
      String token, List<PostPartMasterDetailsModel> model) async {
    var req = base.post
        .path(basePath)
        .path("api/visibility/api/getPartAvailableBin")
        .header("Authorization", token)
        .json(jsonConverter.to(model));
    return req.go(throwOnErr: true).map(decodeList);
  }

  Future<PartSerialNumberDetailsModel> validatePartSerialNumberDetails(
      String token, PartSerialNumberDetailsModel model) async {
    var req = base.post
        .path(basePath)
        .path("api/visibility/api/scanAvailableQtyInBin")
        .header("Authorization", token)
        .json(jsonConverter.to(model));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<BinMasterDetailsModel> singleBinToBinTransfer(
      String token, BinMasterDetailsRequestModel model) async {
    var req = base.post
        .path(basePath)
        .path("api/visibility/api/husSingleBinToBin")
        .header("Authorization", token)
        .json(jsonConverter.to(model));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<int> singleBintoBinVisibility(String token, String destinationScanBin,
      String serialNumber, String siteMasterId) async {
    var req = base.get
        .path(basePath)
        .path(
            "api/visibility/api/singleBinToBinTransfer/destinationScanBin/:destinationScanBin/serialNumber/:serialNumber/siteMasterId/:siteMasterId")
        .pathParams("destinationScanBin", destinationScanBin)
        .pathParams("serialNumber", serialNumber)
        .pathParams("siteMasterId", siteMasterId)
        .header("Authorization", token);
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<PreBinningResponseModel> getPreBinningList(
      String token, PreBinningRequestModel preBinningRequestModel) async {
    var req = base.post
        .path(basePath)
        .path("api/visibility/api/preBinningApis")
        .header("Authorization", token)
        .json(jsonConverter.to(preBinningRequestModel));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<int> postPreBinningScan(
      String token, PreBinningScanRequestModel model) async {
    var req = base.post
        .path(basePath)
        .path("api/visibility/api/preBinningSerialNumber")
        .header("Authorization", token)
        .json(jsonConverter.to(model));
    return req.go(throwOnErr: true).map(decodeOne);
  }
}
