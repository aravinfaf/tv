import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:tvs_visibility/src/visibility/utililty/utils.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customalerts/customalerts.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customview/customtoast.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/assetsconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/baseconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/businessconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/utility/utils.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/barcodescanner/barcodescanner.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customprogress.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customtext.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customtextfield.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/bloc/partnumberscandetailsbloc.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/partserialnumberdetailsmodel/partserialnumberdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/postdispatchmasterdetailsmodel/postdispatchmasterdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/postpartmasterdetailsmodel/postpartmasterdetailsmodel.dart';

class PartNumberScanView extends StatefulWidget {
  LinkedHashMap<String, PostPartMasterDetailsModel> mPartNumberMap;
  LinkedHashMap<String, List<PostDispatchMasterDetailsModel>>
  mPartNumberDetailsMap;
  int quantity = 0;

  PartNumberScanView(this.quantity, this.mPartNumberMap,
      this.mPartNumberDetailsMap);

  @override
  State<StatefulWidget> createState() {
    return PartNumberScanViewState(this.quantity, this.mPartNumberMap,
        this.mPartNumberDetailsMap);
  }
}

class PartNumberScanViewState extends State<PartNumberScanView> {
  LinkedHashMap<String, PostPartMasterDetailsModel> mPartNumberMap;
  LinkedHashMap<String, List<PostDispatchMasterDetailsModel>>
  mPartNumberDetailsMap;
  TextEditingController tecNoOfQty = TextEditingController();
  TextEditingController tecLpnNo = TextEditingController();
  int mQuantity = 0;
  int mReqQuantity;

  String mSerialBarcode;
  PartNumberScanDetailBloc mPartNoLocationBloc;
  bool mShowTextMsg = false;
  bool isLpnEnabled = true;
  String mPartNo;

  PartNumberScanViewState(this.mReqQuantity, this.mPartNumberMap,
      this.mPartNumberDetailsMap) {
    var container = kiwi.Container();
    mPartNoLocationBloc = container<PartNumberScanDetailBloc>();
  }

  @override
  void dispose() {
    mPartNoLocationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: false,
      stream: mPartNoLocationBloc.mProgressBar.stream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData && !snapshot.data)
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: appBar(),
            body: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  child: Column(children: <Widget>[
                    textPartNo(),
                    Divider(
                      color: Colors.black12,
                    ),
                    CustomTextField(
                        title: 'LPN  ',
                        hint: "Enter LPN",
                        enable: isLpnEnabled,
                        controller: tecLpnNo,
                        suffixIcon: Icon(
                          Icons.send,
                          color: tecLpnNo.text.length != 0 &&
                              Utils.isEmpty(mPartNo)
                              ? Colors.blue[900]
                              : Colors.grey,
                        ),
                        onChanged: (str) {
                          mPartNoLocationBloc.showProgress(false);
                        },
                        onPressSuffixIcon: () {
                          validateSerialNumber();
                          /*if (Utils.isEmpty(mPartNo) &&
                              tecLpnNo.text.length != 0) validateSerialNumber();*/
                        }),
                    (mShowTextMsg)
                        ? CustomTextField(
                        title: 'Qty',
                        hint: "Enter Qty",
                        inputType: TextInputType.number,
                        controller: tecNoOfQty,
                        suffixIcon: Icon(
                          Icons.send,
                          color: tecNoOfQty.text.length != 0
                              ? Colors.blue[900]
                              : Colors.grey,
                        ),
                        onChanged: (str) {
                          mPartNoLocationBloc.showProgress(false);
                        },
                        onPressSuffixIcon: () {
                          if (!Utils.isEmpty(mPartNo)) {
                            mQuantity = tecNoOfQty.text.length != 0
                                ? int.parse(tecNoOfQty.text)
                                : "0";

                            mReqQuantity = mPartNumberMap[mPartNo]
                                .mQuantity;

                          if(mQuantity > mReqQuantity){
                          CustomAlerts.showAlert(
                          context, "Requested quantity is greater than required");
                          }else{
                          validateSerialNumber();
                          }

                        }
                        })
                        : Container(
                      height: 1,
                    ),
                    new Text(
                      'Open Camera',
                      textAlign: TextAlign.center,
                    ),
                    iconCamera(),
                  ]),
                  margin: EdgeInsets.all(10),
                )
              ],
            ),
          );
        else
          return CustomProgress();
      },
    );
  }

  getPartSerialBarCodeDetails() async {
    String barCode = await BarCodeScanner.barcodeScanning(
      context: context,
    );

    if (barCode == BaseConstants.STR_CANCELLED ||
        barCode == BaseConstants.STR_PERMISSION_NOT_GRANTED ||
        barCode == BaseConstants.STR_RECAPTURE_BARCODE) {
      CustomToast.showToast(barCode);
    } else {
      mQuantity = 0;
      tecLpnNo.clear();
      tecNoOfQty.clear();
      mPartNo = "";
      tecLpnNo.text = barCode;
     await validateSerialNumber();
    }
  }

  validateSerialNumber() async {
    if (await Utility.onCheckNetworkConnection()) {
      PartSerialNumberDetailsModel partSerialNumberDetails =
      PartSerialNumberDetailsModel();
      partSerialNumberDetails = await mPartNoLocationBloc
          .getSerialNumberValidation(tecLpnNo.text, mQuantity);

      if (!partSerialNumberDetails.mError) {
        if (await isSerialAvailableInPartNoMap(
            tecLpnNo.text, mPartNumberDetailsMap) &&
            partSerialNumberDetails.mPartTypeId == "PATM-2") {
          mPartNo=partSerialNumberDetails.mPartNumber;
          CustomAlerts.showAlert(context, "Already scanned this serial number");
        } else if (mPartNumberMap
            .containsKey(partSerialNumberDetails.mPartNumber) &&
            ( ( await getRemainingQtyAvailable(
               partSerialNumberDetails.mPartTypeCode=="V"?mQuantity:1,
                tecLpnNo.text,
                mPartNumberDetailsMap,
                partSerialNumberDetails.mPartNumber,
                partSerialNumberDetails.mPartTypeCode,
                partSerialNumberDetails)) >
                mPartNumberMap[partSerialNumberDetails.mPartNumber].mQuantity)) {
          mPartNo=partSerialNumberDetails.mPartNumber;
          CustomAlerts.showAlert(
              context, "Requested quantity is greater than required");
        } else if (partSerialNumberDetails.mPickQty != null &&
            mQuantity > partSerialNumberDetails.mPickQty) {
          CustomAlerts.showAlert(context,
              "${partSerialNumberDetails
                  .mPartSerialNo} has ${partSerialNumberDetails.mPickQty != 0
                  ? partSerialNumberDetails.mPickQty
                  : 'no'} parts available");
        } else if (partSerialNumberDetails.mPickStatus ==
            BusinessConstants.PICKING_INVALID_SERIAL_NUMBER) {
          CustomAlerts.showAlert(
              context, BusinessConstants.STR_PICKING_INVALID_SERIAL_NUMBER);
        } else if (partSerialNumberDetails.mPickStatus ==
            BusinessConstants.PICKING_REQUESTED_QUANTITY_NOT_AVAILABLE) {
          CustomAlerts.showAlert(context,
              BusinessConstants.STR_PICKING_REQUESTED_QUANTITY_NOT_AVAILABLE);
        } else if (partSerialNumberDetails.mPartTypeCode=="V" && mQuantity==0) {
          validateWithPartNumber(partSerialNumberDetails);
        } else {
          Navigator.pop(context, {
            "partserialnumberdetails": partSerialNumberDetails,
            "serialNumber": tecLpnNo.text,
            "quantity": mQuantity,
            "partType": partSerialNumberDetails.mPartTypeCode
          });
        }
        mPartNoLocationBloc.showProgress(false);
      }
    } else {
      CustomToast.showToast(BaseConstants.STR_NO_INTERNET);
    }
  }

  getRemainingQtyAvailable(int currentQty,
      String mSerialNumber,
      LinkedHashMap<String, List<PostDispatchMasterDetailsModel>> map,
      String partNumber,
      String partType,
      PartSerialNumberDetailsModel model) {
    int totQty = 0;
    if (!Utility.isEmpty(partType) && model.mPartNumber != null) {
      if (map.containsKey(partNumber)) {
        map[partNumber].forEach((m) {
          totQty = totQty + m.mPickQty;
        });
      }
      totQty = totQty + currentQty;
    } else {
      totQty = 0;
    }
    return totQty;
  }

  isSerialAvailableInPartNoMap(String serialNo,
      LinkedHashMap<String, List<PostDispatchMasterDetailsModel>> map) {
    bool isExist = false;
    map.values.forEach((v) {
      for (PostDispatchMasterDetailsModel list in v) {
        if (list.mPartSerialNo == serialNo) isExist = true;
      }
    });
    return isExist;
  }

  validateWithPartNumber(PartSerialNumberDetailsModel model) {
    if (mPartNumberMap[model.mPartNumber] != null) {
      mShowTextMsg = true;
      isLpnEnabled = false;
      mPartNo = model.mPartNumber;
    } else {
      CustomAlerts.showAlert(context, "Invalid part scanned");
    }
  }

  Widget iconCamera() {
    return GestureDetector(
      onTap: () {
        getPartSerialBarCodeDetails();
      },
      child: Image(image: AssetImage(BaseConstants.IMAGES_CAMERA)),
    );
  }

  Widget textPartNo() {
    return Row(
      children: <Widget>[
        SizedBox(height: 40.0, width: 15.0),
        CustomText(
          text: 'Part No: ',
          fontSize: 20,
          fontStyle: FontStyle.normal,
          fontFamily: AssetsConstants.OPEN_SANS_LIGHT,
          textColor: Colors.grey,
        ),
        CustomText(
          text: mPartNo ?? "-",
          fontSize: 20,
          fontStyle: FontStyle.normal,
          fontFamily: AssetsConstants.OPEN_SANS_BOLD,
          fontWeight: FontWeight.bold,
          textColor: Colors.green,
        )
      ],
    );
  }

  appBar() {
    return PreferredSize(
        child: AppBar(
          title: Text("Dealer Picking"),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        preferredSize: Size.fromHeight(60));
  }
}
