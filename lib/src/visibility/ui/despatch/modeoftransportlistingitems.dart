import 'package:tvs_visibility/src/visibility/model/getmodeoftransportmodel/getmodeoftransportmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/base/baseinterface.dart';
import 'package:flutter/material.dart';

class ModeOfTransportListingItems extends DataBaseView<GetModeOfTransportModel> {
  ModeOfTransportListener mListener;

  ModeOfTransportListingItems(this.mListener);

  @override
  Widget bind(BuildContext context) {
    return InkWell(
      child: Card(
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: Text(
              '${item?.mModeDescription ?? '-'}',
              style: TextStyle(fontSize: 15.0),
            ),
          )),
      onTap: () {
        mListener.onModeOfTransportItemSelect(context, item);
        Navigator.pop(context);
      },
    );
  }
}

abstract class ModeOfTransportListener {
  void onModeOfTransportItemSelect(BuildContext context, GetModeOfTransportModel item);
}
