import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:tvs_visibility/src/visibility/dataprovider/sharedprefs.dart';
import 'package:tvs_visibility/src/visibility/model/despatchlistmodel/activetaskresponsemodel.dart';
import 'package:tvs_visibility/src/visibility/model/despatchlistmodel/dispatchdetailsmodel.dart';
import 'package:tvs_visibility/src/visibility/model/endcustomerdetailmodel/endcustomerdetailmodel.dart';
import 'package:tvs_visibility/src/visibility/model/getmodeoftransportmodel/getmodeoftransportmodel.dart';
import 'package:tvs_visibility/src/visibility/repository/dispatchrepository/dispatchrepository.dart';

class DispatchListingBloc{
  CustomSharedPrefs mSharedPrefs;
  DispatchRepository dispatchRepository;
  var mProgressBar = BehaviorSubject<bool>();
  List<EndCustomerDetailModel> mEndCustomerDetails = [];
  List<GetModeOfTransportModel> mModeOfTransport = [];

  DispatchListingBloc(this.dispatchRepository, this.mSharedPrefs);

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
  Future<List<DispatchListDTO>> onProcess(String filter, String filterColumn,
      bool paging, int currentPage, int limit, String minDate) async {
    List<DispatchListDTO> dispatchDetailsList = [];
    String userId = await mSharedPrefs.getUserId();
    String siteId = await mSharedPrefs.getSiteId();

    dispatchDetailsList = await dispatchRepository.getDispatchList(
        new DispatchDetailsDto(
            mColumn: filterColumn,
            mPageNumber: currentPage,
            mPageSize: limit,
            mSearch: filter,
            mSiteId: siteId,
            mUserId: userId));

    return dispatchDetailsList;
  }

  @override
  Future<List<ActiveTaskConsolidationModel>> getActiveTaskConsolidationBloc(
      String consolidationId) async {
    List<ActiveTaskConsolidationModel> activeTaskConsolidationList = [];
    activeTaskConsolidationList =
    await dispatchRepository.getActiveTaskList(consolidationId);
    return activeTaskConsolidationList;
  }

}