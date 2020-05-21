import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:tvs_visibility/src/visibility/repository/homerepository.dart';

class HomeBloc {
  var mProgressBar = PublishSubject<bool>();
  var mTitle = PublishSubject<String>();

  HomeRepository mHomeRepository;

  dispose() {
    mProgressBar.close();
    mTitle.close();
  }

  HomeBloc(this.mHomeRepository);

  Function(bool) get showProgress => mProgressBar.sink.add;

  Function(String) get setTitle => mTitle.sink.add;

  Observable<bool> get isLoad =>
      mProgressBar.stream.transform(validateProgress);

  Observable<String> get getTitle => mTitle.stream;

  final validateProgress =
  StreamTransformer<bool, bool>.fromHandlers(handleData: (progress, sink) {
    if (progress) {
      sink.add(progress);
    }
  });

  getActivityDetailsList(HomeListener listener, int selectedIndex) async {
    List<String> activityList =
    await mHomeRepository.getActivityDetailList();
    String username = await mHomeRepository.getUserName();
    listener.onSetData(activityList, username);
    setTitle(activityList.length > 0 ? activityList[selectedIndex] : null);
    return activityList;
  }

  Future<bool> userLogOut() async {
    return await mHomeRepository.deleteUserLoggedDetails();
  }
}

class HomeListener {
  void onSetData(List<String> activityList, String userName) {}
}
