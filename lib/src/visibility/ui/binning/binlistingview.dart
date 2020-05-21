import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:tvs_visibility/src/visibility/bloc/binningbloc/binlistbloc.dart';
import 'package:tvs_visibility/src/visibility/model/binninglistmodel/binninglistmodel.dart';
import 'package:tvs_visibility/src/visibility/ui/binning/bininfodetailsview.dart';
import 'package:tvs_visibility/src/visibility/ui/binning/binlistitem.dart';
import 'package:tvs_visibility/src/visibility/ui/binning/binscanview.dart';
import 'package:tvs_visibility/src/visibility/ui/homeview.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customprogressindicator/customprogress.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customprogressindicator/customretry.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/base/baseinterface.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customlistwidget/customlistandsearch.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customraisedbutton.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/navigaton/navigationutils.dart';

class BinListingView extends StatefulWidget {
  BinListingViewState mBinListingViewState;

  BinListingView();

  @override
  BinListingViewState createState() {
    mBinListingViewState=BinListingViewState();
    return mBinListingViewState;
  }
}

class BinListingViewState extends State<BinListingView>
    implements OnProcessListener<BinningListModel, BinListItem>,BinningActionListener{
  BinListBloc mListBloc;
  Function mOnRetry;
  List<String> mColumnList = [];
  List<String> bTextList = [];
  bool isRecordAvailable=false;

  BinListingViewState() {
    var container = kiwi.Container();
    mListBloc = container<BinListBloc>();
  }

  @override
  void initState() {
    mColumnList.clear();
    bTextList.clear();

    mColumnList.add('InvoiceNumber');
    mColumnList.add('partnumber');
    bTextList.add('Customer Ref Number');
    bTextList.add('Part Number');

    super.initState();
  }

  @override
  void dispose() {
    mListBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(initialData: false,stream: mListBloc.isLoading,builder: (context,AsyncSnapshot<bool> snapshot){
      if(snapshot.hasData && !snapshot.data){
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: CustomListAndSearch(
            onProcessListener: this,
            mFilterColumnList: mColumnList,
            mFilterList: bTextList,
          ),
          bottomNavigationBar: isRecordAvailable?
          Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
            Expanded(child: CustomRaisedButton(onPress: (){
              var data = NavigationUtils.push(context, BinScanView());
              data.whenComplete(() {
                NavigationUtils.pushAndRemoveUntil(context, navigateToHomeView());
              });
            },text: "Scan",buttonColor: Colors.blue,)),
          ],):Container(height: 0,),
        );
      }else if(snapshot.hasError){
        return Scaffold(backgroundColor: Colors.white,body: CustomRetry(retry: mOnRetry,isTitleRequired: false,),);
      }else{
        return CustomProgress(isTitleRequired: false,);
      }
    });
  }

  @override
  BinListItem createView(BuildContext context) {
    return BinListItem(widget.mBinListingViewState);
  }

  @override
  String getSavedDate(BinningListModel item) {
    return null;
  }

  @override
  Future<List<BinningListModel>> onProcessing(String filter, String filterColumn, bool paging, int currentPage, int limit, String minDate) async{
    List<BinningListModel> binningListModel=[];
    binningListModel= await mListBloc.onProcess(filter, filterColumn, paging, currentPage, limit, minDate);
    isRecordAvailable=binningListModel.length>0?true:false;
    mListBloc.showProgress(false);
    return binningListModel;
  }

  navigateToHomeView() {
    return HomeView();
  }

  @override
  void onBinningInfo(String partsInOrderId,BuildContext context) {
   var data = NavigationUtils.push(this.context, BinInfoDetailsView(partsInOrderId));
    data.whenComplete(() {
      NavigationUtils.pushAndRemoveUntil(this.context, navigateToHomeView());
    });
  }

}
