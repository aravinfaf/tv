import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:tvs_visibility/src/visibility/model/podmodel/postpoddetailsmodel.dart';
import 'package:tvs_visibility/src/visibility/repository/podrepository/savepodrepository.dart';

class PodDetailBloc {
  var mProgressBar = BehaviorSubject<bool>();
  var mChecked = BehaviorSubject<bool>();
  SavePodRepository mSavePodRepository;

  dispose() {
    mProgressBar.close();
    mChecked.close();
  }

  PodDetailBloc(this.mSavePodRepository);

  Observable<bool> get isCheck => mChecked.stream;

  Function(bool) get setCheckBox => mChecked.sink.add;

  Function(bool) get showProgress => mProgressBar.sink.add;

  Observable<bool> get isLoading => mProgressBar.stream;

  Future<String> submitPODDetails(PostPodDetailsModel model) async {
    showProgress(true);
    var savePodResponse = await mSavePodRepository.onSavePodResponse(model);
    if (savePodResponse==null || savePodResponse == "ERROR")
     mProgressBar.addError("Something went wrong!");
    else
    showProgress(false);
    return savePodResponse;
  }

}
