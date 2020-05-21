import 'package:rxdart/rxdart.dart';

abstract class BaseBloc {
  var showProgressBar = PublishSubject<bool>();
  var retry = PublishSubject<bool>();

  dispose() {
    showProgressBar.close();
    retry.close();
  }


  showProgress(bool load) {
    showProgressBar.sink.add(load);
  }

  Observable<bool> get isLoad => showProgressBar.stream;

  onRetry(bool isRetry) {
    retry.sink.add(isRetry);
  }

  Observable<bool> get isRetry => retry.stream;

}
