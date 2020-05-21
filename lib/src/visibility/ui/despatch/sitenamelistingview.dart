import 'package:tvs_visibility/src/visibility/model/endcustomerdetailmodel/endcustomerdetailmodel.dart';
import 'package:tvs_visibility/src/visibility/model/sitemasterdetailsmodel/sitemasterdetailsmodel.dart';
import 'package:tvs_visibility/src/visibility/ui/despatch/sitenamelistingitems.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/base/baseinterface.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customlistwidget/customlistandsearch.dart';
import 'package:flutter/material.dart';

class SiteNameListingView extends StatefulWidget{
  SiteNameListener listener;
  List<EndCustomerDetailModel> endCustomerDetails;

  SiteNameListingView(this.listener,this.endCustomerDetails);

  @override
  State<StatefulWidget> createState() {
    return SiteNameListingViewState(this.listener,endCustomerDetails);
  }
}

class SiteNameListingViewState extends State<SiteNameListingView> implements OnProcessListener<EndCustomerDetailModel, SiteNameListingItems>,SiteNameListener{
  List<SiteMasterDetailsModel> siteNameModel = [];
  SiteNameListener mListener;
  List<String> mColumnList = [];
  List<String> mFilterList = [];
  List<EndCustomerDetailModel> mEndCustomerDetails;

  SiteNameListingViewState(this.mListener,this.mEndCustomerDetails);

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
  String getSavedDate(EndCustomerDetailModel item) {
    return null;
  }

  @override
  Future<List<EndCustomerDetailModel>> onProcessing(String filter, String filterColumn, bool paging, int currentPage, int limit, String minDate) async{
    return mEndCustomerDetails;
  }

  @override
  void onItemSelect(BuildContext context, EndCustomerDetailModel item) {
    mListener.onItemSelect(context, item);
  }

  @override
  SiteNameListingItems createView(BuildContext context) {
    return SiteNameListingItems(mListener);
  }

}