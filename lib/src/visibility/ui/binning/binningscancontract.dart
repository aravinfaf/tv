import 'package:flutter/material.dart';
import 'package:tvs_visibility/src/visibility/model/binmodel/binvalidationresult.dart';

class BinScanViewContract{
  set setScanBinOrPart(bool scanBinOrPart){}

  set setScannedBinAndPart(bool scannedBinAndPart){}

  set setInValidBinOrPart(bool invalidBinOrPart){}

  setValidationContent(String validationContent,bool isInvalid){}

  set setSerialLabel(String serialLabel){}

  set setBinLabel(String binLabel){}

  set setBinScanned(bool binScanned){}

  set setVPartsQtyExist(String vPartQtyExist){}

  set setScannedBinOrPart(String scannedBinOrPart){}

  set setBinTypeMasterId(String binTypeMasterId){}

  set setEnableSubmit(bool enableSubmit){}

  set setWarehouseInboundId(String warehouseInboundId){}

  set setInvalidBinOrPart(bool inValid){}

  set setVPartType(bool type){}

  set setBinTypeId(int typeId){}

  set setBinId(String binId){}

  set setPartLPN(String partLPN){}

  set setBinValidationResult(BinValidationResult model){}

  set setTecNoOfLabel(String label){}

  set setTecVPartQuantity(String qty){}

  set setTecBinOrLPN(String binOrLPN){}

  set setRetry(Function retry){}

  alertDialogOnAllPartsBinned(String alertMsg){}

  alertDialogOnLabelGenerated(String alertMsg,String label){}

  alertDialogForExcess(){}

  alertDialogForShort(){}

  alertDialog(String content){}

  get getBinValidationResult{}

  get getScannedBinOrPart{}

  get getBinTypeId{}

  get getPartLPN{}

  get getClientExcessOrShortStatus{}

  TextEditingController get getTecNoOfLabel{}

  TextEditingController get getTecBinOrLPN{}

  TextEditingController get getTecVPartQuantity{}

  get getBinScanned{}

  get getBinId{}

  get getBinLabel{}

  get getVPartsQtyExists{}

  get getWarehouseInboundId{}

  get getBinTypeMasterId{}

  clearAll(){}

  navigateToHomeView(){}

  setClientExcessOrShortStatus(int status){}
}

class BinScanBlocContract{


}