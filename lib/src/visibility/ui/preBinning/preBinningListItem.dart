

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tvs_visibility/src/visibility/model/preBinning/preBinningModel.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customtextfields/customtextfield.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/base/baseinterface.dart';

class PreBinningListItem extends DataBaseView<PreBinningModel> {

  PreBinningListItem();

  @override
  Widget bind(BuildContext context) {
    // TODO: implement bind
    return Card(
      child:  Column(
          children: <Widget>[
            CustomTextField(
              title: 'Customer Ref No',
              subTitle: item.custRef ?? '-',
            ),
            CustomTextField(
              title: 'Visibility Order ID',
              subTitle: item.orderId ?? '-',
            ),
            CustomTextField(
              title: 'Serial No',
              subTitle: item.serialNumber ?? '-',
            ),
            CustomTextField(
              title: 'Part No',
              subTitle: item.partsNumber ?? '-',
            ),
            CustomTextField(
              title: 'Part Type',
              subTitle: item.partTypeMasterId ?? '-',
            ),
            CustomTextField(
              title: 'PO Date',
              subTitle: item.poCreatedDate ?? '-',
            ),
          ],
        ),
    );
  }
}
