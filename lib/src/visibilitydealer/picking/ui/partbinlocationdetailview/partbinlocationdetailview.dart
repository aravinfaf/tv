import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/baseconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/businessconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/utility/utils.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/CustomRetry.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/barcodescanner/barcodescanner.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customalerts/customalert.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customprogress.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customraisedbutton.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customtextformfield.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customtextview.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/navigaton/navigationutils.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/toast/customtoast.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/bloc/partnolocationbloc.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/partserialnumberdetailsmodel/partserialnumberdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/postdispatchmasterdetailsmodel/postdispatchmasterdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/postpartmasterdetailsmodel/postpartmasterdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/ui/partnumberscandetailsview/partnumberscandetailsview.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/ui/partnumberscandetailsview/partnumberscanview.dart';

class PartBinLocationDetailView extends StatefulWidget {
  List<PostPartMasterDetailsModel> partMasterDetailsList = [];
  LinkedHashMap<String, PostPartMasterDetailsModel> mPartNumberMap =
      LinkedHashMap();

  PartBinLocationDetailView(this.partMasterDetailsList, this.mPartNumberMap);

  @override
  State<StatefulWidget> createState() {
    return PartBinLocationDetailViewState(
        this.partMasterDetailsList, this.mPartNumberMap);
  }
}

class PartBinLocationDetailViewState extends State<PartBinLocationDetailView> {
  LinkedHashMap<String, PostPartMasterDetailsModel> mPartNumberMap =
      LinkedHashMap();
  final qtyFormKey = new GlobalKey<FormState>();
  List<PostPartMasterDetailsModel> mPartMasterDetailsList = [];
  PartNoLocationBloc mPartNoLocationBloc;
  TextEditingController tecQuantity;
  String mSerialBarcode;
  int mQuantity = 0;

  PartBinLocationDetailViewState(
      this.mPartMasterDetailsList, this.mPartNumberMap) {
    var container = kiwi.Container();
    mPartNoLocationBloc = container<PartNoLocationBloc>();
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
        stream: mPartNoLocationBloc.isLoad,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && !snapshot.data) {
            return Scaffold(
              appBar: appBar("Dealer Picking"),
              body: ListView.builder(
                  itemCount: this.mPartMasterDetailsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    List<Widget> widget = [];
                    widget.add(
                      CustomTextView(
                        text:
                            '${this.mPartMasterDetailsList[index].mPartMaster ?? '-'}',
                        title: 'Part Number',
                      ),
                    );
                    widget.add(Divider(
                      color: Colors.white,
                      height: 5,
                    ));
                    this
                        .mPartMasterDetailsList[index]
                        .mBinMasterDetailList
                        .forEach((v) {
                      if (v != null) {
                        widget.add(Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CustomTextView(
                                text: '${v.mBinLocation ?? '-'}',
                                title: 'Bin Location',
                              ),
                              CustomTextView(
                                text: '${v.mQuantity ?? '-'}',
                                title: 'Available Quantity',
                              ),
                            ],
                          ),
                        ));
                        widget.add(Divider(
                          color: Colors.white,
                          height: 5,
                        ));
                      }
                    });
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(children: widget),
                      ),
                    );
                  }),
              bottomNavigationBar: rbScan(),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: CustomRetry(
                retry: validateSerialNumber,
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.white,
              body: CustomProgress(),
            );
          }
        });
  }

  appBar(String data) {
    return PreferredSize(
        child: AppBar(
          title: Text(
            '$data',
            style: TextStyle(fontSize: 18.0),
          ),
          backgroundColor: Colors.blue,
        ),
        preferredSize: Size.fromHeight(60));
  }

  Widget rbScan() {
    return CustomRaisedButton(
      text: 'Scan',
      buttonColor: Colors.blue,
      textColor: Colors.white,
      onPress: () {
        getScanDetails();
      },
    );
  }

  getScanDetails() async {
    LinkedHashMap<String, List<PostDispatchMasterDetailsModel>>
        partMasterDetailsMap = LinkedHashMap();
    Map scanDetails = await NavigationUtils.push(
        context,
        PartNumberScanView(mQuantity, mPartNumberMap, partMasterDetailsMap));

    if (scanDetails != null &&
        scanDetails.containsKey("partserialnumberdetails")) {
      PartSerialNumberDetailsModel partSerialNumberDetails =
          PartSerialNumberDetailsModel();
      partSerialNumberDetails = scanDetails["partserialnumberdetails"];
      mSerialBarcode = scanDetails["serialNumber"];
      int quantity = scanDetails["quantity"];

      if (mPartNumberMap.containsKey(partSerialNumberDetails.mPartNumber))
      mPartNumberMap[partSerialNumberDetails.mPartNumber].mPartTypeMaster = scanDetails["partType"];

      if (mPartNumberMap.containsKey(partSerialNumberDetails.mPartNumber) &&
          mQuantity >
              mPartNumberMap[partSerialNumberDetails.mPartNumber].mQuantity) {
        CustomAlerts.showAlert(
            context, "Requested quantity is greater than required");
      } else if (partSerialNumberDetails.mPickQty != null &&
          mQuantity > partSerialNumberDetails.mPickQty) {
        CustomAlerts.showAlert(context,
            "${partSerialNumberDetails.mPartSerialNo} has ${partSerialNumberDetails.mPickQty != 0 ? partSerialNumberDetails.mPickQty : 'no'} parts available");
      } else if (partSerialNumberDetails.mPickStatus ==
          BusinessConstants.PICKING_INVALID_SERIAL_NUMBER) {
        CustomAlerts.showAlert(
            context, BusinessConstants.STR_PICKING_INVALID_SERIAL_NUMBER);
      } else if (partSerialNumberDetails.mPickStatus ==
          BusinessConstants.PICKING_REQUESTED_QUANTITY_NOT_AVAILABLE) {
        CustomAlerts.showAlert(context,
            BusinessConstants.STR_PICKING_REQUESTED_QUANTITY_NOT_AVAILABLE);
      } else {
        partMasterDetailsMap
          ..putIfAbsent(partSerialNumberDetails.mPartNumber, () {
            return []..add(PostDispatchMasterDetailsModel(
                mReqQty: mPartNumberMap[partSerialNumberDetails.mPartNumber]
                    .mQuantity,
                mPartSerialNo: mSerialBarcode,
                mPartMasterId: partSerialNumberDetails.mPartMasterId,
                mPartNumber: partSerialNumberDetails.mPartNumber,
                mBinLabel: partSerialNumberDetails.mBinLabel,
                mPickQty: partSerialNumberDetails.mPartTypeCode=="V"?quantity:1));
          });

        NavigationUtils.push(
            context,
            PartNumberScanDetailsView(
                mPartNumberMap,
                partMasterDetailsMap,
                partSerialNumberDetails.mPartNumber,
                mSerialBarcode,
                mPartNumberMap[partSerialNumberDetails.mPartNumber]
                    .mQuantity
                    .toString()));
      }
    }
  }

  getPartSerialBarCodeDetails() async {
    mSerialBarcode = "";
    mQuantity = 0;
    mSerialBarcode = await BarCodeScanner.barcodeScanning(
      context: context,
    );

    if (mSerialBarcode == BaseConstants.STR_CANCELLED ||
        mSerialBarcode == BaseConstants.STR_PERMISSION_NOT_GRANTED ||
        mSerialBarcode == BaseConstants.STR_RECAPTURE_BARCODE) {
      CustomToast.showToast(mSerialBarcode);
    } else {
      validateSerialNumber();
    }
  }

  validateSerialNumber() async {
    if (await Utility.onCheckNetworkConnection()) {
      PartSerialNumberDetailsModel partSerialNumberDetails =
          PartSerialNumberDetailsModel();
      partSerialNumberDetails = await mPartNoLocationBloc
          .getSerialNumberValidation(mSerialBarcode, mQuantity);
      if (!partSerialNumberDetails.mError) {
        if (mPartNumberMap.containsKey(partSerialNumberDetails.mPartNumber) &&
            mQuantity >
                mPartNumberMap[partSerialNumberDetails.mPartNumber].mQuantity) {
          CustomAlerts.showAlert(
              context, "Requested quantity is greater than required");
        } else if (partSerialNumberDetails.mPickQty != null &&
            mQuantity > partSerialNumberDetails.mPickQty) {
          CustomAlerts.showAlert(context,
              "${partSerialNumberDetails.mPartSerialNo} has ${partSerialNumberDetails.mPickQty != 0 ? partSerialNumberDetails.mPickQty : 'no'} parts available");
        } else if (partSerialNumberDetails.mPickStatus ==
            BusinessConstants.PICKING_INVALID_SERIAL_NUMBER) {
          CustomAlerts.showAlert(
              context, BusinessConstants.STR_PICKING_INVALID_SERIAL_NUMBER);
        } else if (partSerialNumberDetails.mPickStatus ==
            BusinessConstants.PICKING_REQUESTED_QUANTITY_NOT_AVAILABLE) {
          CustomAlerts.showAlert(context,
              BusinessConstants.STR_PICKING_REQUESTED_QUANTITY_NOT_AVAILABLE);
        } else if (mQuantity == 0) {
          validateWithPartNumber(partSerialNumberDetails);
        } else {
          LinkedHashMap<String, List<PostDispatchMasterDetailsModel>>
              partMasterDetailsMap = LinkedHashMap();
          partMasterDetailsMap
            ..putIfAbsent(partSerialNumberDetails.mPartNumber, () {
              return []..add(PostDispatchMasterDetailsModel(
                  mReqQty: mPartNumberMap[partSerialNumberDetails.mPartNumber]
                      .mQuantity,
                  mPartSerialNo: mSerialBarcode,
                  mPartMasterId: partSerialNumberDetails.mPartMasterId,
                  mPartNumber: partSerialNumberDetails.mPartNumber,
                  mBinLabel: partSerialNumberDetails.mBinLabel,
                  mPickQty: mQuantity));
            });

          NavigationUtils.push(
              context,
              PartNumberScanDetailsView(
                  mPartNumberMap,
                  partMasterDetailsMap,
                  partSerialNumberDetails.mPartNumber,
                  mSerialBarcode,
                  mPartNumberMap[partSerialNumberDetails.mPartNumber]
                      .mQuantity
                      .toString()));
        }
      }
    } else {
      CustomToast.showToast(BaseConstants.STR_NO_INTERNET);
    }
  }

  validateWithPartNumber(PartSerialNumberDetailsModel model) {
    if (mPartNumberMap[model.mPartNumber] != null) {
      if (model.mPartTypeCode == BusinessConstants.STR_V_PART) {
        dialogQty();
      } else {
        mQuantity = 1;
        validateSerialNumber();
      }
    } else {
      CustomAlerts.showAlert(context, "Invalid part scanned");
    }
  }

  dialogQty() {
    mQuantity = 0;
    tecQuantity = new TextEditingController();
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return SimpleDialog(
            backgroundColor: Color(0xffE6E6E6),
            children: <Widget>[
              iconClose(),
              Container(
                  margin: EdgeInsets.all(10.0),
                  child: Form(
                      key: qtyFormKey,
                      child: new Container(
                          child: Column(
                        children: <Widget>[
                          Center(
                            child: Text(
                              "Quantity required",
                              style: TextStyle(
                                  fontSize: 21.0, fontWeight: FontWeight.bold),
                              strutStyle: StrutStyle(),
                            ),
                          ),
                          Center(
                            child: Text(
                              "for this serial",
                              style: TextStyle(
                                  fontSize: 21.0, fontWeight: FontWeight.bold),
                              strutStyle: StrutStyle(),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          tffRequiredQuantity(),
                          SizedBox(
                            height: 10.0,
                          ),
                          rbOk()
                        ],
                      ))))
            ],
          );
        });
  }

  iconClose() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          child: Icon(
            Icons.close,
            color: Colors.blue[900],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }

  tffRequiredQuantity() {
    return CustomTextFormField(
      hint: 'Quantity',
      numbersOnly: true,
      inputType: TextInputType.number,
      title: 'Quantity',
      isTitleRequired: false,
      controller: tecQuantity,
      onValidate: (val) {
        return Utility.isEmpty(val) || int.parse(val) == 0
            ? 'Enter quanity'
            : null;
      },
      onSave: (val) {
        this.mQuantity = int.parse(val);
      },
    );
  }

  Widget rbOk() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        CustomRaisedButton(
          text: 'OK',
          buttonColor: Colors.blue,
          textColor: Colors.white,
          isWrap: true,
          onPress: () {
            if (this.qtyFormKey.currentState.validate())
              this.qtyFormKey.currentState.save();
            else
              return null;

            validateSerialNumber();
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
