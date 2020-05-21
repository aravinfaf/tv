import 'package:flutter/material.dart';
import 'package:tvs_visibility/src/visibility/bloc/Picking/pickingbloc.dart';
import 'package:tvs_visibility/src/visibility/constants/StringConstants.dart';
import 'package:tvs_visibility/src/visibility/model/picking/pickingmodel.dart';
import 'package:tvs_visibility/src/visibility/ui/homeview.dart';
import 'package:tvs_visibility/src/visibility/ui/picking/picklistitem.dart';
import 'package:tvs_visibility/src/visibility/ui/picking/pickscan.dart';
import 'package:tvs_visibility/src/visibility/utililty/utils.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customview/customtoast.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/base/baseinterface.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customlistwidget/customlistandsearch.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/navigaton/navigationutils.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class PickingList extends StatefulWidget {
  PickingListState mPicking;

  PickingList();

  @override
  PickingListState createState() {
    mPicking = PickingListState();
    return mPicking;
  }
}

class PickingListState extends State<PickingList> implements OnProcessListener<PickingLocationModel, PickListItem>, PickScanListener {
  PickBloc mPickBloc;
  List<String> mFilterColumnList = [];
  List<String> mFilterList = [];

  PickingListState() {
    var container = kiwi.Container();
    mPickBloc = container<PickBloc>();
  }

  @override
  void initState() {
    mFilterColumnList.clear();
    mFilterList.clear();
    mFilterColumnList.add("customerReference");

    mFilterList.add("Customer Ref Number");
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: CustomListAndSearch(
            onProcessListener: this,
            mFilterColumnList: mFilterColumnList,
            mFilterList: mFilterList),
      ),
    );
  }

  @override
  PickListItem createView(BuildContext context) {
    return PickListItem(PickingListState());
  }

  @override
  String getSavedDate(PickingLocationModel item) {
    return null;
  }

  @override
  Future<List<PickingLocationModel>> onProcessing(
      String filter,
      String filterColumn,
      bool paging,
      int currentPage,
      int limit,
      String minDate) async {
    if (await Utils.onCheckNetworkConnection()) {
      return mPickBloc.OnProcessing(
          filter, filterColumn, paging, currentPage, limit, minDate);
    } else {
      CustomToast.showToast(StringConstants.NO_INTERNET_CONNECTION);
    }
  }

  @override
  void onPickingScan(PickingLocationModel model, BuildContext mContext) {
    var data = NavigationUtils.push(mContext, PickingScanning(model));
    data.whenComplete(() {
      NavigationUtils.pushAndRemoveUntil(mContext, navigateToHomeView());
    });
  }

  navigateToHomeView() {
    return HomeView();
  }
}
