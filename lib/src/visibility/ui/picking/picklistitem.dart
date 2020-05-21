import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tvs_visibility/src/visibility/constants/businessconstants.dart';
import 'package:tvs_visibility/src/visibility/model/picking/pickingmodel.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customtextfields/customtextfield.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/base/baseinterface.dart';

class PickListItem extends DataBaseView<PickingLocationModel> {
  PickScanListener mListener;

  PickListItem(this.mListener);

  @override
  Widget bind(context) {
    return Card(
      color: pickAllowStatus()
          ? Colors.white
          : Colors.orange[100],
      child: Column(
        children: <Widget>[
          CustomTextField(
            title: "Customer Ref Number",
            subTitle: (item.actorId == BusinessConstants.Actor_Type_Id_Dealer)?item.refNo+' (HUS)':item.refNo ?? '-',
            prefixIcon:
                Icon(Icons.contact_mail, size: 25.0, color: Colors.teal[500]),
          ),
          CustomTextField(
            title: "Visibility Order ID",
            subTitle: item.orderId ?? '-',
            prefixIcon: Icon(Icons.insert_drive_file,
                size: 25.0, color: Colors.teal[500]),
          ),
          CustomTextField(
            title: "Part no",
            subTitle: item.partNumber ?? '-',
            prefixIcon:
                Icon(Icons.assignment, size: 25.0, color: Colors.teal[500]),
          ),
          CustomTextField(
            title: 'Part Type',
            subTitle: (item.vPart==true? 'V': 'NV')?? '-',
              prefixIcon:
              Icon(Icons.merge_type, size: 25.0, color: Colors.teal[500]),
          ),
          CustomTextField(
            title: "Remaining/Requested Qty",
            subTitle: '${item.requestedQuantity - item.packedQuantity}' +
                '/${item.requestedQuantity}'?? '-',
            prefixIcon:
                Icon(Icons.local_offer, size: 25.0, color: Colors.teal[500]),
          ),
          CustomTextField(
            title: "Location",
            subTitle: item.pickLocation ?? '-',
            prefixIcon:
                Icon(Icons.location_on, size: 25.0, color: Colors.teal[500]),
          ),
          CustomTextField(
            title: "Stock Type",
            subTitle: item.stockType ?? '-',
            prefixIcon: Icon(Icons.flag, size: 25.0, color: Colors.teal[500]),
          ),
          CustomTextField(
            title: 'SO Date',
            subTitle: item.pickCreatedDate ?? '-',
            prefixIcon: Icon(
              Icons.date_range,
              size: 25.0,
              color: Colors.teal[500],
            ),
          ),
          FlatButton(
            color: pickAllowStatus()
                ? Colors.lightBlue[900]
                : Colors.grey[300],
            textColor: Colors.white,
            highlightColor:
            pickAllowStatus()
                    ? Colors.lightBlue
                    : Colors.black12,
            padding: EdgeInsets.only(left: 110.0, right: 110.0),
            splashColor:
            pickAllowStatus()
                    ? Colors.blueAccent
                    : Colors.black12,
            onPressed:
            pickAllowStatus()
                    ? () {
                  mListener.onPickingScan(item,context);
                      }
                    : () {},
            child: Text(
              'SCAN PART',
              style: TextStyle(fontSize: 13.0),
            ),
          ),
        ],
      ),
    );
  }

  bool pickAllowStatus(){
    return (item.randomPickStatus == 0 || item.randomPickStatus == 2||item.actorId == BusinessConstants.Actor_Type_Id_Dealer)?true:false;
  }

}

class PickScanListener {
  void onPickingScan(PickingLocationModel model, BuildContext context) {}
}
