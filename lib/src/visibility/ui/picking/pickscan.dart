library pickscan;

import 'dart:collection';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tvs_visibility/src/visibility/bloc/Picking/pickscanbloc.dart';
import 'package:tvs_visibility/src/visibility/constants/StringConstants.dart';
import 'package:tvs_visibility/src/visibility/constants/baseconstants.dart';
import 'package:tvs_visibility/src/visibility/constants/businessconstants.dart';
import 'package:tvs_visibility/src/visibility/dataprovider/sharedprefs.dart';
import 'package:tvs_visibility/src/visibility/model/picking/PartScanningInbound.dart';
import 'package:tvs_visibility/src/visibility/model/picking/PickingAlternateLocationResult.dart';
import 'package:tvs_visibility/src/visibility/model/picking/PickingExcessMaster.dart';
import 'package:tvs_visibility/src/visibility/model/picking/PickingResult.dart';
import 'package:tvs_visibility/src/visibility/model/picking/pickingmodel.dart';
import 'package:tvs_visibility/src/visibility/utililty/utils.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customalerts/customalerts.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/custombarcodescanner/barcodescanner.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customprogressindicator/customprogress.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customprogressindicator/customretry.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customview/custompdfview.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customview/customtoast.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/navigaton/navigationutils.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import '../homeview.dart';

class PickingScanning extends StatefulWidget {
  PickingLocationModel model;

  PickingScanning(this.model);

  @override
  _PickingScanningState createState() => _PickingScanningState(model);
}

class _PickingScanningState extends State<PickingScanning>{
  TextEditingController tecBinNumber = TextEditingController();
  TextEditingController tecVPartQuantity = TextEditingController();
  TextEditingController tecVPartSerial = TextEditingController();
  TextEditingController tecNoOfLabel = TextEditingController();
  CustomSharedPrefs mCustomSharedPreferences;
  double padding = 5.0;
  PickScanningResult mPickInboundResult;
  PickScanningResult mPickOutboundResult;
  PickingLocationModel mModel;
  PickScanBloc mBloc;
  String mScannedValue;
  bool mShowErrorMsg = false;

  String vTypeQuantity,
      noOfLabels,
      currentBin,
      scannedBinValue;
  int currentBinQuantity;
  int partScanningInboundStatus;
  int saveShotPickStatus;
  int snapShotData;
  String mValidationContent = '';
  String binName;
  String siteId;
  String remainPartMsg;
  String warehouseManagerId;
  Map userDetails = new HashMap<String, dynamic>();
  int labelVisible = 1;
  bool submitEnabled = false;
  bool randomEnabled = false;
  bool shortEnabled = false;
  bool alterEnabled = false;
  FocusNode focusNode;
  bool scanEnable = false;
  bool husBinScanStatus = false;


  _PickingScanningState(this.mModel) {
    var container = kiwi.Container();
    mBloc = container<PickScanBloc>();
    mCustomSharedPreferences=container<CustomSharedPrefs>();
  }

  @override
  void dispose() {
    tecVPartQuantity.clear();
    tecVPartSerial.clear();
    tecBinNumber.clear();
    tecNoOfLabel.clear();
    super.dispose();
  }

  @override
  void initState() {
    setView();
    getUserDetails();
    mBloc.setScanCode(1);
    super.initState();
  }

  void clearAll() {
    tecVPartQuantity.clear();
    tecVPartSerial.clear();
    tecNoOfLabel.clear();
    tecBinNumber.clear();
    mScannedValue = null;
    vTypeQuantity = null;
    noOfLabels = null;
    submitEnabled = false;
  }

  getUserDetails() async {
    userDetails = await mCustomSharedPreferences.getUserDetails();
    warehouseManagerId = await userDetails['warehouseManagerUserId'];
    siteId = await userDetails['siteId'];
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: false,
        stream: mBloc.isLoad,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && !snapshot.data) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: Text('Picking Scan'),
                centerTitle: true,
              ),
              body: new SingleChildScrollView(
                child: new StreamBuilder(
                    stream: mBloc.scanCode,
                    builder: (context, snapshot) {
                      snapShotData = snapshot.data;
                      return Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.all(padding),
                                      child: Text(
                                        mModel.refNo ?? '-',
                                        style: TextStyle(fontSize: padding * 3, fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.all(padding),
                                          child: Text(
                                            mModel.vPart
                                                ? 'V Parts'
                                                : 'NV Parts',
                                            style: TextStyle(
                                                fontSize: padding * 3),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.all(padding),
                                      child: Text(
                                        remainPartMsg ?? 'Remaing No of Parts',
                                        style: TextStyle(fontSize: padding * 3),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5),
                                        child: Text(
                                          binName ?? 'Bin Number',
                                          style:
                                              TextStyle(fontSize: padding * 3),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ]),
                                showErrorSuccessMsg(),
                                husBinScanStatus
                                    ? initialHUSBinWidget()
                                    : pickingWidget(snapshot)
                              ],
                            ),
                            SizedBox(
                              height: 45.0,
                            ),
                            buttonsView(),
                          ]);
                    }),
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(backgroundColor: Colors.white,body: CustomRetry(
              retry: () {},
            ),);
          } else {
            return CustomProgress();
          }
        });
  }

  Widget buttonsView() {
    return Container(
        width: double.maxFinite,
        child: Row(
          mainAxisAlignment:
              mModel.actorId == BusinessConstants.Actor_Type_Id_Dealer
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              onPressed: submitEnabled
                  ? () {
                      submit();
                    }
                  : () {},
              color: submitEnabled ? Colors.blue : Colors.grey[300],
              child: Text(
                'Submit',
                style: submitEnabled
                    ? TextStyle(color: Colors.white, fontSize: 10.0)
                    : TextStyle(fontSize: 10.0),
              ),
            ),
            mModel.actorId == BusinessConstants.Actor_Type_Id_Dealer
                ? new Container()
                : RaisedButton(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    onPressed: alterEnabled
                        ? () {
                            alterNatePicking();
                          }
                        : () {},
                    color: alterEnabled ? Colors.blue : Colors.grey[300],
                    child: Text(
                      'AlterNate Bin',
                      style: alterEnabled
                          ? TextStyle(color: Colors.white, fontSize: 10.0)
                          : TextStyle(fontSize: 10.0),
                    ),
                  ),
            mModel.actorId == BusinessConstants.Actor_Type_Id_Dealer
                ? new Container()
                : RaisedButton(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    onPressed: randomEnabled
                        ? () {
                            randomPick();
                          }
                        : () {},
                    color: randomEnabled ? Colors.blue : Colors.grey[300],
                    child: Text(
                      'Random pick',
                      style: randomEnabled
                          ? TextStyle(color: Colors.white, fontSize: 10.0)
                          : TextStyle(fontSize: 10.0),
                    ),
                  ),
            mModel.actorId == BusinessConstants.Actor_Type_Id_Dealer
                ? new Container()
                : RaisedButton(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    onPressed: shortEnabled
                        ? () {
                            shortPickAlert();
                          }
                        : () {},
                    color: shortEnabled ? Colors.blue : Colors.grey[300],
                    child: Text(
                      'Short pick',
                      style: shortEnabled
                          ? TextStyle(color: Colors.white, fontSize: 10.0)
                          : TextStyle(fontSize: 10.0),
                    ),
                  ),
          ],
        ));
  }

  Widget pickingWidget(AsyncSnapshot<int> snapshot) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Container(
        width: double.maxFinite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                clearAll();
                mBloc.setScanCode(1);
              },
              child: Row(
                children: <Widget>[
                  Checkbox(
                      value: snapshot.data == 1 ? true : false,
                      activeColor: Colors.blue,
                      onChanged: (val) {
                        clearAll();
                        mBloc.setScanCode(1);
                      }),
                  Text('Scan Barcode',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                clearAll();
                mBloc.setScanCode(2);
              },
              child: Row(
                children: <Widget>[
                  Checkbox(
                      value: snapshot.data == 2 ? true : false,
                      activeColor: Colors.blue,
                      onChanged: (val) {
                        clearAll();
                        mBloc.setScanCode(2);
                      }),
                  Text('Manual Scan',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            (mModel.actorId == BusinessConstants.Actor_Type_Id_Dealer)
                ? GestureDetector(
                    onTap: () {
                      clearAll();
                      initialHusBinUpdate();
                      mBloc.setScanCode(3);
                    },
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                            value: snapshot.data == 3 ? true : false,
                            activeColor: Colors.blue,
                            onChanged: (val) {
                              clearAll();
                              initialHusBinUpdate();
                              mBloc.setScanCode(3);
                            }),
                        Text('Change Bin',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                : Container(), // Change Bin CheckBox
          ],
        ),
      ),
      snapshot.data == 3 ? initialHUSBinWidget() : Container(),
      (snapshot.data == 1 && labelVisible != 2) // if Scan BarCode Selected and, not for label Generation
          ? Column(
              children: <Widget>[
                GestureDetector(
                  onTap: (((partScanningInboundStatus != null &&
                                  partScanningInboundStatus == 11) ||
                              (saveShotPickStatus != null &&
                                  saveShotPickStatus == 3) ||
                              (mModel.status == 2)) ||
                          !scanEnable)
                      ? null
                      : () {
                          getBarcode();
                        },
                  child: Icon(
                    Icons.settings_overscan,
                    size: 50.0,
                  ),
                )
              ],
            )
          : new Container(),
      (snapshot.data == 2 &&
              labelVisible != 2) // if Manual BarCode Selected and, not for label Generation
          ? textSerialNumber()
          : new Container(),
      labelVisible == 1 &&
              mScannedValue != null &&
              ((mModel.actorId == BusinessConstants.Actor_Type_Id_Dealer) || mModel.vPart) && snapshot.data != 3 // if HUS || (Inbound or Outbound scan V-Type Parts)
          ? textVTypeQty()
          : new Container(),
      labelVisible == 2 && mModel.vPart && (snapshot.data == 1 || snapshot.data == 2) // if Label Generation and, V-Type Parts
          ? textLabel()
          : new Container(),
    ]);
  }

  Widget textSerialNumber() {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      SizedBox(height: 10.0),
      Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Text(
              'LPN',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          )),
      SizedBox(height: 5.0),
      Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: TextField(
            enabled: ((partScanningInboundStatus != null && partScanningInboundStatus == 11) ||
                    (saveShotPickStatus != null && saveShotPickStatus == 3) ||
                    (mModel.status == 2) ||
                    !scanEnable)
                ? false
                : true,
            focusNode: focusNode,
            textCapitalization: TextCapitalization.characters,
            controller: tecVPartSerial,
            onChanged: (text) {
              onTextChanged(text, 1);
              mBloc.setScanCode(snapShotData);
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(gapPadding: 20.0),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              hintText: 'Enter LPN',
            ),
          )),
    ]);
  }

  Widget initialHUSBinWidget() {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      SizedBox(height: 10.0),
      Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Text(
              'Bin Number',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          )),
      SizedBox(height: 5.0),
      Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: TextField(
            enabled: true,
            focusNode: focusNode,
            textCapitalization: TextCapitalization.characters,
            controller: tecBinNumber,
            onChanged: (text) {
               onTextChanged(text, 0);
              mBloc.setScanCode(snapShotData);
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(gapPadding: 20.0),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              hintText: 'Enter Bin Number',
            ),
          )),
    ]);
  }

  Widget textVTypeQty() {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      SizedBox(height: 10.0),
      Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Text(
            ' V Type Quantity',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      SizedBox(height: 5.0),
      Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: TextField(
            enabled: (partScanningInboundStatus != null &&
                        partScanningInboundStatus == 11) ||
                    (saveShotPickStatus != null && saveShotPickStatus == 3) ||
                    (mModel.status == 2)
                ? false
                : true,
            focusNode: focusNode,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly
            ],
            controller: tecVPartQuantity,
            onChanged: (text) {
              onTextChanged(text, 2);
              mBloc.setScanCode(snapShotData);
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              hintText: 'Enter V Type Quantity',
            ),
          )),
    ]);
  }

  Widget textLabel() {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      SizedBox(height: 10.0),
      Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Text(
            'Number Of Label',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      SizedBox(height: 5.0),
      Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: TextField(
          enabled: (partScanningInboundStatus != null &&
                      partScanningInboundStatus == 11) ||
                  (saveShotPickStatus != null && saveShotPickStatus == 3) ||
                  (mModel.status == 2)
              ? true
              : false,
          focusNode: focusNode,
          controller: tecNoOfLabel,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly
          ],
          onChanged: (text) {
            onTextChanged(text, 3);
            mBloc.setScanCode(snapShotData);
          },
          maxLength: 10,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            counterText: '',
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            hintText: 'Enter No.of Label',
          ),
        ),
      ),
    ]);
  }

  Widget showErrorSuccessMsg() {
    return mValidationContent.isNotEmpty
        ? Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Container(
              margin: EdgeInsets.all(padding),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.6),
                child: Wrap(alignment: WrapAlignment.end, children: <Widget>[
                  mShowErrorMsg
                      ? Text(
                          mValidationContent,
                          maxLines: 4,
                          overflow: TextOverflow.clip,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: padding * 3,
                              color: Colors.redAccent[200]),
                        )
                      : Text(
                          mValidationContent,
                          maxLines: 4,
                          overflow: TextOverflow.clip,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: padding * 3, color: Colors.green[500]),
                        ),
                ]),
              ),
            ),
          ])
        : Container();
  }

  void getBarcode() async {
    String barcode = await BarCodeScanner.barcodeScanning(context);
    if (barcode != null) {
      if (barcode == BaseConstants.STR_CANCELLED || barcode == BaseConstants.STR_PERMISSION_NOT_GRANTED) {
        CustomToast.showToast(barcode);
      } else {
        mScannedValue = barcode;
        if (Utils.regexCompare(mScannedValue)) {
          CustomToast.showToast("ReCapture the BarCode: $mScannedValue");
        } else {
          await SystemSound.play(SystemSoundType.click);
          CustomToast.showToast(barcode);
          if (((mModel.actorId == BusinessConstants.Actor_Type_Id_Dealer) ||
                  mModel.vPart) &&
              (mModel.status == 1 || mModel.status == 3)) {
            // Inbound Label Scan or Outbound Label Scan or HUS
            setVtypeLabelVisible();
          } else {
            // process For NV-Type Parts
            callApi();
          }
        }
      }
      mBloc.setScanCode(snapShotData);
    }
  }

  void callApi() async {
    if ((mModel.actorId == BusinessConstants.Actor_Type_Id_Dealer) && husBinScanStatus) {
      // HUS Bin Label Scan
      if (Utils.isEmpty(mScannedValue))
        CustomAlerts.showToast("Enter the Bin Number");
      else
        inBoundApiCall(0);
    } else if (((mModel.actorId == BusinessConstants.Actor_Type_Id_Dealer) ||
        mModel.vPart)) {
      if ((partScanningInboundStatus != null &&
              partScanningInboundStatus == 11) ||
          (saveShotPickStatus != null && saveShotPickStatus == 3) ||
          (mModel.status == 2)) {
        // Generate outBound Label
        if (Utils.isEmpty(noOfLabels)) {
          setnoOfLabelVisible();
        } else {
          int input = int.parse(noOfLabels);
          createOutBoundLabel(input);
        }
      } else if (mModel.status == 1) {
        // Inbound Label Scan || HUS Part
        if (Utils.isEmpty(mScannedValue))
          CustomAlerts.showToast("Enter the Barcode");
        else {
          if (Utils.isEmpty(vTypeQuantity)) {
            setVtypeLabelVisible();
          } else {
            int input = int.parse(vTypeQuantity);
            inBoundApiCall(input);
          }
        }
      } else if (mModel.status == 3) {
        // Outbound Label Scan
        if (Utils.isEmpty(mScannedValue))
          CustomAlerts.showToast("Enter the Barcode");
        else {
          if (Utils.isEmpty(vTypeQuantity)) {
            setVtypeLabelVisible();
          } else {
            outBoundApiCall();
          }
        }
      }
    } else {
      if (Utils.isEmpty(mScannedValue))
        CustomAlerts.showToast("Enter the Barcode");
      else {
        // Label Scan For NV-Type Parts
        inBoundApiCall(0);
      }
    }
  }

  void setView() {
    if (mModel.actorId == BusinessConstants.Actor_Type_Id_Dealer) {
      initialHusBinUpdate();
    } else {
      if (mModel.status == 1) {
        remainPartMsg = 'Remaining Number of Parts :${mModel.requestedQuantity - mModel.pickedQuantity}';
      } else if (mModel.status == 3) {
        remainPartMsg = 'Remaining Number of Parts :${mModel.requestedQuantity - mModel.packedQuantity}';
      }
      setLabelVisibility();
    }

    mBloc.setScanCode(snapShotData);
  }

  void initialHusBinUpdate() {
    mValidationContent = "Please Scan the Bin Now";
    mShowErrorMsg = true;
    remainPartMsg = 'Remaining Number of Parts :${mModel.requestedQuantity - mModel.pickedQuantity}' + (mModel.vPart ? ' ${mModel.allowedQty}' : '');
    husBinScanStatus = true;
    currentBin = mModel.pickLocation;
    currentBinQuantity = mModel.currentBinQuantity != null ? mModel.currentBinQuantity : 0;
    setBinNumber();
  }

  void setLabelVisibility() {
    mShowErrorMsg = false;
    if (mModel.status == 1) {
      // Inbound Label Scan
      currentBin = mModel.currentBin;
      if (mModel.randomPickStatus == 2)
        currentBin = mModel.pickLocation;
      currentBinQuantity = mModel.currentBinQuantity != null ? mModel.currentBinQuantity : 0;
      setBinNumber();
      setLabelGone();
      checkStatus();
    } else if (mModel.status == 2) {
      // Generate outBound Label
      setnoOfLabelVisible();
    } else if (mModel.status == 3) {
      // Outbound Label Scan
      alterEnabled = false;
      randomEnabled = false;
      shortEnabled = false;
      scanEnable = true;
      setLabelGone();
      CustomAlerts.showToast("Please Scan OutBound Label ");
    }
    mBloc.setScanCode(snapShotData);
  }

  void submit() {
    mBloc.setScanCode(snapShotData);
    callApi();
  }

  void inBoundApiCall(int input) async {
    if (!Utils.isEmpty(mScannedValue) && Utils.regexCompare(mScannedValue)) {
      CustomToast.showToast("ReEnter/Capture the serialnumber: $mScannedValue");
    } else {
      if (await Utils.onCheckNetworkConnection()) {
        /*print('currentBin=${currentBin}');
        print('accountId=${mModel.accountId}');
        print('actorId=${mModel.actorId}');
        print('partsInOrderId=${mModel.partsInOrderId}');
        print('orderId=${mModel.orderId}');
        print('serialNumber=${mScannedValue}');
        print('siteMasterId=${siteId}');
        print('partsMasterId=${mModel.partMasterId}');
        print('binLabel=${scannedBinValue}');
        print('warehouseInboundId=${mModel.warehouseInboundId}');
        print('randomPickStatus=${mModel.randomPickStatus}');
        print('pickedQty=${input}');*/
        mPickInboundResult = await mBloc.onpartScanningInbound(
            new PartScanningInbound(
                accountId: mModel.accountId,
                actorId: mModel.actorId,
                currentBin: currentBin,
                orderId: mModel.orderId,
                partsInOrderId: mModel.partsInOrderId,
                partsMasterId: mModel.partMasterId,
                pickedQty: input,
                randomPickStatus: mModel.randomPickStatus,
                serialNumber: mScannedValue,
                siteMasterId: siteId,
                warehouseInboundId: mModel.warehouseInboundId));

        inboundResult(mPickInboundResult,mScannedValue);
        clearAll();
        mBloc.setScanCode(snapShotData);
      } else {
        CustomToast.showToast(StringConstants.NO_INTERNET_CONNECTION);
      }
    }
  }

  void outBoundApiCall() async {
    if (Utils.regexCompare(mScannedValue)) {
      CustomToast.showToast("ReEnter/Capture the serialnumber: $mScannedValue");
    } else {
      if (await Utils.onCheckNetworkConnection()) {
        int input = int.parse(vTypeQuantity);
        mPickInboundResult = await mBloc.onpartScanningOutbound(
            new PartScanningInbound(
                orderId: mModel.orderId,
                partsInOrderId: mModel.partsInOrderId,
                partsMasterId: mModel.partMasterId,
                pickedQty: input,
                serialNumber: mScannedValue,
                siteMasterId: siteId,
                warehouseInboundId: mModel.warehouseInboundId));

        outboundResult(mPickInboundResult,mScannedValue);
      } else {
        CustomToast.showToast(StringConstants.NO_INTERNET_CONNECTION);
      }
    }
  }

  void alterNatePicking() async {
    if (await Utils.onCheckNetworkConnection()) {
      AlternateLocationResult locationResult = await mBloc.onAlternatePicking(
          new PartScanningInbound(
              accountId: mModel.accountId,
              binLabel: currentBin,
              partsInOrderId: mModel.partsInOrderId,
              warehouseInboundId: mModel.warehouseInboundId,
              warehouseManagerId: warehouseManagerId));

      alterEnabled = false;
      randomEnabled = false;
      setLabelGone();

      if (locationResult != null && locationResult.status != null) {
        if (locationResult.status == 3) {
          mValidationContent = ("All Parts Picked Already !");
          mShowErrorMsg = true;
          return;
        }

        if (locationResult.status == 12) {
          mValidationContent = ("No Parts Available");
          mShowErrorMsg = true;
          return;
        }

        if (locationResult.status == 13) {
          mValidationContent = ("All parts locked at ${locationResult.alternateLocation}");
          mShowErrorMsg = true;
          currentBin = locationResult.currentBin;
          currentBinQuantity = locationResult.currentBinQuantity != null
              ? locationResult.currentBinQuantity
              : 0;
          setBinNumber();
          updateOfCurrentBinStatus(locationResult.status);
          labelEnableBasedOnStatus();
          return;
        }

        if (locationResult.status == 14) {
          mValidationContent = (((locationResult.availableQuantity) > 0)
              ? "Parts locked at ${locationResult.alternateLocation}" +
                  ",for remaining ${(locationResult.requestedQuantity) - (locationResult.availableQuantity)}  parts try with Random pick"
              : "No parts available with given criteria,try with Random pick");
          mShowErrorMsg = true;
          currentBin = locationResult.currentBin;
          currentBinQuantity = locationResult.currentBinQuantity != null
              ? locationResult.currentBinQuantity
              : 0;
          setBinNumber();
          updateOfCurrentBinStatus(locationResult.status);
          alterEnabled = false;
          return;
        }

        if (locationResult.status == 15) {
          mValidationContent = (((locationResult.availableQuantity) > 0)
              ? "Parts locked at " +
                  locationResult.alternateLocation +
                  ", ${(locationResult.requestedQuantity) - (locationResult.availableQuantity)} parts not available"
              : "${locationResult.requestedQuantity} Parts not available");
          mShowErrorMsg = true;
          currentBin = locationResult.currentBin;
          currentBinQuantity = locationResult.currentBinQuantity != null
              ? locationResult.currentBinQuantity
              : 0;
          setBinNumber();
          updateOfCurrentBinStatus(locationResult.status);
          alterEnabled = false;
          labelEnableBasedOnStatus();
        }

        if (locationResult.status == 19) {
          mValidationContent = ("Part is not Associated with this Account");
          mShowErrorMsg = true;
          shortEnabled = true;
          labelEnableBasedOnStatus();
          return;
        }
      }
      mBloc.setScanCode(snapShotData);
    } else {
      CustomToast.showToast(StringConstants.NO_INTERNET_CONNECTION);
    }
  }

  void updateOfCurrentBinStatus(int status) {
    if (Utils.isEmpty(currentBin) &&
        (status == 13 || status == 14 || status == 15)) {
      scanEnable = false;
    }
  }

  void randomPick() async {
    if (await Utils.onCheckNetworkConnection()) {
      int data = await mBloc.getRandomPickRequest(new PartScanningInbound(
        ordersMasterId: mModel.orderId,
        partMasterId: mModel.partMasterId,
        partsInOrderId: mModel.partsInOrderId,
        siteMasterId: siteId,
        warehouseManagerId: warehouseManagerId,
      ));
      if (data == 1) {
        binName = null;
        currentBin = null;
        CustomAlerts.showAlertWithFunctionAction(
            context, 'Waiting for Warehouse manager approval!!!', () {
          navigateToHomeView();
        });
      } else if (data == 2) {
        mValidationContent = "Random Pick Failed!!";
        mShowErrorMsg = true;
      }
      mBloc.setScanCode(snapShotData);
    } else {
      CustomToast.showToast(StringConstants.NO_INTERNET_CONNECTION);
    }
  }

  void shortPickAlert() {
    CustomAlerts.showAlertWithOkCancel(
        context,
        "Are you sure confirm Short Pickup?",
        'No',
        'Yes',
        () {},
        shortPickApiCall);
  }

  void shortPickApiCall() async {
    if (await Utils.onCheckNetworkConnection()) {
      int value = await mBloc.onShortPicking(new ExcessMaster(
          ordersMasterId: mModel.orderId,
          partsMasterId: mModel.partMasterId,
          warehouseInboundId: mModel.warehouseInboundId,
          userId: warehouseManagerId,
          siteMasterId: siteId));

      this.saveShotPickStatus = value;
      setLabelGone();
      if (saveShotPickStatus == 1) {
        mValidationContent = ("Scan Atleast One Part!");
        mShowErrorMsg = true;
        scanEnable = true;
        if (mModel.vPart) {
          CustomAlerts.showToast('Please Scan Inbound Label with V Part Quantity');
        } else {
          CustomAlerts.showToast('Scan the NV Part Label');
        }
        return;
      }

      if (saveShotPickStatus == 3) {
        setnoOfLabelVisible();
        return;
      }

      if (saveShotPickStatus == 2) {
        CustomAlerts.showAlertWithFunctionAction(
            context, 'Short Pick Added Successfully!!!', () {
          navigateToHomeView();
        });
      }
      mBloc.setScanCode(snapShotData);
    } else {
      CustomToast.showToast(StringConstants.NO_INTERNET_CONNECTION);
    }
  }

  void createOutBoundLabel(int input) async {
    if (await Utils.onCheckNetworkConnection()) {
      String str = await mBloc.onVpartPickingLabel(siteId, mModel.warehouseInboundId, '$input', mModel.partsInOrderId);

      CustomAlerts.showAlertWithFunctionAction(
          context, 'OutBound Labels Generated Successfully!!!', () {
        positiveButton(str);
      });
    } else {
      CustomToast.showToast(StringConstants.NO_INTERNET_CONNECTION);
    }
  }

  void positiveButton(String str) {
    var data = NavigationUtils.push(
        context,
        MyPdfView(
          path: str,
          title: 'PDF Viewer',
        ));
    data.whenComplete(() {
      navigateToHomeView();
    });
  }

  void inboundResult(PickScanningResult result,String serialNumber) {
    print("pickScanningResultModel: " + result.toString());
    randomEnabled = false;
    int partScanningInboundStatus = result.status ?? 0;
    submitEnabled = false;
    if (partScanningInboundStatus != null) {
      this.partScanningInboundStatus = partScanningInboundStatus;
      if (partScanningInboundStatus == 3) {
        mValidationContent = "Already Picked!";
        mShowErrorMsg = true;
        randomEnabled = true;
        submitEnabled = true;
        return;
      }

      if (partScanningInboundStatus == 2) {
        mValidationContent = "Inbound serial number locked for different Order";
        mShowErrorMsg = true;
        randomEnabled = true;
        return;
      }

      if (partScanningInboundStatus == 9) {
        mValidationContent = "Please Scan Correct Inbound part";
        mShowErrorMsg = true;
        return;
      }

      if (partScanningInboundStatus == 5) {
        mValidationContent = "LPN $serialNumber not picked as it is is not associated with Part Number ${mModel.partNumber}";
        mShowErrorMsg = true;
        randomEnabled = true;
        return;
      }

      if (partScanningInboundStatus == 8) {
        mValidationContent = "Outbound label scanned without scanning Inbound label ";
        mShowErrorMsg = true;
        return;
      }

      if (partScanningInboundStatus == 10) {
        setVtypeLabelVisible();
        mValidationContent = "Quantity entered: ${tecVPartQuantity.text} is greater than quantity in stock for LPN ${tecVPartSerial.text}";
        mShowErrorMsg = true;
        return;
      }

      if (partScanningInboundStatus == 1) {
        currentBin = result.currentBin;
        currentBinQuantity =
            result.currentBinQuantity != null ? result.currentBinQuantity : 0;
        setBinNumber();
        remainPartMsg = ("");
        remainPartMsg = (result.remainingQuantity != null
            ? "Remaining Number Of Parts: ${result.remainingQuantity}"
            : "");
        checkStatus();
        mValidationContent =
            ("Successfully Captured Quantity,Process picking Now ${mModel.partNumber}");
        mShowErrorMsg = false;
        return;
      }

      if (partScanningInboundStatus == 4) {
        setVtypeLabelVisible();
        mValidationContent = 'Enter V Type Qty';
        mShowErrorMsg = true;
        return;
      }

      if (partScanningInboundStatus == 11) {
        setnoOfLabelVisible();
        mValidationContent =
            ("Inbound label scan completed Successfully!,Please Enter the No.of Labels");
        mShowErrorMsg = false;
        return;
      }

      if (partScanningInboundStatus == 7) {
        setVtypeLabelVisible();
        mValidationContent = ("Inbound label already scan, please proceed outbound scan" +
            "/n" +
            "Enter V Type Qty");
        mShowErrorMsg = true;
        return;
      }

      if (partScanningInboundStatus == 16) {
        mValidationContent = ("Random Pick Waiting for Manager Approval");
        mShowErrorMsg = false;
        return;
      }

      if (partScanningInboundStatus == 17) {
        mValidationContent =
            ("Alternate Location requested for this Serial Number ,Alternate Quantity is"
                " ${result.alteredQauntity}  and Unsatisfied Quantity is "
                "${result.missingQuantity} ");
        mShowErrorMsg = true;
        return;
      }

      if (partScanningInboundStatus == 12) {
        mValidationContent = ("Pick Parts from $currentBinQuantity Bin");
        mShowErrorMsg = true;
        return;
      }

      if (partScanningInboundStatus == 18) {
        setVtypeLabelVisible();
        mValidationContent = ("Quantity is insufficient!");
        mShowErrorMsg = true;
        return;
      }

      if (partScanningInboundStatus == 6) {
        CustomAlerts.showAlertWithFunctionAction(
            context, 'Parts are Picked Successfully!!!', () {
          navigateToHomeView();
        });
      }

      // HQ Status Check

      if (partScanningInboundStatus == BusinessConstants.Picking_Success) {
        CustomAlerts.showAlertWithFunctionAction(
            context, 'All parts are Picked Successfully!!!', () {
          navigateToHomeView();
        });
      }

      if (partScanningInboundStatus ==
          BusinessConstants.Picking_Quantity_NotAvailable) {
        mValidationContent = ("Quantity not Available");
        mShowErrorMsg = true;
        return;
      }

      if (partScanningInboundStatus ==
          BusinessConstants.Picking_ActorOrRandom_Missing) {
        //  Pick again Some Parameter is missing
        mValidationContent = ("Pick Again !");
        mShowErrorMsg = true;
        return;
      }

      if (partScanningInboundStatus == BusinessConstants.Picking_Continue) {
        currentBin = result.currentBin;
        currentBinQuantity =
            result.currentBinQuantity != null ? result.currentBinQuantity : 0;
        setBinNumber();
        remainPartMsg = ("");
        remainPartMsg = (result.remainingQuantity != null
            ? "Remaining Number Of Parts: ${result.remainingQuantity}" +
                (mModel.vPart ? " ${mModel.allowedQty}" : "")
            : "");

        checkStatus();
        mValidationContent = ("Successfully Scanned Part -" +
            mScannedValue +
            ", please continue Picking");
        mShowErrorMsg = false;
        return;
      }

      if (partScanningInboundStatus ==
          BusinessConstants.Picking_Quantity_NotGreater) {
        mValidationContent = ("Quantity Greater Than Zero");
        mShowErrorMsg = true;
        return;
      }

      if (partScanningInboundStatus == BusinessConstants.Picking_Correct_Bin) {
        husBinScanStatus = false;
        currentBin = scannedBinValue;
        setBinNumber();
        scanEnable = true;
        mValidationContent = ("Successfully Scanned Bin -  $scannedBinValue!");
        mShowErrorMsg = false;
        return;
      }

      if (partScanningInboundStatus == BusinessConstants.Picking_InCorrect_Bin) {
        mValidationContent = ("InCorrect BIN");
        mShowErrorMsg = true;
        return;
      }

      if (partScanningInboundStatus == BusinessConstants.Picking_AllPart_Picked) {
        CustomAlerts.showAlertWithFunctionAction(
            context, 'All parts are Picked Successfully!!!', () {
          navigateToHomeView();
        });
      }

      if (partScanningInboundStatus ==
          BusinessConstants.Picking_CorrectPartWith_Bin) {
        mValidationContent = ("Please Scan Correct Part with Correct Bin");
        mShowErrorMsg = true;
        return;
      }

      if (partScanningInboundStatus ==
          BusinessConstants.Picking_QuantityDoesNotMatch) {
        mValidationContent = ("Picked Quantity Does not Match");
        mShowErrorMsg = true;
        return;
      }
    }
  }

  void outboundResult(PickScanningResult outboundResult,String serialNumber) {
    shortEnabled = false;
    int partPickingStatus = outboundResult.status;
    setLabelGone();
    if (partPickingStatus != null) {
      if (partPickingStatus == 3) {
        mValidationContent = "Already Picked!";
        mShowErrorMsg = true;
        return;
      }
      if (partPickingStatus == 2) {
        mValidationContent = "Outbound Part Mismatch!";
        mShowErrorMsg = true;
        return;
      }

      if (partPickingStatus == 9) {
        mValidationContent = "Outbound serial number locked for different Order";
        mShowErrorMsg = true;
        return;
      }
      if (partPickingStatus == 5) {
        mValidationContent = "LPN $serialNumber not picked as it is is not associated with Part Number ${mModel.partNumber}";
        mShowErrorMsg = true;
        return;
      }

      if (partPickingStatus == 7) {
        mValidationContent = "Inbound label scan accepted proceed Outbound scan";
        mShowErrorMsg = true;
        return;
      }
      if (partPickingStatus == 8) {
        mValidationContent = "Outbound label scanned without scanning inbound label ";
        mShowErrorMsg = true;
        return;
      }

      if (partPickingStatus == 10) {
        setVtypeLabelVisible();
        mValidationContent = "Quantity entered: ${tecVPartQuantity.text} is greater than quantity in stock for LPN ${tecVPartSerial.text}";
        mShowErrorMsg = true;
        return;
      }

      if (partPickingStatus == 4) {
        setVtypeLabelVisible();
        mValidationContent = "Enter V Type Qty";
        mShowErrorMsg = true;
        return;
      }

      if (partPickingStatus == 1) {
        remainPartMsg = "";
        remainPartMsg = outboundResult.remainingQuantity != null
            ? "Remaining Number Of Parts:  ${outboundResult.remainingQuantity} "
            : "";
        mValidationContent =
            "Successfully Captured Quantity,Process picking Now ${mModel.partNumber}";
        mShowErrorMsg = false;
        clearAll();
        return;
      }

      if (partPickingStatus == 17) {
        mValidationContent =
            "Alternate Location requested for this Serial Number ,Alternate Quantity is ${outboundResult.alteredQauntity} and Unsatisfied Quantity is ${outboundResult.missingQuantity}";
        mShowErrorMsg = true;
        return;
      }

      if (partPickingStatus == 6) {
        CustomAlerts.showAlertWithFunctionAction(
            context, 'Parts are Picked Successfully!!!', () {
          navigateToHomeView();
        });
      }
      mBloc.setScanCode(snapShotData);
    }
  }

  void setVtypeLabelVisible() {
    labelVisible = 1;
    submitEnabled = false;
    mBloc.setScanCode(snapShotData);
  }

  void setnoOfLabelVisible() {
    labelVisible = 2;
    submitEnabled = false;
    randomEnabled = false;
    shortEnabled = false;
    alterEnabled = false;
    scanEnable = false;
    mBloc.setScanCode(snapShotData);
  }

  void labelEnableBasedOnStatus() {
    if (mModel.vPart) {
      // Label Scan Process for V-Type Parts
      if (mModel.status == 2) {
        setnoOfLabelVisible();
      } else if ((mModel.status == 3) || (mModel.status == 1)) {
        // Label Scan Process for OutBound Label
        setVtypeLabelVisible();
      }
    }
  }

  void setLabelGone() {
    labelVisible = 0;
    mBloc.setScanCode(snapShotData);
  }

  void setBinNumber() {
    if ((!Utils.isEmpty(currentBin) && currentBinQuantity != 0)) {
      binName = "Bin Number: $currentBin ( $currentBinQuantity )";
    } else if (!Utils.isEmpty(currentBin)) {
      binName = "Bin Number: $currentBin";
    } else {
      binName = null;
    }
    mBloc.setScanCode(snapShotData);
  }

  void checkStatus() {
    if (mModel.randomPickStatus == 0) {
      if (Utils.isEmpty(currentBin)) {
        alterEnabled = false;
        randomEnabled = true;
        shortEnabled = true;
        scanEnable = false;
        CustomAlerts.showToast('Try short pick or Random pick');
      } else {
        alterEnabled = true;
        randomEnabled = true;
        shortEnabled = true;
        scanEnable = true;
        if (mModel.vPart) {
          CustomAlerts.showToast('Enter the V Part LPN,Quantity to be picked from LPN and press submit');
        } else {
          CustomAlerts.showToast('Scan the NV Part LPN');
        }
      }
    } else if (mModel.randomPickStatus == 1) {
      // checked in list screen,  nothing to do here / wont't flow into the condition in this screen
    } else if (mModel.randomPickStatus == 2) {
      alterEnabled = false;
      randomEnabled = false;
      shortEnabled = true;
      if (!Utils.isEmpty(currentBin)) {
        scanEnable = true;
        if (mModel.vPart) {
          CustomAlerts.showToast('Enter the V Part LPN,Quantity to be picked from LPN and press submit');
        } else {
          CustomAlerts.showToast('Scan the NV Part LPN');
        }
      } else {
        scanEnable = false;
        CustomAlerts.showToast('Bin Location is not available Try short pick');
      }
    }
    mBloc.setScanCode(snapShotData);
  }

  void onTextChanged(String text, int id) {
    switch (id) {
      case 0:
        mScannedValue = tecBinNumber.text;
        scannedBinValue = mScannedValue;
        text?.length != 0 ? submitEnabled = true : submitEnabled = false;
        break;
      case 1:
        if (text?.length != 0 && !(text == '0')) {
          mScannedValue = tecVPartSerial.text;
          if (((mModel.actorId == BusinessConstants.Actor_Type_Id_Warehouse) && !mModel.vPart) && tecVPartSerial.text.length > 0) {
            submitEnabled = true;
            labelVisible == 1;
          } else if (((mModel.actorId == BusinessConstants.Actor_Type_Id_Dealer) || mModel.vPart) && (mModel.status == 1 || mModel.status == 3)) {
            // Inbound Label Scan or Outbound Label Scan or HUS
            labelVisible = 1;
            submitEnabled = false;
            vTypeQuantity = tecVPartQuantity.text ?? '';
           /* if (Utils.isEmpty(vTypeQuantity) && Utils.isEmpty(mScannedValue))
              CustomAlerts.showToast('Enter V Type Qty');*/
          } else {
            submitEnabled = false;
            labelVisible == 0;
          }
        }
        break;
      case 2:
        if (text?.length != 0 && !(text == '0')) {
          vTypeQuantity = tecVPartQuantity.text ?? '';
          if ((((mModel.actorId == BusinessConstants.Actor_Type_Id_Dealer) || mModel.vPart)) && !Utils.isEmpty(vTypeQuantity) &&
              vTypeQuantity.length!=0) {
            submitEnabled = true;
          } else {
            submitEnabled = false;
            labelVisible == 0;
          }
        }else{
          submitEnabled = false;
        }
        break;
      case 3:
        if (text?.length != 0 && !(text == '0')) {
          noOfLabels = tecNoOfLabel.text ?? '';
          if ((mModel.vPart) &&
              !Utils.isEmpty(tecNoOfLabel.text) &&
              tecNoOfLabel.text.length > 0) {
            submitEnabled = true;
          } else {
            submitEnabled = false;
            labelVisible == 0;
          }
        }
        break;
    }
  }

  navigateToHomeView() {
    return NavigationUtils.pushReplacement(context, HomeView());
  }
}
