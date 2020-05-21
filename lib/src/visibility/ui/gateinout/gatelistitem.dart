import 'package:flutter/material.dart';
import 'package:tvs_visibility/src/visibility/model/podmodel/postfiltermodel.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customtextfields/customtextfield.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/base/baseinterface.dart';

class GateListItems extends DataBaseView<GenericDtoList> {
  GateOutListener mGateOutListener;

  GateListItems(this.mGateOutListener,);
  @override
  Widget bind(BuildContext context) {
    return Card(
        child: Column(
          children: <Widget>[
            CustomTextField(
              prefixIcon: Icon(
                Icons.local_shipping,
                size: 25.0,
                color: Colors.teal[500],
              ),
              title: "Vehicle Number",
              subTitle: item.vehNumber ?? '-',
            ),
            CustomTextField(
              prefixIcon: Icon(
                Icons.date_range,
                size: 25.0,
                color: Colors.teal[500],
              ),
              title: "Gate-IN Date",
              subTitle: item.gateInTime ?? '-',
            ),
            CustomTextField(
              prefixIcon: Icon(
                Icons.save,
                size: 25.0,
                color: Colors.teal[500],
              ),
              title: "Gate-IN Number",
              subTitle: item.id ?? '-',
            ),
            CustomTextField(
              prefixIcon: Icon(
                Icons.account_box,
                size: 25.0,
                color: Colors.teal[500],
              ),
              title: "Driver Name",
              subTitle: item.driverName ?? '-',
            ),
            CustomTextField(
              prefixIcon: Icon(
                Icons.phone,
                size: 25.0,
                color: Colors.teal[500],
              ),
              title: "Driver Mobile",
              subTitle: item.phonenumber != null && item.phonenumber != 0
                  ? '${item.phonenumber}'
                  : '-',
            ),

            FlatButton(
              color: item.gateOut
                  ? Colors.lightBlue[900]
                  : Colors.grey[300],
              textColor: Colors.white,
              highlightColor:item.gateOut
                  ? Colors.lightBlue
                  : Colors.black12,
              padding: EdgeInsets.only(left: 110.0, right: 110.0),
              splashColor:item.gateOut
                  ? Colors.blueAccent
                  : Colors.black12,
              onPressed:item.gateOut
                  ? () {mGateOutListener.onGateOut(item.id);}
                  : () {},
              child: Text(
                'Gate Out',
                style: TextStyle(fontSize: 13.0),
              ),
            ),
          ],
        ));
  }
}


class GateOutListener {
  onGateOut(String gateInNumber) {}
}
