import 'package:rxdart/rxdart.dart';
import 'package:tvs_visibility/src/visibility/dataprovider/sharedprefs.dart';
import 'package:tvs_visibility/src/visibility/model/authorizationresponsemodel/authorizationresponsemodel.dart';
import 'package:tvs_visibility/src/visibility/model/preBinning/preBinningModel.dart';
import 'package:tvs_visibility/src/visibility/model/preBinning/preBinningRequestModel.dart';
import 'package:tvs_visibility/src/visibility/repository/preBinningRepository/preBinningRepository.dart';

class PreBinningBloc{

  PreBinningRepository mRepository;

  CustomSharedPrefs mCustomSharedPrefs;

  PreBinningBloc(this.mRepository, this.mCustomSharedPrefs);

  Future<List<PreBinningModel>> onProcess(String filter, String filterColumn,
      bool paging, int currentPage, int limit, String minDate) async {

    AuthorizationResponseModel model = await mCustomSharedPrefs.getUserInfo();
    String taskKey;
    if(model.workflowProcessMasterDTOList !=null && model.workflowProcessMasterDTOList.length >0 && model.workflowProcessMasterDTOList[0].getWorkFlowActivityMasterList!=null
       && model.workflowProcessMasterDTOList[0].getWorkFlowActivityMasterList.length >0){
       taskKey = model.workflowProcessMasterDTOList[0].getWorkFlowActivityMasterList[0].taskKey;
    }
    PreBinningRequestModel preBinningRequestModel = PreBinningRequestModel(column: filterColumn, search: filter, pageNumber: currentPage, pageSize: limit, taskkey: taskKey);
    PreBinningResponseModel data = await mRepository.getPreBinning(preBinningRequestModel);
    return data!=null? data.genericDTOList : null;
  }

}