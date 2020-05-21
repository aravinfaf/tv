import 'package:flutter/material.dart';
import 'package:tvs_visibility/src/visibility/model/despatchlistmodel/dispatchdetailsmodel.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customtextfields/customtextfield.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/base/baseinterface.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/utility/utils.dart';

class DispatchListItem extends DataBaseView<DispatchListDTO> {
  DispatchActionListener mListener;

  DispatchListItem(this.mListener);

  @override
  Widget bind(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5.0),
        alignment: Alignment.topCenter,
        child: Card(
            child: Container(
              margin: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  CustomTextField(
                    title: 'SO Number',
                    subTitle: convertSONoListToString(item.mCustRef),
                    prefixIcon: Icon(
                      Icons.collections_bookmark,
                      size: 25.0,
                      color: Colors.teal[500],
                    ),
                  ),
                  CustomTextField(
                    title: 'Visibility Order ID',
                    subTitle: convertOrderMasterListToString(item.mOrderMasterIdList),
                    prefixIcon: Icon(
                      Icons.insert_drive_file,
                      size: 25.0,
                      color: Colors.teal[500],
                    ),
                  ),
                  CustomTextField(
                    title: 'Order Serial Nos',
                    subTitle: convertOrderSerialNoListToString(item.mOrderSerialNos),
                    prefixIcon: Icon(
                      Icons.collections_bookmark,
                      size: 25.0,
                      color: Colors.teal[500],
                    ),
                  ),
                  CustomTextField(
                    title: 'Customer Name',
                    subTitle: convertCustomerNameListToString(item.mDispatchDetailsWrapperDTO),
                    prefixIcon: Icon(
                      Icons.assignment,
                      size: 25.0,
                      color: Colors.teal[500],
                    ),
                  ),
                  CustomTextField(
                    title: 'Service Type',
                    subTitle: !Utility.isEmpty(item.mServiceType)?item.mServiceType:"-",
                    prefixIcon: Icon(
                      Icons.merge_type,
                      size: 25.0,
                      color: Colors.teal[500],
                    ),
                  ),
                  CustomTextField(
                    title: 'Destination',
                    subTitle: !Utility.isEmpty(item.mDestination)?item.mDestination:"-",
                    prefixIcon: Icon(
                      Icons.bookmark,
                      size: 25.0,
                      color: Colors.teal[500],
                    ),
                  ),
                  new Divider(),
                  FlatButton(
                    onPressed: () {
                      mListener.onDispatchAction(item.mConsolidationId, item);
                    },
                    child: Text(
                      'Dispatch',
                      style: TextStyle(fontSize: 13.0),
                    ),
                    color: Colors.lightBlue[900],
                    textColor: Colors.white,
                    highlightColor: Colors.lightBlue,
                    splashColor: Colors.blueAccent,
                    padding: EdgeInsets.only(left: 110.0, right: 110.0),
                  )
                ],
              ),
            )));
  }

  convertSONoListToString(List<String> model){
    var concatenate = StringBuffer();
    if(model!=null) {
      if (model.length > 1) {
        concatenate.write(model.join('/'));
      } else {
        concatenate.write(model.first);
      }
    }
    else
      concatenate.write('-');
    return concatenate.toString();
  }

  convertOrderMasterListToString(List<String> model){
    var concatenate = StringBuffer();
    if(model!=null) {
      if (model.length > 1) {
        concatenate.write(model.join('/'));
      } else {
        concatenate.write(model.first);
      }
    }
    else
      concatenate.write('-');
    return concatenate.toString();
  }

  convertCustomerNameListToString(List<DispatchDetailsWrapperDTO> model){
    String item;
    if(model!=null) {
      for (int i = 0; i < model.length; i++) {
          if (i == model.length - 1)
            item = model[i].mCustomerName;
          else
            item = model[i].mCustomerName + ",";
        }
    }
    else
      item = "-";
    return item;
  }

  convertOrderSerialNoListToString(List<String> model){
    var concatenate = StringBuffer();
    if(model!=null) {
      if (model.length > 1) {
        concatenate.write(model.join('/'));
      } else {
        concatenate.write(model.first);
      }
    }
    else
      concatenate.write('-');
    return concatenate.toString();
  }

}

class DispatchActionListener {
  onDispatchAction(String consolidationId, DispatchListDTO model) {}
}
