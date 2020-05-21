import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:tvs_visibility/src/visibility/dataprovider/sharedprefs.dart';
import 'package:tvs_visibility/src/visibility/model/binninglistmodel/binninglistmodel.dart';
import 'package:tvs_visibility/src/visibility/model/checkpodbybusinesskeymodel/checkpodbybusinesskeymodel.dart';
import 'package:tvs_visibility/src/visibility/model/postbinningfiltermodel/postbinningfiltermodel.dart';
import 'package:tvs_visibility/src/visibility/repository/binrepository.dart';

class BinListBloc {
  BinRepository mRepository;
  CustomSharedPrefs mSharedPrefs;
  var mProgressBar = BehaviorSubject<bool>();

  dispose(){
    mProgressBar.close();
  }

  BinListBloc(this.mRepository,this.mSharedPrefs);

  Function get showProgress => mProgressBar.sink.add;

  Observable<bool> get isLoading => mProgressBar.stream;

  Future<List<BinningListModel>> onProcess(String filter, String filterColumn, bool paging, int currentPage, int limit, String minDate) async {
    List<BinningListModel> binningList=[];
    String userId = await mSharedPrefs.getUserId();
    binningList= await mRepository.getBinList(new PostBinningFilterModel(
      mColumn: filterColumn,
      mPageSize: limit,
      mSearch: filter,
      mPageNumber: currentPage,
      mUserid: userId,
      mPaged: paging,
    ));
    return binningList;
  }

}