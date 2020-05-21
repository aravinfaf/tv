import 'package:tvs_visibility/src/visibilitydealer/helper/base/baseinterface.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/partnumberdetailsmodel/partnumberdetailsmodel.dart';
import 'package:flutter/material.dart';

class SerialNumberListingItems extends DataBaseView<PartNumberDetailsModel> {
  SerialNumberListener mListener;

  SerialNumberListingItems(this.mListener);

  @override
  Widget bind(BuildContext context) {
    return InkWell(
      child: Card(
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: Text(
              '${item?.mPartNumber ?? '-'}',
              style: TextStyle(fontSize: 15.0),
            ),
          )),
      onTap: () {
        mListener.onItemSelect(context, item);
        Navigator.pop(context);
      },
    );
  }
}

abstract class SerialNumberListener {
  void onItemSelect(BuildContext context, PartNumberDetailsModel item);
}
