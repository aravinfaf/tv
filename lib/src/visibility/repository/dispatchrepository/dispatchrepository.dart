import 'package:tvs_visibility/src/visibility/dataprovider/sharedprefs.dart';
import 'package:tvs_visibility/src/visibility/model/despatchlistmodel/activetaskresponsemodel.dart';
import 'package:tvs_visibility/src/visibility/model/despatchlistmodel/despatchdetailstatusmodel.dart';
import 'package:tvs_visibility/src/visibility/model/despatchlistmodel/dispatchdetailsmodel.dart';
import 'package:tvs_visibility/src/visibility/model/despatchlistmodel/scandespatchmodel.dart';
import 'package:tvs_visibility/src/visibility/model/getdispatchdetailsmodel/getdispatchdetailsmodel.dart';
import 'package:tvs_visibility/src/visibility/model/getmodeoftransportmodel/getmodeoftransportmodel.dart';
import 'package:tvs_visibility/src/visibility/networkprovider/dispatchprovider/dispatchprovider.dart';

class DispatchRepository {
  DispatchProvider dispatchProvider;
  CustomSharedPrefs customSharedPrefs;

  DispatchRepository(this.dispatchProvider);

  Future<List<DispatchListDTO>> getDispatchList(
          DispatchDetailsDto model) async =>
      await dispatchProvider.onDispatchList(model);

  Future<List<ActiveTaskConsolidationModel>> getActiveTaskList(
          String consolidationId) async =>
      await dispatchProvider.onActiveList(consolidationId);

  Future<DespatchDetailStatus> getDespatchStatus(
          String consolidationId) async =>
      await dispatchProvider.getDespatchDetailStatus(consolidationId);

  Future<GetDispatchDetailsModel> getDispatchDetails(
          String deliveryType,
          String consolidationId,
          String actorType,
          String orderMasterId) async =>
      await dispatchProvider.getDispatchDetails(
          deliveryType, consolidationId, actorType, orderMasterId);

  Future<List<GetModeOfTransportModel>> getModeOfTransport() async =>
      await dispatchProvider.onModeOfTransportDetails();

  Future<DespatchDetailStatus> scanDespatch(ScanDespatchModel model) async =>
      await dispatchProvider.scanDespatch(model);

  Future<String> generatePackingSlip(String userId, String vNo,
      String cId,String modId) async =>
      await dispatchProvider.generatePackingSlip(userId, vNo, cId,modId);

}
