import 'package:flutter/material.dart';
import 'package:tvs_visibility/src/visibility/bloc/binningbloc/bininfodetailsbloc.dart';
import 'package:tvs_visibility/src/visibility/model/bininfodetailsmodel/bininfodetailsmodel.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customprogressindicator/customemptyview.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customprogressindicator/customprogress.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customtextfields/customtextfield.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class BinInfoDetailsView extends StatefulWidget {
  String mPartsInOrderId;

  BinInfoDetailsView(this.mPartsInOrderId);

  @override
  _BinInfoDetailsViewState createState() => _BinInfoDetailsViewState(this.mPartsInOrderId);
}

class _BinInfoDetailsViewState extends State<BinInfoDetailsView> {
  String mPartsInOrderId;
  List<BinInfoDetailsModel> mBinInfoDetails=[];
  BinInfoDetailsBloc mBinInfoDetailsBloc;

  _BinInfoDetailsViewState(this.mPartsInOrderId){
    var container = kiwi.Container();
    mBinInfoDetailsBloc = container<BinInfoDetailsBloc>();
  }

  @override
  void initState() {
    getBinInfoDetails();
    super.initState();
  }

  @override
  void dispose() {
    mBinInfoDetailsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(initialData: true,stream: mBinInfoDetailsBloc.isLoad,builder: (BuildContext context,AsyncSnapshot<bool> snapshot){
      if(snapshot.hasData && !snapshot.data){
        return Scaffold(appBar: AppBar(title: Text("Bin Info"),),
          body: mBinInfoDetails.length!=0?ListView.builder(itemCount: mBinInfoDetails.length,itemBuilder: (BuildContext context,int index){
            return Card(margin: EdgeInsets.all(5),child: Column(children: <Widget>[
              CustomTextField(
                title: "LPN",
                subTitle: "${mBinInfoDetails[index].mLPNNo ?? '-'}" ,
              ),
              Row(children: <Widget>[
                Expanded(child: CustomTextField(
                  title: "Quantity",
                  subTitle: "${mBinInfoDetails[index].mQuantity != null && mBinInfoDetails[index].mQuantity !=0 ? mBinInfoDetails[index].mQuantity ?? '-' : "-"}",
                ),),
                Expanded(child: CustomTextField(
                  title: "Bin",
                  subTitle: "${mBinInfoDetails[index].mBinMasterLabel ?? '-' }",
                ),)
              ],),
              CustomTextField(
                title: "Status",
                subTitle: "${mBinInfoDetails[index].mStatus ?? '-'}",
              ),
            ],));
          },):EmptyView(),);
      }else{
        return CustomProgress();
      }
    });
  }


  getBinInfoDetails() async{
    mBinInfoDetails=await mBinInfoDetailsBloc.getBinInfoDetailsModel(mPartsInOrderId);
  }

}
