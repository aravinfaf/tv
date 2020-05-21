import 'package:tvs_visibility/src/visibility/ui/homeview.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/bloc/orderdetailslistingbloc.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/model/ordermastermodel/ordermastermodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/model/postfilterdetailsmodel/postfilterdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/ui/binScanning/binScanningView.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/ui/orderdetailslisting/orderlistingitems.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/ui/postbindetails/postbindetailsview.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/base/baseinterface.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/baseconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/utility/utils.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customlistwidget/customlistandsearch.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customraisedbutton.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/navigaton/navigationutils.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/toast/customtoast.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class OrderDetailsListingView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return OrderDetailsListingViewState();
  }
}

class OrderDetailsListingViewState extends State<OrderDetailsListingView> implements OnProcessListener<OrderMasterModel, OrderDetailsListingItems>{
  List<String> mColumnList = [];
  List<String> mFilterList = [];
  OrderDetailsListingBloc mOrderDetailsListingBloc;
  List<OrderMasterModel> mOrderDetailsList = [];

  bool isRecordAvailable = false;


  OrderDetailsListingViewState(){
    var container = kiwi.Container();
    mOrderDetailsListingBloc = container<OrderDetailsListingBloc>();
  }

  @override
  void initState() {
    mFilterList.add("Customer Reference No");
    mFilterList.add("Part Number");
    mColumnList.add("customerReference");
    mColumnList.add("partNumber");
    super.initState();
  }

  @override
  void dispose() {
    mOrderDetailsListingBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body: CustomListAndSearch(
      onProcessListener: this,
      mFilterColumnList: mColumnList,
      mFilterList: mFilterList,
    ), bottomNavigationBar:  isRecordAvailable ?   Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
        Expanded(child: CustomRaisedButton(onPress: navigateToBinScanView, text: "Scan",buttonColor: Colors.blue,)),
      ],):Container(height: 0,),);
  }

  @override
  OrderDetailsListingItems createView(BuildContext context) {
    return OrderDetailsListingItems();
  }

  @override
  String getSavedDate(OrderMasterModel item) {
    return null;
  }

  @override
  Future<List<OrderMasterModel>> onProcessing(String filter, String filterColumn, bool paging, int currentPage, int limit, String minDate) async{
    PostFilterDetailsModel postFilterModel=PostFilterDetailsModel();
    postFilterModel.mSearchText=filter;
    postFilterModel.mSearchColumn=filterColumn;
    postFilterModel.mSearch=true;
    postFilterModel.mPageNumber=currentPage.toString();
    postFilterModel.mPageSize=limit.toString();
    if(await Utility.onCheckNetworkConnection()) {
      mOrderDetailsList =
      await mOrderDetailsListingBloc.getOrderDetails(postFilterModel);
      if (currentPage == 0) {
        isRecordAvailable = mOrderDetailsList != null && mOrderDetailsList.length > 0;
      }
    }else {
      mOrderDetailsList=[];
      if (currentPage == 0)
        isRecordAvailable = false;
      CustomToast.showToast(BaseConstants.STR_NO_INTERNET);
    }
    setState(() {});
    return mOrderDetailsList;
  }

  void navigateToBinScanView() async {

    var result = await  NavigationUtils.push(context, BinScanningView());
    if (result == "Success") {
      NavigationUtils.pushAndRemoveUntil(context, navigateToHomeView());
    }

  }

  navigateToHomeView() {
    return HomeView();
  }

}