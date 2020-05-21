

import 'package:tvs_visibility/src/visibilitydealer/binning/model/binlocationmodel/binScanningResponse.dart';

class BinScanningViewContract{

  set setIsBinScanned(bool isBinScanned){}

  get getIsBinScanned{}

  set setScannedBinOrPart(String mScannedBinOrPart){}

  get getScannedBinOrPart{}

  set setIsVPartType(bool mVPartType){}

  get getIsVPartType{}

  set setBinScanningResponse(BinScanningResponse response){}

  get getBinScanningResponse{}

  set setMessage(String message){}

  get getMessage{}

  set setRetry(Function retry){}

  get getQuantity{}

  set setQuantity(String Quantity){}

  set setShortOrExcess(String alertType){}

  get getShortOrExcess{}

  set setCanShowShortAlert(bool canShowShortAlert){}

  get getCanShowShortAlert{}

  set setHasError(bool hasError){}

  set setIsShortClicked(bool isShortClicked){}

  get getIsShortClicked{}

  set setBinLabel(String binLabel){}

  get getBinLabel{}

  set setBinMasterId(String binMasterId){}

  get getBinMasterID{}

  set setResult(String result){}

  get getResult{}
}


