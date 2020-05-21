import 'package:tvs_visibility/src/visibilitydealer/binning/model/ordermastermodel/ordermastermodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/base/baseinterface.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customtextview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class OrderDetailsListingItems extends DataBaseView<OrderMasterModel> {

  TextEditingController textEditingController = TextEditingController();

  OrderDetailsListingItems();

  @override
  Widget bind(BuildContext context) {
    return Card(
          child: Container(
              margin: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  tffOrderNumber(),
                  SizedBox(
                    height: 10,
                  ),
                  tffPartNumber(),
                  SizedBox(
                    height: 10,
                  ),
                  tffOrderedQty(),
                ],
              )));
  }

  tffOrderNumber() {
    return CustomTextView(
      text: '${item.mCustomerRef ?? '-'}',
      title: 'Customer Reference No',
    );
  }

  tffPartNumber() {
    return CustomTextView(
      text: '${item.mPartNumber ?? '-'}',
      title: 'Part Number',
    );
  }

  tffOrderedQty() {
    return CustomTextView(
      text:
          '${item.mTotalBinnedQuantity ?? "-"}/${item.mTotalOrderQuantity ?? '-'}',
      title: 'Quantity',
    );
  }
}

