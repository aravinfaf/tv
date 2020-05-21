import 'package:flutter/widgets.dart';

abstract class Validator {
  String getValidation(String val, String validationMessage);
}

abstract class ViewModel {
  void onTextChanged(String text, int id);

  void onDataSubmit(int id);
}

abstract class AutoCompleteInterFace<BaseAutoCompleteItem> {
  Future<List<BaseAutoCompleteItem>> getAutoCompleteData(String data, String id);

  void onItemSelected(BaseAutoCompleteItem data, String id);
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


