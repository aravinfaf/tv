import 'dart:async';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/postdispatchmasterdetailsmodel/postdispatchmasterdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/repository/partnooutwardrepository.dart';
import 'package:rxdart/rxdart.dart';

class PartNumberActionBloc{
  var mProgressBar = BehaviorSubject<bool>();
  var mDispatchDetailList = BehaviorSubject<List<PostDispatchMasterDetailsModel>>();
  PartNumberOutwardRepository mRepository;

  dispose() {
    mDispatchDetailList.close();
    mProgressBar.close();
  }

  onScannedResults(List<PostDispatchMasterDetailsModel> list){
    mDispatchDetailList.sink.add(list);
  }

  Observable<List<PostDispatchMasterDetailsModel>> get dispatchResults => mDispatchDetailList.stream;

  Function(bool) get showProgress => mProgressBar.sink.add;

  Observable<bool> get isLoad => mProgressBar.stream;

  PartNumberActionBloc(this.mRepository);

  Future<List<PostDispatchMasterDetailsModel>> getPartNumberActionResult(String dispatchTypeMasterId, String orderNumber,
      List<PostDispatchMasterDetailsModel> scanList,String userName,String mobile) async {
    showProgress(true);
    List<PostDispatchMasterDetailsModel> dispatchMasterDetailsList = [];;

    dispatchMasterDetailsList = await mRepository.dispatchMaster(dispatchTypeMasterId,orderNumber, scanList,userName,mobile);
    if (dispatchMasterDetailsList!=null && dispatchMasterDetailsList[0].mError)
      mProgressBar.addError('Something went wrong!');
    else
      showProgress(false);
    return dispatchMasterDetailsList;
  }


  getPostDispatchMasterDetailsInList(List<List<PostDispatchMasterDetailsModel>> model){
    List<PostDispatchMasterDetailsModel> list=[];
    model.forEach((v){
      v.forEach((data){
        list.add(data);
      });
    });
    onScannedResults(list);
    showProgress(false);
    return list;
  }

}

