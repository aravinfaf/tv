import 'package:rxdart/rxdart.dart';
import 'package:tvs_visibility/src/visibility/constants/StringConstants.dart';
import 'package:tvs_visibility/src/visibility/dataprovider/sharedprefs.dart';
import 'package:tvs_visibility/src/visibility/utililty/utils.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/model/binlocationmodel/binScanningRequest.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/model/binlocationmodel/binScanningResponse.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/repository/binrepository.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/ui/binScanning/binScanningViewContract.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/businessconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/toast/customtoast.dart';

class BinScanningBloc {

  var mProgressBar = BehaviorSubject<bool>();

  Function(bool) get showProgress => mProgressBar.sink.add;

  Observable<bool> get isLoading => mProgressBar.stream;

  BinScanningViewContract mView;

  BinRepository binRepository;

  CustomSharedPrefs mCustomSharedPrefs;

  BinScanningBloc(this.binRepository, this.mCustomSharedPrefs);


  dispose(){
    mProgressBar.close();
  }


  validateInputsAndMakeServiceCall() {
    mView.setRetry = validateInputsAndMakeServiceCall;
    if (!Utils.isEmpty(mView.getScannedBinOrPart)) {
      if (!mView.getIsBinScanned) {
        makeBinService();
      } else if (mView.getIsBinScanned && !mView.getIsVPartType) {
        makeSerialNoService();
      } else if (!Utils.isEmpty(mView.getQuantity)) {
        int quantity = int.parse(mView.getQuantity);
        int remainingQuantity = mView.getBinScanningResponse.mRemainingQty;
        if (mView.getIsShortClicked) {
          if(mView.getCanShowShortAlert){
            mView.setShortOrExcess = "Short";
          }else if (quantity > remainingQuantity || quantity == remainingQuantity) {
            mView.setShortOrExcess = "ShortException";
          } else {
            makeVPartBinningService();
          }
        } else {
          if (mView.getCanShowShortAlert) {
            if (quantity > remainingQuantity) {
              mView.setShortOrExcess = "Excess";
            } else {
              makeVPartBinningService();
            }
          } else {
            makeVPartBinningService();
          }
        }
      } else {
        mView.setMessage = "Enter Quantity";
        mView.setHasError = true;
        showProgress(false);
      }
    } else {
      mView.setMessage = "Enter Bin/LPN";
      mView.setHasError = true;
      showProgress(false);
    }
  }

  makeBinService() async {
    if (await Utils.onCheckNetworkConnection()) {
      BinScanningRequest request = new BinScanningRequest();
      request.mScanText = mView.getScannedBinOrPart;
      request.mSiteMasterId = await mCustomSharedPrefs.getSiteID();
      showProgress(true);
      BinScanningResponse response =
      await binRepository.validatePartOrBin1(request);
      showProgress(false);
      if (response != null) {
        String message;
        if (response.mBinStatus != null &&
            response.mBinStatus == BusinessConstants.BIN_SCAN_SUCCESS) {
          mView.setScannedBinOrPart = "";
          mView.setIsBinScanned = true;
          mView.setBinLabel = response.mBinLabel;
          mView.setBinMasterId = response.mBinId;
          message = response.mMessage;
          mView.setHasError = false;
        } else {
          mView.setIsBinScanned = false;
          message = "Invalid Bin No";
          mView.setHasError = true;
        }
        mView.setMessage = message;
        showProgress(false);
      } else {
        mProgressBar.addError("Something went wrong!");
      }
    }else{
      CustomToast.showToast(StringConstants.NO_INTERNET_CONNECTION);
    }
  }

  makeSerialNoService() async {
    if (await Utils.onCheckNetworkConnection()) {
      BinScanningRequest request = new BinScanningRequest();
      request.mScanText = mView.getScannedBinOrPart;
      request.mSiteMasterId = await mCustomSharedPrefs.getSiteID();
      request.mBinLabel = mView.getBinLabel;
      request.mBinId = mView.getBinMasterID;
      showProgress(true);
      BinScanningResponse response =
      await binRepository.validatePartOrBin1(request);
      showProgress(false);
      if (response != null) {
        if (response.mBinStatus != null &&
            (response.mBinStatus == BusinessConstants.BIN_SHORT_ACCEPTED ||
                response.mBinStatus == BusinessConstants.COMPLETE_BINNING ||
                response.mBinStatus == BusinessConstants.THIS_IS_VPART ||
                response.mBinStatus == BusinessConstants.BINNING_SHORT ||
                response.mBinStatus ==
                    BusinessConstants.BINNING_SUCCESS_PROCEED)) {
          mView.setBinScanningResponse = response;
          mView.setIsVPartType =
              response.mPartTypeCode == BusinessConstants.STR_V_PART;
          if (response.mPartTypeCode != BusinessConstants.STR_V_PART) {
            mView.setScannedBinOrPart = "";
          }
          mView.setHasError = false;
        } else if (response.mBinStatus == BusinessConstants.BIN_SCAN_SUCCESS) {
          mView.setScannedBinOrPart = "";
          mView.setHasError = false;
          mView.setIsBinScanned = true;
          mView.setBinLabel = response.mBinLabel;
          mView.setBinMasterId = response.mBinId;
          mView.setBinScanningResponse = null;
        } else
        if (response.mBinStatus == BusinessConstants.BIN_PART_BIN_SUCCESS) {
          mView.setBinScanningResponse = response;
          mView.setScannedBinOrPart = "";
          mView.setHasError = false;
          mView.setResult = "Success";
        } else {
          mView.setBinScanningResponse = null;
          mView.setHasError = true;
        }
        mView.setMessage = response.mMessage;
        showProgress(false);
      } else {
        mProgressBar.addError("Something went wrong!");
      }
    }else{
      CustomToast.showToast(StringConstants.NO_INTERNET_CONNECTION);
    }
  }

  makeVPartBinningService() async {
    if (await Utils.onCheckNetworkConnection()) {
      BinScanningRequest request = new BinScanningRequest();
      request.mScanText = mView.getScannedBinOrPart;
      request.mSiteMasterId = await mCustomSharedPrefs.getSiteID();
      request.mBinStatus = 0;
      request.mProceedExcessOrShort = mView.getIsShortClicked ? 8 : 0;
      request.mBinLabel = mView.getBinLabel;
      request.mBinId = mView.getBinMasterID;
      request.mQuantity = int.parse(mView.getQuantity);
      request.mPartsInOrderId = mView.getBinScanningResponse.mPartsInOrderId;
      request.mRemainingQty = mView.getBinScanningResponse.mRemainingQty;
      request.mOrderId = mView.getBinScanningResponse.mOrderId;
      request.mWareHouseMatInboundId =
          mView.getBinScanningResponse.mWareHouseMatInboundId;
      showProgress(true);
      BinScanningResponse response = await binRepository.vPartBinning(request);
      showProgress(false);
      if (response != null) {
        if (response.mBinStatus != null &&
            (response.mBinStatus == BusinessConstants.BIN_SHORT_ACCEPTED ||
                response.mBinStatus == BusinessConstants.BIN_PART_BIN_SUCCESS ||
                response.mBinStatus == BusinessConstants.COMPLETE_BINNING ||
                response.mBinStatus == BusinessConstants.THIS_IS_VPART ||
                response.mBinStatus == BusinessConstants.BINNING_SHORT ||
                response.mBinStatus ==
                    BusinessConstants.BINNING_SUCCESS_PROCEED)) {
          mView.setBinScanningResponse = response;
          mView.setScannedBinOrPart = "";
          mView.setIsVPartType = false;
          mView.setHasError = false;
          mView.setQuantity = "";
          mView.setResult = "Success";
        } else {
          mView.setBinScanningResponse = null;
          mView.setHasError = true;
        }
        mView.setIsShortClicked = false;
        mView.setMessage = response.mMessage;
        showProgress(false);
      } else {
        mProgressBar.addError("Something went wrong!");
      }
    }else{
      CustomToast.showToast(StringConstants.NO_INTERNET_CONNECTION);
    }
  }
}
