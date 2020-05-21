import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:tvs_visibility/src/visibility/constants/baseconstants.dart';
import 'package:tvs_visibility/src/visibility/constants/businessconstants.dart';
import 'package:tvs_visibility/src/visibility/model/podmodel/checkpodkeymodel.dart';
import 'package:tvs_visibility/src/visibility/model/podmodel/postfiltermodel.dart';
import 'package:tvs_visibility/src/visibility/repository/podrepository/podrepository.dart';

class PodBloc {
  var mProgressBar = BehaviorSubject<bool>();

  PodRepository mRepository;

  dispose() {
    mProgressBar.close();
  }

  PodBloc(this.mRepository);

   Function(bool) get showProgress => mProgressBar.sink.add;

  Observable<bool> get isLoading => mProgressBar.stream;

  Future<List<GenericDtoList>> onProcess(String filter, String filterColumn,
      bool paging, int currentPage, int limit, String minDate) async {
    showProgress(true);
    var data = await mRepository.getPodList(new PostFilterModel(
      column: filterColumn,
      search: filter,
      pageNumber: currentPage,
      paged: paging,
      pageSize: limit,
    ));
    showProgress(false);
    return data.genericDTOList?.length != 0 ? data.genericDTOList : [];
  }

  Future<List<CheckPodKeyModel>> activeTaskByVehicleInOutId(
      String vehicleInOutId) async {
    showProgress(true);
    List<CheckPodKeyModel> podStatusModelList = [];
    podStatusModelList = await mRepository.getActiveTaskByVehicleInOutId(vehicleInOutId);
    /*if(podStatusModelList[0]==null)
      isError=true;*/
    showProgress(false);
    return podStatusModelList;
  }

  getTaskInstanceId(List<CheckPodKeyModel> checkPodKeyModel) {
    if (checkPodKeyModel.length != 0) {
      for (CheckPodKeyModel model in checkPodKeyModel) {
        if (model?.taskInstanceId != null &&
            model?.taskdefenitionId ==
                BusinessConstants.TASK_KEY_FOR_POD_GENERATION) {
          return model.taskInstanceId;
        }
      }
    }
  }
}
