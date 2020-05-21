import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:tvs_visibility/src/visibility/constants/businessconstants.dart';
import 'package:tvs_visibility/src/visibility/dataprovider/sharedprefs.dart';
import 'package:tvs_visibility/src/visibility/model/despatchlistmodel/despatchdetailstatusmodel.dart';
import 'package:tvs_visibility/src/visibility/model/despatchlistmodel/dispatchdetailsmodel.dart';
import 'package:tvs_visibility/src/visibility/model/despatchlistmodel/scandespatchmodel.dart';
import 'package:tvs_visibility/src/visibility/model/endcustomerdetailmodel/endcustomerdetailmodel.dart';
import 'package:tvs_visibility/src/visibility/model/getdispatchdetailsmodel/getdispatchdetailsmodel.dart';
import 'package:tvs_visibility/src/visibility/model/getmodeoftransportmodel/getmodeoftransportmodel.dart';
import 'package:tvs_visibility/src/visibility/repository/dispatchrepository/dispatchrepository.dart';
import 'package:tvs_visibility/src/visibility/ui/despatch/dispatchdetailviewcontract.dart';

class DispatchViewBloc implements DispatchDetailViewBlocContract{
  CustomSharedPrefs mSharedPrefs;
  DispatchRepository dispatchRepository;
  var mProgressBar = BehaviorSubject<bool>();
  DispatchDetailViewContract mView;
  List<EndCustomerDetailModel> mEndCustomerDetails = [];
  List<GetModeOfTransportModel> mModeOfTransport = [];
  DispatchViewBloc(this.dispatchRepository, this.mSharedPrefs);

  dispose() {
    mProgressBar.close();
  }

  Observable<bool> get isLoad => mProgressBar.stream.transform(validateLoading);

  final validateLoading =
  StreamTransformer<bool, bool>.fromHandlers(handleData: (isLoad, sink) {
    if (isLoad != null) {
      sink.add(isLoad);
    } else {
      sink.addError('Something went wrong!');
    }
  });

  Function(bool) get showProgress => mProgressBar.sink.add;

  Observable<bool> get isLoading =>
      mProgressBar.stream.transform(validateLoading);

  @override
  Future<DespatchDetailStatus> getDespatchStatus(String consolidationId) async {
    DespatchDetailStatus dispatchListDTO = DespatchDetailStatus();
    dispatchListDTO = await dispatchRepository.getDespatchStatus(consolidationId);
    return dispatchListDTO;
  }

  @override
   getDispatchDetails(String deliveryType, String consolidationId, String actorType, String orderMasterId) async {
    GetDispatchDetailsModel dispatchDetails = GetDispatchDetailsModel();

    dispatchDetails = await dispatchRepository.getDispatchDetails(
        deliveryType, consolidationId, actorType, orderMasterId);
    if(dispatchDetails.mEndCustomerList!=null)
      mEndCustomerDetails.addAll(dispatchDetails.mEndCustomerList);
    if(dispatchDetails.mEngineerMasterDTOList!=null)
      mEndCustomerDetails.addAll(dispatchDetails.mEngineerMasterDTOList);
    if(dispatchDetails.mSiteMasterDetailsModel!=null)
      mEndCustomerDetails.addAll(dispatchDetails.mSiteMasterDetailsModel);
  }

  @override
  getModeOfTransport() async {
    mModeOfTransport = await dispatchRepository.getModeOfTransport();
  }

  @override
   scanDespatch(DispatchListDTO model, String tecModeOfTransport, String courierOrVehicleNumber, String scanNumber,String modeOfTransportId) async {
    showProgress(true);
    DespatchDetailStatus despatchDetailStatus = DespatchDetailStatus();
    String userId = await mSharedPrefs.getUserId();

    despatchDetailStatus = await dispatchRepository.scanDespatch(
        new ScanDespatchModel(
          mUserId: userId,
          mActorType: model.mActorId,
          mAddress: model.mDeliveryTypeId == "DITM8" ? model.mAddress : null,
          mCompany: model.mDeliveryTypeId == "DITM8" ? model.mCompany : null,
          mConsolidationId: model.mConsolidationId,
          mConsolidationTypeId: model.mConsolidationType,
          mDeliveryTo: model.mActorId == "AM001" ? model.mDestinationId : model.mDestination,
          mDeliveryTypesMasterId: model.mDeliveryTypeId,
          mId: model.mDispatchId,
          mMappingId: model.mDispatchMappingId,
          mModeOfTransport: modeOfTransportId,
          mOrderId: model.mOrderMasterId,
          mOrderIdList: model.mOrderMasterIdList,
          mScanNumber: scanNumber,
            mVehicleNum: modeOfTransportId == "ABCM16001"
                ? courierOrVehicleNumber
                : null,
            mCourierName: modeOfTransportId == "ABCM16002"
                ? courierOrVehicleNumber
                : null
        )
    );

    if(despatchDetailStatus.mStatusCode==1){
      mView.setDispatchDetails(despatchDetailStatus);
      mView.setAlreadyScannedDispatchDetails(true);
      mView.setValidationMessage(BusinessConstants.DISPATCH_SCAN_SUCCESS, true);
    }else if(despatchDetailStatus.mStatusCode==2){
      mView.setValidationMessage(
          BusinessConstants.DISPATCH_ALREADY_SCANNED, false);
    }else if(despatchDetailStatus.mStatusCode==3){
      mView.setValidationMessage(
          BusinessConstants.DISPATCH_SCAN_MISMATCH, false);
    }else if(despatchDetailStatus.mStatusCode==4){
      mView.setValidationMessage(BusinessConstants.DISPATCH_COMPLETED, true);
      mView.setAlreadyScannedDispatchDetails(true);
      mView.finishDispatch(courierOrVehicleNumber, model.mConsolidationId);
    }else if(despatchDetailStatus.mStatusCode==5){
      mView.setValidationMessage(
          BusinessConstants.DISPATCH_SCAN_CANNOT_BE_SWAPPED, false);
    }else{
      mView.setValidationMessage(BusinessConstants.DISPATCH_SCAN_SUCCESS, true);
      mView.setAlreadyScannedDispatchDetails(true);
    }
    mView.getTecCartonOrLPN().clear();
    showProgress(false);
  }

  @override
  Future<String> generatePackingSlip(String vNo, String cId,String modId) async {
    showProgress(true);
    String userId = await mSharedPrefs.getUserId();
    var savePackingResponse = await dispatchRepository.generatePackingSlip(
        userId, vNo, cId,modId);
    if (savePackingResponse == null || savePackingResponse == "ERROR") {
      showProgress(false);
      mView.setValidationMessage(
          BusinessConstants.DISPATCH_AT_LEAST_ONE, false);
      //      mProgressBar.addError(ValidationConstants.STR_SOMETHING_WENT_WRONG);
    }
    else
      showProgress(false);
    return savePackingResponse;
  }
}