import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:tvs_visibility/src/visibility/bloc/dispatchbloc/dispatchlistingbloc.dart';
import 'package:tvs_visibility/src/visibility/constants/StringConstants.dart';
import 'package:tvs_visibility/src/visibility/constants/businessconstants.dart';
import 'package:tvs_visibility/src/visibility/model/despatchlistmodel/activetaskresponsemodel.dart';
import 'package:tvs_visibility/src/visibility/model/despatchlistmodel/dispatchdetailsmodel.dart';
import 'package:tvs_visibility/src/visibility/ui/despatch/dispatchdetailview.dart';
import 'package:tvs_visibility/src/visibility/ui/despatch/dispatchitemview.dart';
import 'package:tvs_visibility/src/visibility/ui/homeview.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customprogressindicator/customprogress.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customprogressindicator/customretry.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customview/customtoast.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/navigaton/navigationutils.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/base/baseinterface.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/utility/utils.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customlistwidget/customlistandsearch.dart';

class DispatchListingView extends StatefulWidget {
  DispatchListingViewState mDispatchListingViewState;

  @override
  DispatchListingViewState createState() {
    mDispatchListingViewState = DispatchListingViewState();
    return mDispatchListingViewState;
  }
}

class DispatchListingViewState extends State<DispatchListingView>
    implements
        OnProcessListener<DispatchListDTO, DispatchListItem>,
        DispatchActionListener{
  List<String> mFilterColumnList = [];
  Function mOnRetry;
  DispatchListingBloc dispatchBloc;
  List<String> mFilterList = [];
  String mConsolidationId;
  String mActorType;
  String mOrderMasterId;
  String mDeliveryType;
  String mDestinationId;

  DispatchListingViewState() {
    var container = kiwi.Container();
    dispatchBloc = container<DispatchListingBloc>();
  }

  @override
  void initState() {
    mFilterColumnList.clear();
    mFilterList.clear();
    mFilterColumnList.add("soNo");
    mFilterColumnList.add("customerName");

    mFilterList.add("SO No");
    mFilterList.add("Customer Name");

    super.initState();
  }

  @override
  void dispose() {
    dispatchBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: false,
        stream: dispatchBloc.isLoading,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && !snapshot.data) {
            return Scaffold(
              body: CustomListAndSearch(
                  onProcessListener: this,
                  mFilterColumnList: mFilterColumnList,
                  mFilterList: mFilterList),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: CustomRetry(
                retry: mOnRetry,
                isTitleRequired: false,
              ),
            );
          } else {
            return CustomProgress(
              isTitleRequired: false,
            );
          }
        });
  }

  @override
  DispatchListItem createView(BuildContext context) {
    return DispatchListItem(widget.mDispatchListingViewState);
  }

  @override
  String getSavedDate(DispatchListDTO item) {
    return null;
  }

  @override
  Future<List<DispatchListDTO>> onProcessing(String filter, String filterColumn,
      bool paging, int currentPage, int limit, String minDate) {
    return dispatchBloc.onProcess(filter, filterColumn, paging, currentPage, limit, minDate);
  }

  @override
  onDispatchAction(String consolidationId, DispatchListDTO model) async {
    if (await Utility.onCheckNetworkConnection()) {
      await getActiveTaskByConsolidation(consolidationId, model);
    } else {
      CustomToast.showToast(StringConstants.NO_INTERNET_CONNECTION);
    }
  }

  Future<List<ActiveTaskConsolidationModel>> getActiveTaskByConsolidation(
      String consolidationId, DispatchListDTO model) async {
    List<ActiveTaskConsolidationModel> activeTaskByConsolidation = [];
    activeTaskByConsolidation =
        await dispatchBloc.getActiveTaskConsolidationBloc(consolidationId);
    navigateToDetailView(activeTaskByConsolidation.length!=0?activeTaskByConsolidation[0].mTaskdefenitionId:"", model);
    return activeTaskByConsolidation;
  }

  void navigateToDetailView(String taskDefinitionId, DispatchListDTO model) {
    if (taskDefinitionId == BusinessConstants.taskDefinitionId) {
      var data = NavigationUtils.push(context, DispatchDetailView(model));
      data.whenComplete(() {
        NavigationUtils.pushAndRemoveUntil(context, navigateToHomeView());
      });
    } else {
      CustomToast.showToast("Operation not allowed");
    }
  }

  navigateToHomeView() {
    return HomeView();
  }
}
