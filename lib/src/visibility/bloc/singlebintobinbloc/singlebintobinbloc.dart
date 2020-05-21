import 'package:rxdart/rxdart.dart';
import 'package:tvs_visibility/src/visibility/constants/businessconstants.dart';
import 'package:tvs_visibility/src/visibility/repository/singlebintobinrepository/singlebintobinrepository.dart';
import 'package:tvs_visibility/src/visibility/ui/singlebintobintransfer/singlebintobincontract.dart';
import 'package:tvs_visibility/src/visibility/utililty/utils.dart';

class SingleBinToBinBloc {
  var mProgressBar = BehaviorSubject<bool>();
  SingleBinToBinRepository mSingleBinToBinRepository;
  int statusCode;
  SingleBinToBinContract mView;

  dispose() {
    mProgressBar.close();
  }

  SingleBinToBinBloc(this.mSingleBinToBinRepository);

  Function(bool) get showProgress => mProgressBar.sink.add;

  Observable<bool> get isLoading => mProgressBar.stream;

  Future<int> singleBinToBinTransfer(String binOrPart, String binId) async {
    showProgress(true);
    statusCode = await mSingleBinToBinRepository.singleBinToBinTransfer(
        binOrPart, binId);
    if (statusCode != null) {
      if (statusCode == BusinessConstants.SINGLE_BIN_TRANSFER_DATA_MISMATCH) {
        mView.setStatusMessage(BusinessConstants.STR_SINGLE_BIN_TRANSFER_DATA_MISMATCH, false);
      } else if (statusCode == BusinessConstants.SINGLE_BIN_TRANSFER_LOCKED_FOR_PICKING && Utils.isEmpty(mView.getBinLabel())) {
        mView.setStatusMessage(
            BusinessConstants.STR_BINNING_PLEASE_SCAN_BIN_FIRST, false);
      } else if (statusCode == BusinessConstants.SINGLE_BIN_TRANSFER_LOCKED_FOR_PICKING) {
        mView.setStatusMessage(
            "Scanned LPN $binOrPart is locked for picking", false);
      } else if (statusCode == BusinessConstants.SINGLE_BIN_TRANSFER_SCAN_CORRECT_BIN_OR_PART) {
        mView.setStatusMessage(BusinessConstants.STR_SINGLE_BIN_TRANSFER_SCAN_CORRECT_BIN, false);
      } else if (statusCode == BusinessConstants.SINGLE_BIN_TRANSFER_SUCCESSFULLY_SCANNED_LPN_TO_BIN) {
        mView.setStatusMessage(
            'Succesfully Scanned LPN $binOrPart into bin $binId', true);
      } else if (statusCode == BusinessConstants.SINGLE_BIN_TRANSFER_WRONG_BIN_TYPE) {
        mView.setStatusMessage(
            'LPN $binOrPart is scanned to the wrong bin type', false);
      }
      else if (statusCode == BusinessConstants.SINGLE_BIN_TRANSFER_LPN_NOT_AVAILABLE&& Utils.isEmpty(mView.getBinLabel())) {
        mView.setStatusMessage(BusinessConstants.STR_BINNING_PLEASE_SCAN_BIN_FIRST, false);
      }else if (statusCode == BusinessConstants.SINGLE_BIN_TRANSFER_LPN_NOT_AVAILABLE) {
        mView.setStatusMessage(BusinessConstants.STR_SINGLE_BIN_TRANSFER_LPN_NOT_AVAILABLE, false);
      } else if (statusCode == BusinessConstants.SINGLE_BIN_TRANSFER_PART_ALREADY_EXISTS) {
        mView.setStatusMessage(BusinessConstants.STR_SINGLE_BIN_TRANSFER_PART_ALREADY_EXISTS, false);
      } else if (statusCode == BusinessConstants.SINGLE_BIN_TRANSFER_SUCCESSFULLY_SCANNED_BIN) {
        mView.setStatusMessage('Successfully Scanned Bin - $binOrPart', true);
        mView.setScanNumber(binOrPart);
      }else if (statusCode == BusinessConstants.SINGLE_BIN_TRANSFER_INVALID_LPN_PICKED  && Utils.isEmpty(mView.getBinLabel())) {
        mView.setStatusMessage(BusinessConstants.STR_SINGLE_BIN_TRANSFER_INVALID_BIN, false);
      }else if (statusCode == BusinessConstants.SINGLE_BIN_TRANSFER_INVALID_LPN_PICKED) {
        mView.setStatusMessage(BusinessConstants.STR_SINGLE_BIN_TRANSFER_LPN_NOT_AVAILABLE, false);
      }
    } else {
      mProgressBar.addError("Please try again");
    }
    return statusCode;
  }
}

