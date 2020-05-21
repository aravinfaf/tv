import 'package:tvs_visibility/src/visibility/dataprovider/sharedprefs.dart';
import 'package:tvs_visibility/src/visibility/model/bininfodetailsmodel/bininfodetailsmodel.dart';
import 'package:tvs_visibility/src/visibility/model/binmodel/binningScanHQ.dart';
import 'package:tvs_visibility/src/visibility/model/binmodel/binsavepart.dart';
import 'package:tvs_visibility/src/visibility/model/binmodel/binvalidationresult.dart';
import 'package:tvs_visibility/src/visibility/model/binninglistmodel/binninglistmodel.dart';
import 'package:tvs_visibility/src/visibility/model/checkpodbybusinesskeymodel/checkpodbybusinesskeymodel.dart';
import 'package:tvs_visibility/src/visibility/model/postbinningfiltermodel/postbinningfiltermodel.dart';
import 'package:tvs_visibility/src/visibility/model/vpartspostresponsemodel/vpartspostresponsemodel.dart';
import 'package:tvs_visibility/src/visibility/networkprovider/binnetworkprovider.dart';

class BinRepository {
  BinNetProvider mNetProvider;
  CustomSharedPrefs mCustomSharedPrefs;

  BinRepository(this.mNetProvider,this.mCustomSharedPrefs);

  Future<List<BinningListModel>> getBinList(PostBinningFilterModel model) async => await mNetProvider.onBinLists(model);

  Future <BinValidationResult> validateBinNumber(BinSavePart model) async => await mNetProvider.getBinNumberValidationResult(model);

  Future<String>  getSiteID() async=>await mCustomSharedPrefs.getSiteID();

  Future<VPartsPostResponseModel> getValidatedVPartsQuantity(BinSavePart model) async => await mNetProvider.onValidateVPartsQuantity(model);


  Future <BinningScanHQ> getBinningScanHQ(BinningScanHQ model) async => await mNetProvider.onBinningScanHQ(model);


  Future<String> generateHusquvarnaVPartsLabel(String orderMasterId,
      String partsInOrderId, int labelCount, String partsMasterId)  async => await mNetProvider.generateHusquvarnaVPartsLabel(
      orderMasterId, partsInOrderId, labelCount, partsMasterId);

  Future<List<CheckPODByBusinessKeyModel>> checkPODByBusinessKey(String orderId) async=>await mNetProvider.onCheckPODStatusByBusinessKey(orderId);

  Future<List<BinInfoDetailsModel>> getBinInfoDetailsModel(String partsInOrderId)async=>await mNetProvider.getBinInfoDetailsModel(partsInOrderId);

}
