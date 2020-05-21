import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:tvs_visibility/src/visibility/dataprovider/sharedprefs.dart';
import 'package:tvs_visibility/src/visibility/model/gateinout/creategatein.dart';
import 'package:tvs_visibility/src/visibility/model/gateinout/creategateout.dart';
import 'package:tvs_visibility/src/visibility/model/podmodel/postfiltermodel.dart';
import 'package:tvs_visibility/src/visibility/repository/gateinout/gaterepository.dart';

class GateListBloc {
  var mProgressBar = BehaviorSubject<bool>();
  GateRepository mGateRepository;
  CustomSharedPrefs mSharedPrefs;

  dispose() {
    mProgressBar.close();
  }

  GateListBloc(this.mGateRepository,this.mSharedPrefs);

 Function(bool) get showProgress => mProgressBar.sink.add;

  Observable<bool> get isLoading => mProgressBar.stream;

  Future<List<GenericDtoList>> onProcess(String filter, String filterColumn,
      bool paging, int currentPage, int limit, String minDate) async {
    String siteId = await mSharedPrefs.getSiteID();
    var data = await mGateRepository.getGateLists(PostFilterModel(
      column: filterColumn,
      search: filter,
      pageNumber: currentPage,
      pageSize: limit,
      siteId: siteId,
      paged: paging,
    ));
    return data.genericDTOList??[];
  }

  Future<bool> gateOutVehicle(CreateGateOutModel createGateOutModel) async {
    showProgress(true);
    bool gateOutResult = await mGateRepository.gateOutVehicle(createGateOutModel);
    if(gateOutResult == null)
     mProgressBar.addError("Something went wrong!");
    return gateOutResult;
  }

  Future<int> gateInVehicle(CreateGateInModel model) async {
    showProgress(true);
    int gateInResult = await mGateRepository.onGateIn(model);
    if(gateInResult == null)
      mProgressBar.addError("Something went wrong!");

    return gateInResult;
  }


}
