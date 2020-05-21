import 'package:tvs_visibility/src/visibilitydealer/helper/base/baseinterface.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customlistwidget/customlistandsearch.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/bloc/partnumberdetailsbloc.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/partnumberdetailsmodel/partnumberdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/ui/partnumberdetailsview/serialnumberlistingitems.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class SerialNumberListingView extends StatefulWidget{
  SerialNumberListener listener;

  SerialNumberListingView(this.listener);

  @override
  State<StatefulWidget> createState() {
    return SerialNumberListingViewState(this.listener);
  }
}

class SerialNumberListingViewState extends State<SerialNumberListingView> implements OnProcessListener<PartNumberDetailsModel, SerialNumberListingItems>,SerialNumberListener{
  PartNumberDetailsBloc mPostDespatchDetailsBloc;
  List<PartNumberDetailsModel> mPartSerialList = [];
  SerialNumberListener mListener;
  List<String> mColumnList = [];
  List<String> mFilterList = [];

  SerialNumberListingViewState(this.mListener){
    var container = kiwi.Container();
    mPostDespatchDetailsBloc = container<PartNumberDetailsBloc>();
  }

  @override
  void initState() {
    mColumnList.add("");
    mFilterList.add("part number");
    super.initState();
  }

  @override
  void dispose() {
    mPostDespatchDetailsBloc.dispose();
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
  SerialNumberListingItems createView(BuildContext context) {
    return SerialNumberListingItems(mListener);
  }

  @override
  String getSavedDate(PartNumberDetailsModel item) {
    return null;
  }

  @override
  Future<List<PartNumberDetailsModel>> onProcessing(String filter, String filterColumn, bool paging, int currentPage, int limit, String minDate) async{
      mPartSerialList = await mPostDespatchDetailsBloc.searchPart(filter,currentPage,limit);
    return mPartSerialList;
  }

  @override
  void onItemSelect(BuildContext context, PartNumberDetailsModel item) {
  }

}