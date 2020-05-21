import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/assetsconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/baseconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/businessconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/utility/utils.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/CustomRetry.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/barcodescanner/barcodescanner.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customalerts/customalert.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customprogress.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customraisedbutton.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customtext.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customtextformfield.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/navigaton/navigationutils.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/toast/customtoast.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/bloc/partnumberscandetailsbloc.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/partserialnumberdetailsmodel/partserialnumberdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/postdispatchmasterdetailsmodel/postdispatchmasterdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/postpartmasterdetailsmodel/postpartmasterdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/ui/partnoactionview.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/ui/partnumberscandetailsview/partnumberscanview.dart';

class PartNumberScanDetailsView extends StatefulWidget {
  LinkedHashMap<String, List<PostDispatchMasterDetailsModel>>
      partNumberDetailsMap;
  LinkedHashMap<String, PostPartMasterDetailsModel> partMap;
  String partNumber;
  String serialNumber;
  String reqQty;

  PartNumberScanDetailsView(this.partMap, this.partNumberDetailsMap,
      this.partNumber, this.serialNumber, this.reqQty);

  @override
  State<StatefulWidget> createState() {
    return PartNumberScanDetailsViewState(
        this.partMap,
        this.partNumberDetailsMap,
        this.partNumber,
        this.reqQty,
        this.serialNumber);
  }
}

class PartNumberScanDetailsViewState extends State<PartNumberScanDetailsView> {
  LinkedHashMap<String, List<PostDispatchMasterDetailsModel>>
      mPartNumberDetailsMap = LinkedHashMap();
  LinkedHashMap<String, PostPartMasterDetailsModel> mPartMap = LinkedHashMap();
  final formKey = new GlobalKey<FormState>();
  final qtyFormKey = new GlobalKey<FormState>();
  PartNumberScanDetailBloc mPartNumberScanDetailBloc;
  TextEditingController tecQuantity;
  String mPartNumber;
  Function function;
  String mSerialNumber;
  String mReqQty;
  int mQuantity = 0;
  bool isPartsEqual = false;

  PartNumberScanDetailsViewState(this.mPartMap, this.mPartNumberDetailsMap,
      this.mPartNumber, this.mReqQty, this.mSerialNumber) {
    var container = kiwi.Container();
    mPartNumberScanDetailBloc = container<PartNumberScanDetailBloc>();
  }

  @override
  void initState() {
    mPartNumberScanDetailBloc.onSetPartNumberScannedResult(this.mSerialNumber);
    super.initState();
  }

  @override
  void dispose() {
    mPartNumberScanDetailBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: false,
        stream: mPartNumberScanDetailBloc.isLoad,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && !snapshot.data) {
            return StreamBuilder(
                initialData: mSerialNumber,
                stream: mPartNumberScanDetailBloc.scannedResult,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  return Scaffold(
                    backgroundColor: Colors.white,
                    resizeToAvoidBottomInset: true,
                    appBar: appBar(),
                    body: Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                textPartNumber(),
                                textReqQty(),
                                SizedBox(
                                  height: 5,
                                ),
                                Divider(
                                  color: Colors.green,
                                ),
                                Expanded(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    iconCheck(),
                                    Center(
                                        child: CustomText(
                                      text: 'SERIAL NO:',
                                      fontSize: 22,
                                      textColor: Colors.green,
                                      fontFamily:
                                          AssetsConstants.OPEN_SANS_LIGHT,
                                      fontStyle: FontStyle.normal,
                                    )),
                                    Center(
                                        child: CustomText(
                                      text:
                                          '${mPartNumberScanDetailBloc.partNumberScannedResult.stream.value}',
                                      fontSize: 22,
                                      textColor: Colors.green,
                                      fontFamily:
                                          AssetsConstants.OPEN_SANS_BOLD,
                                      fontStyle: FontStyle.normal,
                                    )),
                                    textQtyScannedForPartSerial(mPartMap[
                                                    mPartNumber] !=
                                                null &&
                                            mPartMap[mPartNumber]
                                                    .mPartTypeMaster ==
                                                "V"
                                        ? mPartNumberScanDetailBloc
                                            .getTotalPartsForPartSerialNumber(
                                                mPartNumberDetailsMap[
                                                    mPartNumber])
                                        : mPartNumberDetailsMap[mPartNumber]
                                            .length),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    (isPartsEqual = getPartsCount()) == true
                                        ? textScannedSuccessfully()
                                        : Container()
                                  ],
                                )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    bottomNavigationBar: isPartsEqual
                        ? rbFinish()
                        : Row(
                            children: <Widget>[
                              Expanded(
                                child: rbNext(),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: rbFinish(),
                              )
                            ],
                          ),
                  );
                });
          } else if (snapshot.hasError)
            return Scaffold(
              body: CustomRetry(
                retry: function,
              ),
              backgroundColor: Colors.white,
            );
          else
            return CustomProgress();
        });
  }

  getPartsCount() {
    return mPartNumberScanDetailBloc
        .isTotalPartsForPartNumberAndPartSerialEqual(
            mPartMap, mPartNumberDetailsMap);
  }

  appBar() {
    return PreferredSize(
        child: AppBar(
          title: CustomText(
            text: "Dealer-Picking" ?? "PartNumberDetailView",
            fontFamily: AssetsConstants.OPEN_SANS_LIGHT,
          ),
          backgroundColor: Colors.blue,
        ),
        preferredSize: Size.fromHeight(60));
  }

  Widget textPartNumber() {
    return Row(
      children: <Widget>[
        SizedBox(height: 40.0, width: 15.0),
        CustomText(
          text: 'Part No: ',
          fontSize: 20,
          fontStyle: FontStyle.normal,
          fontFamily: AssetsConstants.OPEN_SANS_LIGHT,
          textColor: Colors.green,
          textAlign: TextAlign.center,
        ),
        CustomText(
          text: "$mPartNumber",
          fontSize: 20,
          fontStyle: FontStyle.normal,
          fontFamily: AssetsConstants.OPEN_SANS_BOLD,
          fontWeight: FontWeight.bold,
          textColor: Colors.green,
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget textReqQty() {
    return Row(
      children: <Widget>[
        SizedBox(height: 30.0, width: 15.0),
        CustomText(
            text: 'Required Qty: ',
            fontSize: 20,
            fontStyle: FontStyle.normal,
            textColor: Colors.green,
            fontFamily: AssetsConstants.OPEN_SANS_LIGHT,
            textAlign: TextAlign.center),
        CustomText(
          text: "${mReqQty != null ? mReqQty : '-'}",
          fontSize: 20,
          fontWeight: FontWeight.bold,
          textColor: Colors.green,
          fontFamily: AssetsConstants.OPEN_SANS_BOLD,
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget iconCheck() {
    return Icon(
      Icons.check,
      color: Colors.green,
      size: 100,
    );
  }

  Widget textScannedSuccessfully() {
    return Center(
        child: CustomText(
      text: 'Scanned Successfully!',
      fontSize: 18,
      textColor: Colors.green,
      fontFamily: AssetsConstants.OPEN_SANS_BOLD,
      fontStyle: FontStyle.normal,
    ));
  }

  textQtyScannedForPartSerial(int length) {
    return Center(
      child: Text(
        'QTY: $length/${mPartMap[mPartNumber].mQuantity}',
        style: TextStyle(
            fontFamily: AssetsConstants.OPEN_SANS_LIGHT,
            fontStyle: FontStyle.normal,
            color: Colors.grey),
      ),
    );
  }

  Widget rbNext() {
    return CustomRaisedButton(
      text: 'NEXT',
      buttonColor: Colors.blue,
      textColor: Colors.white,
      onPress: () {
        onNext();
      },
    );
  }

  Widget rbFinish() {
    return CustomRaisedButton(
      text: 'FINISH',
      buttonColor: Colors.blue,
      textColor: Colors.white,
      onPress: () {
        onFinish();
      },
    );
  }

  onNext() async {
    Map scanDetails = await NavigationUtils.push(
        context,
        PartNumberScanView(
            mQuantity, mPartMap, mPartNumberDetailsMap));

    if (scanDetails != null &&
        scanDetails.containsKey("partserialnumberdetails")) {
      PartSerialNumberDetailsModel partSerialNumberDetails =
          PartSerialNumberDetailsModel();
      partSerialNumberDetails = scanDetails["partserialnumberdetails"];
      mSerialNumber = scanDetails["serialNumber"];
      mQuantity = scanDetails["quantity"];
      if (await mPartNumberScanDetailBloc.isSerialAvailableInPartNoMap(
              mSerialNumber, mPartNumberDetailsMap) &&
          partSerialNumberDetails.mPartTypeId == "PATM-2") {
        mPartNumberScanDetailBloc.showProgress(false);
        CustomAlerts.showAlert(context, "Already scanned this serial number");
      } else if (partSerialNumberDetails.mPickStatus ==
          BusinessConstants.PICKING_INVALID_SERIAL_NUMBER) {
        mPartNumberScanDetailBloc.showProgress(false);
        CustomAlerts.showAlert(
            context, BusinessConstants.STR_INVALID_SERIAL_NUMBER);
      } else if (await mPartNumberScanDetailBloc.getRemainingQtyAvailable(
              mQuantity,
              mSerialNumber,
              mPartNumberDetailsMap,
              partSerialNumberDetails.mPartNumber,
              mPartMap[partSerialNumberDetails.mPartNumber]?.mPartTypeMaster,
              partSerialNumberDetails) >
          (mPartMap[partSerialNumberDetails.mPartNumber]?.mQuantity ?? 0)) {
        mPartNumberScanDetailBloc.showProgress(false);
        CustomAlerts.showAlert(
            context, "Requested quantity is greater than required");
      } else if (partSerialNumberDetails.mPickQty != null &&
         await getTotalQty(
              mSerialNumber,
              partSerialNumberDetails.mPartNumber,
              mPartMap,
              mPartNumberDetailsMap,
              partSerialNumberDetails.mPickQty,
              mQuantity)) {
        mPartNumberScanDetailBloc.showProgress(false);
        CustomAlerts.showAlert(context,
            "${partSerialNumberDetails.mPartSerialNo} has ${partSerialNumberDetails.mPickQty != 0 ? mPartNumberScanDetailBloc.isSerialAvailableInPartNoMap(partSerialNumberDetails.mPartSerialNo, mPartNumberDetailsMap) ? (getRemainingQty(partSerialNumberDetails.mPickQty, partSerialNumberDetails.mPartNumber)) : (partSerialNumberDetails.mPickQty) : 'no'} parts available");
      } else if (partSerialNumberDetails.mPickStatus ==
          BusinessConstants.PICKING_REQUESTED_QUANTITY_NOT_AVAILABLE) {
        mPartNumberScanDetailBloc.showProgress(false);
        CustomAlerts.showAlert(context,
            BusinessConstants.STR_PICKING_REQUESTED_QUANTITY_NOT_AVAILABLE);
      } else {
        onUpdateSerialNumber(partSerialNumberDetails,partType: scanDetails["partType"]);
      }
    }
  }

  onFinish() {
    if (mPartNumberScanDetailBloc.isTotalPartsForPartNumberAndPartSerialEqual(
        mPartMap, mPartNumberDetailsMap)) {
      NavigationUtils.push(
          context, PartNumberActionView(mPartNumberDetailsMap.values.toList()));
    } else {
      showValidationAlertDialog(
          "Pending parts",
          mPartNumberScanDetailBloc.getRemainingQtyInText(
              mPartMap, mPartNumberDetailsMap));
    }
  }

  void getPartSerialBarCodeDetails() async {
    this.function = getPartSerialBarCodeDetails;
    mSerialNumber = "";
    mQuantity = 0;
    mSerialNumber = await BarCodeScanner.barcodeScanning(
      context: context,
    );

    if (mSerialNumber == BaseConstants.STR_CANCELLED ||
        mSerialNumber == BaseConstants.STR_PERMISSION_NOT_GRANTED ||
        mSerialNumber == BaseConstants.STR_RECAPTURE_BARCODE) {
      CustomToast.showToast(mSerialNumber);
    } else {
      validateSerialNumber(mSerialNumber, mQuantity);
    }
  }

  validateSerialNumber(String barCode, int quantity) async {
    if (await Utility.onCheckNetworkConnection()) {
      PartSerialNumberDetailsModel partSerialNumberDetails =
          PartSerialNumberDetailsModel();
      partSerialNumberDetails = await mPartNumberScanDetailBloc
          .getSerialNumberValidation(barCode, quantity);
      if (!partSerialNumberDetails.mError) {
        if (mPartNumberScanDetailBloc.isSerialAvailableInPartNoMap(
                mSerialNumber, mPartNumberDetailsMap) &&
            partSerialNumberDetails.mPartTypeId == "PATM-2") {
          mPartNumberScanDetailBloc.showProgress(false);
          CustomAlerts.showAlert(context, "Already scanned this serial number");
        } else if (partSerialNumberDetails.mPickStatus ==
            BusinessConstants.PICKING_INVALID_SERIAL_NUMBER) {
          mPartNumberScanDetailBloc.showProgress(false);
          CustomAlerts.showAlert(
              context, BusinessConstants.STR_INVALID_SERIAL_NUMBER);
        }/* else if (await mPartNumberScanDetailBloc.getRemainingQtyAvailable(
                mQuantity,
                mSerialNumber,
                mPartNumberDetailsMap,
                partSerialNumberDetails.mPartNumber,
                mPartMap[partSerialNumberDetails.mPartNumber]?.mPartTypeMaster,
                partSerialNumberDetails) >
            (mPartMap[partSerialNumberDetails.mPartNumber]?.mQuantity ?? 0)) {
          mPartNumberScanDetailBloc.showProgress(false);
          CustomAlerts.showAlert(
              context, "Requested quantity is greater than required");
        }*/ else if (partSerialNumberDetails.mPickQty != null &&
           await getTotalQty(
                mSerialNumber,
                partSerialNumberDetails.mPartNumber,
                mPartMap,
                mPartNumberDetailsMap,
                partSerialNumberDetails.mPickQty,
                mQuantity)) {
          mPartNumberScanDetailBloc.showProgress(false);
          CustomAlerts.showAlert(context,
              "${partSerialNumberDetails.mPartSerialNo} has ${partSerialNumberDetails.mPickQty != 0 ? mPartNumberScanDetailBloc.isSerialAvailableInPartNoMap(partSerialNumberDetails.mPartSerialNo, mPartNumberDetailsMap) ? (getRemainingQty(partSerialNumberDetails.mPickQty, partSerialNumberDetails.mPartNumber)) : (partSerialNumberDetails.mPickQty) : 'no'} parts available");
        } else if (partSerialNumberDetails.mPickStatus ==
            BusinessConstants.PICKING_REQUESTED_QUANTITY_NOT_AVAILABLE) {
          mPartNumberScanDetailBloc.showProgress(false);
          CustomAlerts.showAlert(context,
              BusinessConstants.STR_PICKING_REQUESTED_QUANTITY_NOT_AVAILABLE);
        } else if (mQuantity == 0) {
          validateWithPartNumber(partSerialNumberDetails);
          mPartNumberScanDetailBloc.showProgress(false);
        } else {
          onUpdateSerialNumber(partSerialNumberDetails);
        }
      }
    } else {
      CustomToast.showToast(BaseConstants.STR_NO_INTERNET);
    }
  }

  onUpdateSerialNumber(
      PartSerialNumberDetailsModel partSerialNumberDetails,{String partType}) async {
    if (!mPartNumberDetailsMap
        .containsKey(partSerialNumberDetails.mPartNumber)) {
      mPartNumberDetailsMap
        ..putIfAbsent(partSerialNumberDetails.mPartNumber, () {
          return []..add(PostDispatchMasterDetailsModel(
              mReqQty: mPartMap[partSerialNumberDetails.mPartNumber].mQuantity,
              mPartSerialNo: mSerialNumber,
              mPartMasterId: partSerialNumberDetails.mPartMasterId,
              mPartNumber: partSerialNumberDetails.mPartNumber,
              mPickQty: partSerialNumberDetails.mPartTypeCode=="V"?mQuantity:1,
              mBinLabel: partSerialNumberDetails.mBinLabel));
        });
    } else {
     await mPartNumberDetailsMap.update(partSerialNumberDetails.mPartNumber, (v) {
        if (mPartMap[partSerialNumberDetails.mPartNumber].mPartTypeMaster ==
            "NV") {
          return v
            ..add(PostDispatchMasterDetailsModel(
                mReqQty:
                    mPartMap[partSerialNumberDetails.mPartNumber].mQuantity,
                mPartSerialNo: mSerialNumber,
                mPartMasterId: partSerialNumberDetails.mPartMasterId,
                mPartNumber: partSerialNumberDetails.mPartNumber,
                mPickQty: 1,
                mBinLabel: partSerialNumberDetails.mBinLabel));
        }
        else if (!mPartNumberScanDetailBloc.isSerialAvailableInPartNoMap(
            mSerialNumber, mPartNumberDetailsMap)) {
          return v
            ..add(PostDispatchMasterDetailsModel(
                mReqQty:
                    mPartMap[partSerialNumberDetails.mPartNumber].mQuantity,
                mPartSerialNo: mSerialNumber,
                mPartMasterId: partSerialNumberDetails.mPartMasterId,
                mPartNumber: partSerialNumberDetails.mPartNumber,
                mPickQty: mQuantity,
                mBinLabel: partSerialNumberDetails.mBinLabel));
        } else {
          return  mPartNumberScanDetailBloc.getPartsTotalList(
            mSerialNumber,
            mQuantity,
            mPartNumberDetailsMap[partSerialNumberDetails.mPartNumber],
          );
        }
      });
    }
    mPartNumber = partSerialNumberDetails.mPartNumber;
    mPartNumberScanDetailBloc.onSetPartNumberScannedResult(mSerialNumber);
    mReqQty = mPartNumberDetailsMap[mPartNumber].first.mReqQty.toString() ?? "";
    mPartNumberScanDetailBloc.showProgress(false);
  }

  validateWithPartNumber(PartSerialNumberDetailsModel model) {
    if (mPartMap[model.mPartNumber] != null) {
      if (model.mPartTypeCode == BusinessConstants.STR_V_PART) {
        dialogQty();
      } else {
        mQuantity = 1;
        validateSerialNumber(mSerialNumber, mQuantity);
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
            color: BaseConstants.DARK_BLUE_WHALE,
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
            Navigator.pop(context);
            validateSerialNumber(
                mSerialNumber,
                mQuantity +
                    (mPartNumberScanDetailBloc.isSerialAvailableInPartNoMap(
                            mSerialNumber, mPartNumberDetailsMap)
                        ? mPartNumberScanDetailBloc.getTotalParts(
                            mSerialNumber, mPartNumberDetailsMap)
                        : 0));
          },
        )
      ],
    );
  }

  rbYes() {
    return CustomRaisedButton(
      isCircularBorder: true,
      text: "Ok",
      buttonColor: Colors.blue,
      textColor: Colors.white,
      isWrap: true,
      onPress: () {
        Navigator.pop(context);
        NavigationUtils.push(context,
            PartNumberActionView(mPartNumberDetailsMap.values.toList()));
      },
    );
  }

  bool getTotalQty(
      String serialNo,
      String partNo,
      LinkedHashMap<String, PostPartMasterDetailsModel> partNoMap,
      LinkedHashMap<String, List<PostDispatchMasterDetailsModel>> map,
      int pickQty,
      int data) {
    bool isExist = false;
    int count = 0;
    int totPickQty = 0;

    if (partNoMap.containsKey(partNo)) {
      map.values.forEach((m) {
        m.forEach((v) {
          if (serialNo == v.mPartSerialNo) {
            count = count + v.mPickQty;
          }
          if (partNo == v.mPartNumber) {
            totPickQty = totPickQty + v.mPickQty;
          }
        });
      });

      if (totPickQty < mPartMap[partNo].mQuantity) {
        count = count + data;
        if (count == pickQty) {
          isExist = false;
        } else if (count > pickQty) {
          isExist = true;
        } else
          isExist = false;
      }
    }
    return isExist;
  }

  int getRemainingQty(int pickQty, String partNo) {
    int total = 0;
    int quantity = 0;
    quantity = mPartNumberScanDetailBloc.getPartNoSerialQty(
        mSerialNumber, mPartNumberDetailsMap[partNo]);

    if (pickQty > quantity) {
      total = pickQty - quantity;
    } else if (quantity > pickQty) {
      total = quantity - pickQty;
    } else {
      total = pickQty - quantity;
    }
    return total;
  }

  showValidationAlertDialog(String title, List validationMsg) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Container(
            width: double.infinity,
            child: AlertDialog(
                title: Row(
                  children: <Widget>[
                    Expanded(child: Text("$title")),
                    IconButton(
                      alignment: Alignment.topLeft,
                      icon: Icon(
                        Icons.close,
                        color: Colors.blue[900],
                      ),
                      iconSize: 18,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                backgroundColor: Colors.white,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: validationMsg.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Text(
                            "${validationMsg[index]}",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          );
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    rbYes()
                  ],
                )),
          );
        });
  }
}
