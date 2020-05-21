import 'package:flutter/material.dart';
import 'package:tvs_visibility/src/visibility/constants/businessconstants.dart';
import 'package:tvs_visibility/src/visibility/model/binninglistmodel/binninglistmodel.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customtextfields/customtextfield.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/base/baseinterface.dart';


class BinListItem extends DataBaseView<BinningListModel> {
  BinningActionListener mListener;

  BinListItem(this.mListener);

  @override
  Widget bind(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          CustomTextField(
            title: 'Customer Ref Number',
            subTitle: (item.mActorTypeId == BusinessConstants.Actor_Type_Id_Dealer)?item.mInvoiceNumber+' (HUS)':item.mInvoiceNumber ?? '-',
          ),
          CustomTextField(
            title: 'Visibility Order Id',
            subTitle: item.mOrderSerialNo ?? '-',
          ),
          CustomTextField(
            title: 'Part No',
            subTitle: item.mPartNumber ?? '-',
          ),
          Row(children: <Widget>[
            CustomTextField(
              title: 'Balance / Received qty',
              subTitle:
              '${item.mBalanceToBin ?? 0}/' + '${item.mQuantity}' ?? '0',
            ),
            CustomTextField(
              title: 'Stock Type',
              subTitle: item.mStockTypeCode ?? '-',
            ),
          ],),
          GestureDetector(child: Center(child: Container(margin: EdgeInsets.all(10),child: Text("INFO",style: TextStyle(fontSize: 16,color: Colors.blue),),),),onTap: (){
              mListener.onBinningInfo(item.mPartsInOrderId,context);
          },)
        ],
      ),
    );
  }
}

class BinningActionListener{
  void onBinningInfo(String partsInOrderId,BuildContext context){}
}

