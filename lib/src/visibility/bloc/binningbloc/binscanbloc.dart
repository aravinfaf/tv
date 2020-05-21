import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:tvs_visibility/src/visibility/constants/StringConstants.dart';
import 'package:tvs_visibility/src/visibility/constants/businessconstants.dart';
import 'package:tvs_visibility/src/visibility/dataprovider/sharedprefs.dart';
import 'package:tvs_visibility/src/visibility/model/binmodel/binningScanHQ.dart';
import 'package:tvs_visibility/src/visibility/model/binmodel/binsavepart.dart';
import 'package:tvs_visibility/src/visibility/model/binmodel/binvalidationresult.dart';
import 'package:tvs_visibility/src/visibility/model/vpartspostresponsemodel/vpartspostresponsemodel.dart';
import 'package:tvs_visibility/src/visibility/repository/binrepository.dart';
import 'package:tvs_visibility/src/visibility/ui/binning/binningscancontract.dart';
import 'package:tvs_visibility/src/visibility/utililty/utils.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customview/customtoast.dart';

class BinScanBloc implements BinScanBlocContract{
  BinRepository binRepository;
  var mProgressBar=BehaviorSubject<bool>();
  CustomSharedPrefs mCustomSharedPrefs;
  var checkBox = new BehaviorSubject<bool>();
  BinValidationResult mBinValidationModel = new BinValidationResult();
  BinScanViewContract mView;

  dispose(){
    mProgressBar.close();
    mView.getTecBinOrLPN.clear();
    mView.getTecNoOfLabel.clear();
    mView.getTecVPartQuantity.clear();
    checkBox.close();
  }

  BinScanBloc(this.binRepository,this.mCustomSharedPrefs);

  Function(bool) get showProgress => mProgressBar.sink.add;

  Observable<bool> get isLoad => mProgressBar.stream;

  void streamCalc(bool b) {
    checkBox.sink.add(b);
  }

  Observable<bool> get checkStream=>checkBox.stream;

  Future<BinValidationResult> validateBinNumber(BinSavePart model) async {
    showProgress(true);
    BinValidationResult binResponse = new BinValidationResult();
    binResponse = await binRepository.validateBinNumber(model);
    return binResponse;
  }

  Future<VPartsPostResponseModel> validateVPartsQuantity(BinSavePart model) async {
    showProgress(true);
    VPartsPostResponseModel binResponse;
    binResponse= await binRepository.getValidatedVPartsQuantity(model);
    showProgress(false);
    return binResponse;
  }

  Future<String> getSitID() async {
    return await mCustomSharedPrefs.getSiteID();
  }


  Future <BinningScanHQ> getBinningScanHQ(BinningScanHQ model) async{
    showProgress(true);
    BinningScanHQ binningScanHQ = new BinningScanHQ();
    binningScanHQ = await binRepository.getBinningScanHQ(model);
    showProgress(false);
    return binningScanHQ;
  }

  Future<String> generateHusquvarnaVPartsLabel(String orderMasterId, String partsInOrderId, int labelCount, String partsMasterId) async {
    showProgress(true);
    var str = await binRepository.generateHusquvarnaVPartsLabel(orderMasterId, partsInOrderId, labelCount, partsMasterId);
    showProgress(false);
    return str;
  }

  onProcessBinOrPart() async {
    if (await Utils.onCheckNetworkConnection()) {
      mView.setRetry=onProcessBinOrPart;

      mView.setScannedBinOrPart=mView.getTecBinOrLPN.text;
      String siteId = await getSitID();

      mBinValidationModel = await validateBinNumber(BinSavePart(
          mBinMasterId: mView.getBinId,
          mAccountsMasterId: mBinValidationModel?.mPartsMasterDTO?.mAccountMasterId,
          mFirstScan: (mBinValidationModel.mTotalQuantity == ((mBinValidationModel.mTotalQuantity??0)-(mBinValidationModel.mBinnedQuantity??0))),
          mOrdersMasterId: mBinValidationModel.mOrderId,
          mPartsInOrderId: mBinValidationModel.mPartsInorderId,
          mPartsMasterId: mBinValidationModel.mPartId,
          mVPartQuantity: '0',
          mScanNumber: mView.getScannedBinOrPart,
          mTaskInstanceId: null,
          mBinTypeId: mView.getBinTypeId,
          mSiteMasterId: siteId
      ));

      mView.setBinValidationResult=mBinValidationModel;

      mView.setWarehouseInboundId = (mBinValidationModel.mWareHouseMatId) != null
          ? mBinValidationModel.mWareHouseMatId
          : '';

      mView.setVPartsQtyExist = (mBinValidationModel.mVPartsExistQty) != null
          ? '${mBinValidationModel.mVPartsExistQty}'
          : '';
      checkScanningValidationResult(mBinValidationModel);
      showProgress(false);
    }
    else {
      CustomToast.showToast(StringConstants.NO_INTERNET_CONNECTION);
    }
  }

  checkScanningValidationResult(BinValidationResult validationResult) {
    if (!mView.getBinScanned && validationResult.mStatusCode == BusinessConstants.BINNING_PLEASE_SCAN_BIN_FIRST) {
      mView.setValidationContent(BusinessConstants.STR_BINNING_PLEASE_SCAN_BIN_FIRST,true);
      mView.getTecBinOrLPN.clear();
    }else if (validationResult.mStatusCode == BusinessConstants.BINNING_PLEASE_SCAN_CORRECT_PART_WITH_CORRECT_BIN) {
      mView.setValidationContent(BusinessConstants.STR_BINNING_PLEASE_SCAN_CORRECT_PART_WITH_CORRECT_BIN,true);
      mView.setTecBinOrLPN="";
      mView.setScannedBinOrPart="";
    }else if (validationResult.mStatusCode == BusinessConstants.BINNING_PART_ALREADY_SCANNED) {
      mView.setValidationContent("LPN ${validationResult.mSerialNumber} has already been scanned into bin ${validationResult.mBinsMasterDTO.mBinLocation}",true);
      mView.getTecBinOrLPN.clear();
      mView.setScannedBinOrPart="";
      mView.getTecVPartQuantity.clear();
    }else if (validationResult.mStatusCode == BusinessConstants.BINNING_PLEASE_SCAN_CORRECT_SERIAL_NUMBER) {
      mView.setValidationContent(BusinessConstants.STR_BINNING_PLEASE_SCAN_CORRECT_SERIAL_NUMBER,true);
    }else if (validationResult.mStatusCode == BusinessConstants.BINNING_PLEASE_SCAN_CORRECT_BIN_RESPECTIVE_TO_ACCOUNT) {
      mView.setValidationContent(BusinessConstants.STR_BINNING_PLEASE_SCAN_CORRECT_BIN_RESPECTIVE_TO_ACCOUNT,true);
    }else if (validationResult.mStatusCode == BusinessConstants.BINNING_PLEASE_SCAN_DISCREPANCY_PARTS) {
      mView.setValidationContent(BusinessConstants.STR_BINNING_PLEASE_SCAN_DISCREPANCY_PARTS,true);
    }else if (validationResult.mStatusCode == BusinessConstants.BINNING_COUNT_MISMATCH_PLEASE_PROVIDE_ACTUAL_QUANTITY) {
      mView.setEnableSubmit = false;
      mView.setVPartType = true;
      mView.setScannedBinAndPart = true;
      mView.setValidationContent(BusinessConstants.STR_BINNING_COUNT_MISMATCH_PLEASE_PROVIDE_ACTUAL_QUANTITY,true);
    }else if (validationResult.mStatusCode == BusinessConstants.BINNING_SUCCESSFULLY_SCANNED_BIN) {
      mView.setBinScanned = true;
      mView.setBinTypeId = validationResult.mBinTypeId;
      mView.setEnableSubmit = false;
      mView.setBinLabel=validationResult.mBinsMasterDTO.mBinLabel??"";
      mView.setBinId = validationResult.mBinsMasterDTO != null
          ? '${validationResult.mBinsMasterDTO.mId}'
          : '';
      mView.setTecBinOrLPN="";
      mView.setValidationContent("${BusinessConstants.STR_BINNING_SUCCESSFULLY_SCANNED_BIN} -  ${mView.getBinLabel}",false);
      mView.setSerialLabel = (Utils.isEmpty(mView.getBinId) ? "BIN NO." : "BIN/LPN.");
    }else if (validationResult.mStatusCode == BusinessConstants.BINNING_PLEASE_ENTER_THE_QUANTITY) {
      validationResult.mPartsMasterDTO.mPartTypesMasterIdName = BusinessConstants.STR_VARIABLE_PART;
      mView.setEnableSubmit = false;
      mView.setVPartType = true;
      mView.getTecVPartQuantity.clear();
      mView.setScannedBinAndPart = true;
      mView.setPartLPN=validationResult.mSerialNumber;
      mView.setValidationContent("Enter the quantity to be binned against the LPN ${mView.getPartLPN}",false);
    }else if (validationResult.mStatusCode == BusinessConstants.BINNING_SUCCESSFULLY_SCANNED_PART) {
      mView.setPartLPN=validationResult.mSerialNumber;
      mView.getTecBinOrLPN.clear();
      mView.setValidationContent("Successfully scanned LPN ${mView.getPartLPN} into bin ${mView.getBinLabel}",false);
      mView.setTecVPartQuantity="";
    }else if(validationResult.mStatusCode == BusinessConstants.BINNING_WARE_HOUSE_MANAGER_APPROVAL_PENDING){
      mView.setValidationContent("${BusinessConstants.STR_BINNING_WARE_HOUSE_MANAGER_APPROVAL_PENDING}",true);
      mView.getTecBinOrLPN.text="";
    } else if(validationResult.mStatusCode == BusinessConstants.BINNING_ALL_PARTS_ARE_BINNED_SUCCESSFULLY) {
      mView.getTecBinOrLPN.text="";
      mView.setValidationContent(BusinessConstants.STR_ALL_PARTS_ARE_BINNED_SUCCESSFULLY,false);
    }else if(validationResult.mStatusCode == BusinessConstants.BINNING_EXCESS_QUANTITY_ENTERED_FOR_ORDER_WHILE_ENTERING){
      mView.setValidationContent(BusinessConstants.STR_BINNING_EXCESS_QUANTITY_ENTERED_FOR_ORDER_WHILE_ENTERING,true);
    }else if(validationResult.mStatusCode == BusinessConstants.BINNING_ORDER_NOT_ASSIGNED_TO_USER){
      mView.getTecBinOrLPN.clear();
      mView.setScannedBinOrPart="";
      mView.setValidationContent(BusinessConstants.STR_BINNING_ORDER_NOT_ASSIGNED_TO_USER,true);
    }else if(validationResult.mStatusCode == BusinessConstants.BINNING_DOCK_IN_PROCESS_NOT_FINISHED_POD_PENDING_FOR_APPROVAL){
      mView.getTecBinOrLPN.clear();
      mView.setScannedBinOrPart="";
      mView.setValidationContent(BusinessConstants.STR_BINNING_DOCK_IN_PROCESS_NOT_FINISHED_POD_PENDING_FOR_APPROVAL,true);
    }else if(validationResult.mStatusCode == BusinessConstants.BINNING_DOCK_IN_PROCESS_NOT_FINISHED_POD_INCOMPLETE){
      mView.getTecBinOrLPN.clear();
      mView.setScannedBinOrPart="";
      mView.setValidationContent(BusinessConstants.STR_BINNING_DOCK_IN_PROCESS_NOT_FINISHED_POD_INCOMPLETE,true);
    }else if(validationResult.mStatusCode == BusinessConstants.BINNING_POD_GENERATION_NOT_COMPLETED){
      mView.getTecBinOrLPN.clear();
      mView.setScannedBinOrPart="";
      mView.setValidationContent(BusinessConstants.STR_BINNING_POD_GENERATION_NOT_COMPLETED,true);
    }else if(validationResult.mStatusCode == BusinessConstants.BINNING_POD_PENDING_FOR_APPROVAL){
      mView.getTecBinOrLPN.clear();
      mView.setScannedBinOrPart="";
      mView.setValidationContent(BusinessConstants.STR_BINNING_POD_PENDING_FOR_APPROVAL,true);
    }else if(validationResult.mStatusCode == BusinessConstants.BINNING_DOCK_IN_PROCESS_NOT_FINISHED){
      mView.getTecBinOrLPN.clear();
      mView.setScannedBinOrPart="";
      mView.setValidationContent(BusinessConstants.STR_BINNING_DOCK_IN_PROCESS_NOT_FINISHED,true);
    }
  }

  checkScanningValidationResultDealer(BinningScanHQ binningScanHQ) {
    if (!mView.getBinScanned && binningScanHQ.mStatusCode == BusinessConstants.BINNING_DEALER_PLEASE_SCAN_THE_BIN_FIRST) {
      mView.setValidationContent(BusinessConstants.STR_BINNING_DEALER_PLEASE_SCAN_THE_BIN_FIRST,true);
      mView.clearAll();
    }else if (binningScanHQ.mStatusCode == BusinessConstants.BINNING_DEALER_PART_ALREADY_SCANNED) {
      mView.setValidationContent(BusinessConstants.STR_BINNING_DEALER_PART_ALREADY_SCANNED,true);
      mView.clearAll();
    }else if (binningScanHQ.mStatusCode == BusinessConstants.BINNING_DEALER_SUCCESSFULLY_SCANNED_BIN) {
      mView.setBinScanned = true;
      mView.setBinTypeMasterId = binningScanHQ.mBinsMasterDTO.mBinTypesMasterId;
      mView.setEnableSubmit = false;
      mView.setBinLabel=binningScanHQ.mBinsMasterDTO.mBinLabel??"";
      mView.setBinId = binningScanHQ.mBinsMasterDTO != null
          ? '${binningScanHQ.mBinsMasterDTO.mId}'
          : '';
      mView.setValidationContent("${BusinessConstants.STR_BINNING_DEALER_SUCCESSFULLY_SCANNED_BIN} -  ${binningScanHQ.mBinsMasterDTO.mBinLabel}",false);
      mView.setSerialLabel = ((mView.getBinId == null) ? "BIN NO." : "BIN/PART NO.");
      mView.clearAll();
    }else if (binningScanHQ.mStatusCode == BusinessConstants.BINNING_DEALER_PLEASE_ENTER_THE_QUANTITY) {
      mView.setEnableSubmit = false;
      mView.setVPartType = true;
      mView.setScannedBinAndPart = true;
      showProgress(false);
      mView.setValidationContent(BusinessConstants.STR_BINNING_DEALER_PLEASE_ENTER_THE_QUANTITY,true);
    }else if (binningScanHQ.mStatusCode == BusinessConstants.BINNING_DEALER_SUCCESSFULLY_SCANNED_PART) {
      mView.setEnableSubmit = false;
      mView.setValidationContent("${BusinessConstants.BINNING_DEALER_SUCCESSFULLY_SCANNED_PART} -" + mView.getScannedBinOrPart + ", please continue binning",false);
      mView.setVPartType = false;
      mView.setScannedBinAndPart = false;
      mView.clearAll();
      showProgress(false);
    }else if (binningScanHQ.mStatusCode == BusinessConstants.BINNING_DEALER_PLEASE_SCAN_CORRECT_PART_WITH_CORRECT_BIN) {
      mView.setValidationContent(BusinessConstants.STR_BINNING_DEALER_PLEASE_SCAN_CORRECT_PART_WITH_CORRECT_BIN,true);
      mView.clearAll();
    }else if (binningScanHQ.mStatusCode == BusinessConstants.BINNING_DEALER_PLEASE_SCAN_CORRECT_SERIAL_NUMBER) {
      mView.setValidationContent(BusinessConstants.STR_BINNING_DEALER_PLEASE_SCAN_CORRECT_SERIAL_NUMBER,true);
      mView.clearAll();
    }else if (binningScanHQ.mStatusCode == BusinessConstants.BINNING_DEALER_PLEASE_SCAN_CORRECT_BIN_RESPECTIVE_TO_ACCOUNT) {
      mView.setValidationContent(BusinessConstants.STR_BINNING_DEALER_PLEASE_SCAN_CORRECT_BIN_RESPECTIVE_TO_ACCOUNT,true);
      mView.clearAll();
    }else if (binningScanHQ.mStatusCode == BusinessConstants.BINNING_DEALER_PLEASE_SCAN_DISCREPANCY_PARTS) {
      mView.setValidationContent(BusinessConstants.STR_BINNING_DEALER_PLEASE_SCAN_DISCREPANCY_PARTS,true);
      mView.clearAll();
    }else if (binningScanHQ.mStatusCode == BusinessConstants.BINNING_DEALER_COUNT_MISMATCH_PLEASE_PROVIDE_THE_ACTUAL_QUANTITY) {
      mView.setEnableSubmit = false;
      mView.setValidationContent(BusinessConstants.STR_BINNING_DEALER_COUNT_MISMATCH_PLEASE_PROVIDE_THE_ACTUAL_QUANTITY,true);
      mView.getTecVPartQuantity.clear();
    }else {
      mView.alertDialogOnAllPartsBinned(BusinessConstants.STR_BINNING_DEALER_ALL_PARTS_ARE_BINNED_SUCCESSFULLY);
    }
  }

  submitVParts() async {
    if (!Utils.isEmpty(mView.getVPartsQtyExists)) {
      if (await Utils.onCheckNetworkConnection()) {
        mView.setRetry=submitVParts;
        BinSavePart binSavePart;
        binSavePart=BinSavePart(
          mBinsMasterId: mView.getBinId,
          mOrdersMasterId: mView.getBinValidationResult.mOrderId,
          mPartsInOrderId: mView.getBinValidationResult.mPartsInorderId,
          mPartsMasterId: mView.getBinValidationResult.mPartId,
          mVTypeQuantity: int.parse("${Utils.isEmpty(mView.getTecVPartQuantity.text)?"0":mView.getTecVPartQuantity.text}"),
          mTaskInstanceId: null,
          mWarehouseMatInboundId: mView.getWarehouseInboundId,
          mClientExcessOrShortStatus: mView.getClientExcessOrShortStatus
        );
        VPartsPostResponseModel validationResult= await validateVPartsQuantity(binSavePart);
        if(validationResult.mBinnedQuantity!=null && validationResult.mBinnedQuantity!=0)
         mBinValidationModel.mBinnedQuantity=validationResult.mBinnedQuantity;
        mView.setBinValidationResult=mBinValidationModel;
        validateVPartsAgainstQuantity(validationResult.mStatusCode,binSavePart.mVTypeQuantity);
        showProgress(false);
      } else {
        CustomToast.showToast(StringConstants.NO_INTERNET_CONNECTION);
      }
    }
  }

  validateVPartsAgainstQuantity(int status,int quantity) {
    if (status == BusinessConstants.PLEASE_SCAN_CORRECT_PART_WITH_CORRECT_BIN) {
      mView.setValidationContent(BusinessConstants.STR_PLEASE_SCAN_CORRECT_PART_WITH_CORRECT_BIN,true);
    }
    else if (status == BusinessConstants.LESS_QUANTITY) {
      mView.alertDialogForShort();
    }
    else if (status == BusinessConstants.EXCESS_QUANTITY) {
      mView.alertDialogForExcess();
    }
    else if (status == BusinessConstants.SUCCESSFULLY_SENT_TO_WAREHOUSE_MANAGER_APPROVAL) {
      mView.setEnableSubmit = false;
      mView.setValidationContent(BusinessConstants.STR_SUCCESSFULLY_SENT_TO_WAREHOUSE_MANAGER_APPROVAL,false);
      mView.getTecBinOrLPN.clear();
      mView.getTecVPartQuantity.clear();
      mView.setScannedBinOrPart="";
      mView.setVPartType=false;
      mView.setScannedBinAndPart=false;
    }
    else if(status == BusinessConstants.BINNING_ENTERED_QUANTITY_IS_EQUAL_TO_QTY_IN_ORDER_CREATION_BUT_CLAIMING_SHORT){
      mView.setInvalidBinOrPart=false;
      mView.setClientExcessOrShortStatus(4);
      mView.setValidationContent(BusinessConstants.STR_BINNING_SHORT_EXCEPTION_NOT_ALLOWED,true);
    }
    else if(status == BusinessConstants.BINNING_ENTERED_QUANTITY_IS_GREATER_THAN_QTY_FROM_ORDER_CREATION){
      mView.setInvalidBinOrPart=false;
      mView.setClientExcessOrShortStatus(4);
      mView.setValidationContent(BusinessConstants.STR_BINNING_SHORT_EXCEPTION_NOT_ALLOWED,true);
    }
    else if(status == BusinessConstants.BINNING_USER_CAN_PROCEED_TO_SHORT){
      mView.alertDialogForShort();
    }
    else if (status == BusinessConstants.FAILED_TO_SEND_TO_WAREHOUSE_MANAGER_APPROVAL) {
      mView.setEnableSubmit = false;
      mView.setValidationContent(BusinessConstants.STR_FAILED_TO_SEND_TO_WAREHOUSE_MANAGER_APPROVAL,true);
    }
    else if (status == BusinessConstants.SUCCESSFULLY_SCANNED_V_TYPE_PART) {
      mView.setEnableSubmit = false;
      mView.setValidationContent("Successfully scanned Qty:$quantity against LPN ${mView.getPartLPN} into bin ${mView.getBinLabel}",false);
      mView.setVPartType = false;
      mView.setScannedBinAndPart = false;
      mView.clearAll();
    }
    else if (status == BusinessConstants.PLEASE_SCAN_DISCREPANCY_PARTS) {
      mView.setValidationContent(BusinessConstants.STR_PLEASE_SCAN_DISCREPANCY_PARTS,true);
    }
    else if (status == BusinessConstants.COUNT_MISMATCH_PLEASE_PROVIDE_ACTUAL_QUANTITY) {
      mView.setEnableSubmit = false;
      mView.setValidationContent(BusinessConstants.STR_COUNT_MISMATCH_PLEASE_PROVIDE_ACTUAL_QUANTITY,true);
    }
    else if (status == BusinessConstants.ALL_PARTS_ARE_BINNED_SUCCESSFULLY) {
      mView.getTecBinOrLPN.clear();
      mView.getTecVPartQuantity.clear();
      mView.setScannedBinOrPart="";
      mView.setVPartType=false;
      mView.setScannedBinAndPart=false;
      mView.setValidationContent(BusinessConstants.STR_ALL_PARTS_ARE_BINNED_SUCCESSFULLY,false);
    }
    showProgress(false);
  }

  onProcessBinOrPartForDealer() async {
    if (await Utils.onCheckNetworkConnection()) {
      mView.setRetry=onProcessBinOrPartForDealer;

      mView.setScannedBinOrPart=mView.getTecBinOrLPN.text;
      BinningScanHQ binningScanHQ = new BinningScanHQ();
      String siteId = await getSitID();

      binningScanHQ = await getBinningScanHQ(BinningScanHQ(
          mBinsMasterId: mView.getBinId,
          mAccountsMasterId: mView.getBinValidationResult?.mAccountsMasterId,
          mOrderMasterId: mView.getBinValidationResult.mOrderId,
          mPartsInOrderId: mView.getBinValidationResult.mPartsInOrderId,
          mPartsMasterId: mView.getBinValidationResult.mPartId,
          mVPartsExistQty: (mView.getBinId != null && mView.getTecVPartQuantity.text.length!=0?
          int.parse(mView.getTecVPartQuantity.text):0),
          mSerialNumber: mView.getScannedBinOrPart,
          mTaskInstanceId: null,
          mBinTypeId: mView.getBinTypeMasterId,
          mSiteMasterId: siteId
      ));
      checkScanningValidationResultDealer(binningScanHQ);
      mView.setInvalidBinOrPart = binningScanHQ.mStatusCode == 1 ||
          binningScanHQ.mStatusCode == 5 ||
          binningScanHQ.mStatusCode == 4
          ? false
          : true;

      mView.getTecBinOrLPN.clear();
      showProgress(false);
    }
    else {
      CustomToast.showToast(StringConstants.NO_INTERNET_CONNECTION);
    }
  }

  createHQLabel(int input) async {
    if (await Utils.onCheckNetworkConnection()) {
      String label = await generateHusquvarnaVPartsLabel(
          mView.getBinValidationResult.mOrderId,
          mView.getBinValidationResult.mPartsInOrderId,
          input,
          mView.getBinValidationResult.mPartId);
      if(!Utils.isEmpty(label))
        mView.alertDialogOnLabelGenerated(BusinessConstants.STR_PARTS_LABELS_GENERATED_SUCCESSFULLY,label);
    } else {
      CustomToast.showToast(StringConstants.NO_INTERNET_CONNECTION);
    }
  }

}
