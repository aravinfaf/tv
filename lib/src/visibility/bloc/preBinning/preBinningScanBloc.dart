import 'package:rxdart/rxdart.dart';
import 'package:tvs_visibility/src/visibility/constants/StringConstants.dart';
import 'package:tvs_visibility/src/visibility/model/authorizationresponsemodel/authorizationresponsemodel.dart';
import 'package:tvs_visibility/src/visibility/model/preBinning/PreBinningScanRequestModel.dart';
import 'package:tvs_visibility/src/visibility/repository/preBinningRepository/preBinningRepository.dart';
import 'package:tvs_visibility/src/visibility/ui/preBinning/preBinningScanContract.dart';
import 'package:tvs_visibility/src/visibility/utililty/utils.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/toast/customtoast.dart';

import '../../dataprovider/sharedprefs.dart';

class PreBinningScanBloc {
  PreBinningRepository mRepository;

  var mProgressBar = BehaviorSubject<bool>();

  CustomSharedPrefs mCustomSharedPrefs;

  var checkBox = new BehaviorSubject<bool>();

  PreBinningScanContract mView;

  PreBinningScanBloc(this.mRepository, this.mCustomSharedPrefs);

  Function(bool) get showProgress => mProgressBar.sink.add;

  Observable<bool> get isLoad => mProgressBar.stream;


  dispose() {
    mProgressBar.close();
  }

  submitParts() async {
    if (!Utils.isEmpty(mView.getSerialNo)) {
      if (await Utils.onCheckNetworkConnection()) {
        mView.setRetry = submitParts;
        showProgress(true);

        String userId = await mCustomSharedPrefs.getUserId();
        String siteId = await mCustomSharedPrefs.getSiteID();
        String taskId;
        String taskKey;

        AuthorizationResponseModel model =
            await mCustomSharedPrefs.getUserInfo();
        if (model.workflowProcessMasterDTOList != null &&
            model.workflowProcessMasterDTOList.length > 0 &&
            model.workflowProcessMasterDTOList[0]
                    .getWorkFlowActivityMasterList !=
                null &&
            model.workflowProcessMasterDTOList[0].getWorkFlowActivityMasterList
                    .length >
                0) {
          taskId = model.workflowProcessMasterDTOList[0]
              .getWorkFlowActivityMasterList[0].tblStatusCodeMasterId;
          taskKey = model.workflowProcessMasterDTOList[0]
              .getWorkFlowActivityMasterList[0].taskKey;
        }

        PreBinningScanRequestModel preBinningScanModel =
            PreBinningScanRequestModel(
                userId: userId,
                serialNo: mView.getSerialNo,
                statusCodeMasterId: taskId,
                matinbound: mView.getSerialNo,
                siteId: siteId,
                taskKey: taskKey);
        postPreBinningScan(preBinningScanModel).then((code) {
          switch (code) {
            case 1:
              mView.setResult = "Success";
              mView.clearSerialNo();
              mView.setmEnableSubmit = false;
              CustomToast.showToast("Success");
              break;

            case 2:
              CustomToast.showToast("Already Exist");
              break;

            case 3:
              CustomToast.showToast("Invalid Serial No");
              break;

            case 4:
              CustomToast.showToast("Pre Binning Completed");
              break;

            case 0:
              CustomToast.showToast("Some Error Occured!");
              break;

          }
        });
        showProgress(false);
      } else {
        CustomToast.showToast(StringConstants.NO_INTERNET_CONNECTION);
      }
    } else {
      CustomToast.showToast("Enter Serial No");
    }
  }

  Future<int> postPreBinningScan(PreBinningScanRequestModel model) async {
    showProgress(true);
    int scanResponseModel;
    scanResponseModel = await mRepository.postPreBinningScan(model);
    showProgress(false);
    return scanResponseModel;
  }
}
