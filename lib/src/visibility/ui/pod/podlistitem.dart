import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tvs_visibility/src/visibility/model/podmodel/postfiltermodel.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customtextfields/customtextfield.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/base/baseinterface.dart';

class PodListItem extends DataBaseView<GenericDtoList> {
  PodActionListener mPodActionListener;

  PodListItem(this.mPodActionListener);

  @override
  Widget bind(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          mPodActionListener.onPodStatusCheck(item.id,context);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CustomTextField(
              title: 'Vehicle Number',
              subTitle: item.vehNumber ?? '-',
              prefixIcon: Icon(
                Icons.local_shipping,
                size: 25.0,
                color: Colors.teal[500],
              ),
            ),
            CustomTextField(
              title: 'GateIn Number',
              subTitle: item.id ?? '-',
              prefixIcon: Icon(
                Icons.save,
                size: 25.0,
                color: Colors.teal[500],
              ),
            ),
            CustomTextField(
              title: 'Vehicle Status',
              subTitle: item.vehicleStatus ?? '-',
              prefixIcon: Icon(
                Icons.insert_drive_file,
                size: 25.0,
                color: Colors.teal[500],
              ),
            ),
            CustomTextField(
              title: 'GateIn Date',
              subTitle: item.vehicleCreatedDate ?? '-',
              prefixIcon: Icon(
                Icons.date_range,
                size: 25.0,
                color: Colors.teal[500],
              ),
            ),
            CustomTextField(
              title: 'Status Time',
              subTitle: item.vehicleTime ?? '-',
              prefixIcon: Icon(
                Icons.access_time,
                size: 25.0,
                color: Colors.teal[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class PodActionListener{
  void onPodStatusCheck(String vehicleInOut,BuildContext context){}
}
