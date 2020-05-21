import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:tvs_visibility/src/visibility/bloc/preBinning/preBinningBloc.dart';
import 'package:tvs_visibility/src/visibility/model/preBinning/preBinningModel.dart';
import 'package:tvs_visibility/src/visibility/ui/homeview.dart';
import 'package:tvs_visibility/src/visibility/ui/preBinning/preBinningListItem.dart';
import 'package:tvs_visibility/src/visibility/ui/preBinning/preBinningScanView.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/navigaton/navigationutils.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/base/baseinterface.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customraisedbutton.dart';

import '../../../visibilitydealer/helper/widgets/customlistwidget/customlistandsearch.dart';

class PreBinningListView extends StatefulWidget {
  @override
  PreBinningListViewState createState() => PreBinningListViewState();
}

class PreBinningListViewState extends State<PreBinningListView>
    implements
        OnProcessListener<PreBinningModel, PreBinningListItem>{
  PreBinningBloc mPreBinningBloc;
  List<String> mFilterColumnList = [];
  List<String> mFilterList = [];

  PreBinningListViewState() {
    var container = kiwi.Container();
    mPreBinningBloc = container<PreBinningBloc>();
  }

  @override
  void initState() {
    mFilterColumnList.add("cusRef");
    mFilterColumnList.add("serialNo");
    mFilterList.add("Customer Ref No");
    mFilterList.add("Serial No");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
              resizeToAvoidBottomInset: false,
              body: CustomListAndSearch<PreBinningModel>(
                onProcessListener: this,
                mFilterColumnList: mFilterColumnList,
                mFilterList: mFilterList,
              ), bottomNavigationBar:
                Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                  Expanded(child: CustomRaisedButton(onPress: (){
                    navigateToScan();
                  },text: "Scan",buttonColor: Colors.blue,)),
                ],)
            );
  }

  @override
  PreBinningListItem createView(BuildContext context) {
    return PreBinningListItem();
  }

  @override
  String getSavedDate(PreBinningModel item) {
    return null;
  }

  @override
  Future<List<PreBinningModel>> onProcessing(String filter, String filterColumn,
      bool paging, int currentPage, int limit, String minDate) {
    return mPreBinningBloc.onProcess(
        filter, filterColumn, paging, currentPage, limit, minDate);
  }

  navigateToScan() async {
    final result = await Navigator.push(
      context,
      PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) {
            return PreBinningScanView();
          }),
    );

    if (result == "Success") {
      NavigationUtils.pushReplacement(context, HomeView());
    }
  }
}
