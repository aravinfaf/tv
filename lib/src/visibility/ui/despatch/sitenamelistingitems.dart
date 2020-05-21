import 'package:tvs_visibility/src/visibility/model/endcustomerdetailmodel/endcustomerdetailmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/base/baseinterface.dart';
import 'package:flutter/material.dart';

class SiteNameListingItems extends DataBaseView<EndCustomerDetailModel> {
  SiteNameListener mListener;

  SiteNameListingItems(this.mListener);

  @override
  Widget bind(BuildContext context) {
    return InkWell(
      child: Card(
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: Text(
              '${item?.mId ?? '-'}',
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

abstract class SiteNameListener {
  void onItemSelect(BuildContext context, EndCustomerDetailModel item);
}
