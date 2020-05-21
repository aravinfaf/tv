import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:tvs_visibility/src/visibility/bloc/podbloc/podbloc.dart';
import 'package:tvs_visibility/src/visibility/constants/StringConstants.dart';
import 'package:tvs_visibility/src/visibility/model/podmodel/checkpodkeymodel.dart';
import 'package:tvs_visibility/src/visibility/model/podmodel/postfiltermodel.dart';
import 'package:tvs_visibility/src/visibility/ui/homeview.dart';
import 'package:tvs_visibility/src/visibility/ui/pod/poddetailview.dart';
import 'package:tvs_visibility/src/visibility/ui/pod/podlistitem.dart';
import 'package:tvs_visibility/src/visibility/utililty/utils.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customalerts/customalerts.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customview/customtoast.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/base/baseinterface.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customlistwidget/customlistandsearch.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/navigaton/navigationutils.dart';

class PodListView extends StatefulWidget {

  PodListView();

  @override
  PodListViewState createState() => PodListViewState();
}

class PodListViewState extends State<PodListView>
    with WidgetsBindingObserver
    implements
        OnProcessListener<GenericDtoList, PodListItem>,
        PodActionListener {
  PodBloc mBloc;
  List<String> mFilterColumn = [];
  List<String> mFilterText = [];
  String mVehicleInOut;
  BuildContext mContext;
  bool isBackButtonActivated = false;

  PodListViewState() {
    var container = kiwi.Container();
    mBloc = container<PodBloc>();
  }

  @override
  void initState() {
    mVehicleInOut = null;
    mFilterColumn.clear();
    mFilterText.clear();
    mFilterColumn.add('vehNumber');
    mFilterColumn.add('GateInnumber');
    mFilterText.add('Vehicle Number');
    mFilterText.add('GateIn number');
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    mBloc.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: CustomListAndSearch(
        onProcessListener: this,
        mFilterColumnList: mFilterColumn,
        mFilterList: mFilterText,
      ),
    );
  }

  @override
  PodListItem createView(BuildContext context) {
    return PodListItem(PodListViewState());
  }

  @override
  String getSavedDate(GenericDtoList item) {
    return null;
  }

  @override
  Future<List<GenericDtoList>> onProcessing(String filter, String filterColumn,
      bool paging, int currentPage, int limit, String minDate) {
    return mBloc.onProcess(
        filter, filterColumn, paging, currentPage, limit, minDate);
  }

  @override
  void onPodStatusCheck(String vehicleInOut, BuildContext context) {
    mVehicleInOut = vehicleInOut;
    mContext = context;
    getPodActiveVehicleInOut();
  }

  getPodActiveVehicleInOut() async {
    if (await Utils.onCheckNetworkConnection()) {
      List<CheckPodKeyModel> podStatusModelList = [];
      String taskInstanceId;
      podStatusModelList =
          await mBloc.activeTaskByVehicleInOutId(mVehicleInOut);
      taskInstanceId = mBloc.getTaskInstanceId(podStatusModelList);
      if (!Utils.isEmpty(taskInstanceId)) {
        var data = NavigationUtils.push(
            mContext, PodDetailView(mVehicleInOut, taskInstanceId,));
        data.whenComplete(() {
          navigateToHomeView(mContext);
        });
      } else {
        CustomAlerts.showAlert(mContext, 'Operation not allowed.!');
      }
    } else {
      CustomToast.showToast(StringConstants.NO_INTERNET_CONNECTION);
    }
  }

  navigateToHomeView(BuildContext mContext) {
    return NavigationUtils.pushReplacement(
        mContext,
        HomeView());
  }
}
