import 'package:tvs_visibility/src/visibility/model/endcustomerdetailmodel/endcustomerdetailmodel.dart';
import 'package:tvs_visibility/src/visibility/model/getmodeoftransportmodel/getmodeoftransportmodel.dart';
import 'package:tvs_visibility/src/visibility/model/sitemasterdetailsmodel/sitemasterdetailsmodel.dart';
import 'package:tvs_visibility/src/visibility/ui/despatch/modeoftransportlistingitems.dart';
import 'package:tvs_visibility/src/visibility/ui/despatch/sitenamelistingitems.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/base/baseinterface.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customlistwidget/customlistandsearch.dart';
import 'package:flutter/material.dart';

class ModeOfTransportListingView extends StatefulWidget{
  ModeOfTransportListener listener;
  List<GetModeOfTransportModel> modeOfTransport;

  ModeOfTransportListingView(this.listener,this.modeOfTransport);

  @override
  State<StatefulWidget> createState() {
    return ModeOfTransportListingViewState(this.listener,this.modeOfTransport);
  }
}

class ModeOfTransportListingViewState extends State<ModeOfTransportListingView> implements OnProcessListener<GetModeOfTransportModel, ModeOfTransportListingItems>,ModeOfTransportListener{
  List<SiteMasterDetailsModel> siteNameModel = [];
  ModeOfTransportListener mListener;
  List<String> mColumnList = [];
  List<String> mFilterList = [];
  List<GetModeOfTransportModel> mModeOfTransport;

  ModeOfTransportListingViewState(this.mListener,this.mModeOfTransport);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return listView();
  }

  Widget listView(){
    return Container(
      padding: EdgeInsets.all(5.0),
      height: MediaQuery.of(context).size.height,
      width: double.maxFinite,
      child: CustomListAndSearch(
        onProcessListener: this,
        mFilterColumnList: mColumnList,
        mFilterList: mFilterList,
        limit: 50,
      ),
    );
  }



  @override
  String getSavedDate(GetModeOfTransportModel item) {
    return null;
  }

  @override
  Future<List<GetModeOfTransportModel>> onProcessing(String filter, String filterColumn, bool paging, int currentPage, int limit, String minDate) async{
    return mModeOfTransport;
  }

  @override
  ModeOfTransportListingItems createView(BuildContext context) {
    return ModeOfTransportListingItems(mListener);
  }

  @override
  void onModeOfTransportItemSelect(BuildContext context, GetModeOfTransportModel item) {
    mListener.onModeOfTransportItemSelect(context, item);
  }

}