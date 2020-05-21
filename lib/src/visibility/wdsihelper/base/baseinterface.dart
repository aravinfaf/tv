import 'dart:async';

import 'package:flutter/material.dart';

abstract class Validator {
  String getValidation(String val, String validationMessage);
}

abstract class ViewModel {
  void onTextChanged(String text, int id);

  void onDataSubmit(int id);
}

abstract class AutoCompleteInterFace<BaseAutoCompleteItem> {
  Future<List<BaseAutoCompleteItem>> getAutoCompleteData(String data, int id);

  void onItemSelected(BaseAutoCompleteItem data, int id);
}

abstract class OnProcessListener<Item, View extends DataBaseView<Item>> {
  Future<List<Item>> onProcessing(String filter, String filterColumn,
      bool paging, int currentPage, int limit, String minDate);

  View createView(BuildContext context);

  String getSavedDate(Item item);
}

abstract class DataBaseView<Item> extends StatelessWidget {
  Item item;

  Widget setItem(Item item) {
    this.item = item;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return bind(context);
  }

  Widget bind(BuildContext context);
}

abstract class BaseAutoCompleteItem {
  String getText();

  int getID();

  dynamic getData();
}

abstract class BaseBloc {
 final StreamController<bool> retry = StreamController<bool>.broadcast();
 final StreamController<bool> showProgressBar = StreamController<bool>.broadcast();

  dispose() {
    showProgressBar.close();
    retry.close();
  }

  showProgress(bool load) {
    showProgressBar.sink.add(load);
  }

 // Observable<bool> get isLoad => showProgressBar.stream.distinct();
  get isLoad => showProgressBar.stream.asBroadcastStream();

  onRetry(bool isRetry) {
    retry.sink.add(isRetry);
  }

  get isRetry => retry.stream.asBroadcastStream();
}
