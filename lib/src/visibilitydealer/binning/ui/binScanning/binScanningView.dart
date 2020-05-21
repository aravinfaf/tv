import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:tvs_visibility/src/visibilitydealer/binning/bloc/binScanningBloc.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/model/binlocationmodel/binScanningResponse.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/ui/binScanning/binScanningViewContract.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/barcodescanner/barcodescanner.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customalerts/customalert.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/toast/customtoast.dart';

import '../../../../visibility/utililty/utils.dart';
import '../../../helper/constants/assetsconstants.dart';
import '../../../helper/constants/baseconstants.dart';
import '../../../helper/widgets/CustomRetry.dart';
import '../../../helper/widgets/customprogress.dart';
import '../../../helper/widgets/customraisedbutton.dart';
import '../../../helper/widgets/customtext.dart';
import '../../../helper/widgets/customtextfield.dart';
import '../../../helper/widgets/customtextview.dart';

class BinScanningView extends StatefulWidget {
  @override
  BinScanningViewState createState() => BinScanningViewState();
}

class BinScanningViewState extends State<BinScanningView>
    implements BinScanningViewContract {
  BinScanningBloc mScanBloc;

  bool hasError = true;

  String mValidationContent;

  BinScanningResponse mValidationResult;

  TextEditingController tecVPartQuantity = TextEditingController();

  TextEditingController tecBinOrLPN = new TextEditingController();

  bool mEnableSubmit = false;

  bool mBinScanned = false;

  bool mVPartType = false;

  bool canShowShortAlert = true;

  bool isShort = false;

  String mScannedBinOrPart = "";

  String mQuantity = "";

  Function mOnRetry;

  String mBinLabel;

  String mBinMasterId;

  String result = "";

  BinScanningViewState() {
    var container = kiwi.Container();
    mScanBloc = container<BinScanningBloc>();
    mScanBloc.mView = this;
  }

  @override
  void initState() {
    mValidationContent = "Please Scan the Bin Now";
    super.initState();
  }

  @override
  void dispose() {
    mScanBloc.dispose();
    tecVPartQuantity.dispose();
    tecBinOrLPN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
        initialData: false,
        stream: mScanBloc.isLoading,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && !snapshot.data)
            return WillPopScope(
                onWillPop: () async {
                  Navigator.pop(context, result);
                  return false;
                },
                child: Scaffold(
                    appBar: AppBar(
                      title: Text('Dealer Binning'),
                    ),
                    body: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onPanDown: (_) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(15.0),
                              child: Column(
                                children: <Widget>[
                                  CustomTextView(
                                    title: "Customer Reference",
                                    text: mValidationResult != null
                                        ? '${mValidationResult.mCustomerRef ?? "-"}'
                                        : "-",
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  CustomTextView(
                                    title: "Part Number",
                                    text: mValidationResult != null
                                        ? '${mValidationResult.mPartNumber ?? "-"}'
                                        : "-",
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  CustomTextView(
                                    title: "Scanned",
                                    text: mValidationResult != null
                                        ? "${mValidationResult.mBinnedQty} / ${mValidationResult.mPartsTotalQty}" ??
                                            "-"
                                        : "-",
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomText(
                                    text:
                                        "${!Utils.isEmpty(mValidationContent) ? mValidationContent : "Please scan Bin/LPN"}",
                                    fontFamily:
                                        AssetsConstants.OPEN_SANS_SEMI_BOLD,
                                    fontSize: 18,
                                    textAlign: TextAlign.center,
                                    textColor: hasError
                                        ? Colors.redAccent
                                        : Colors.green,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextView(
                                      title: "Bin Name",
                                      text: mBinLabel ?? "-"),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  visibilityBinning(),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    bottomNavigationBar: (getFooterWidget())));
          else if (snapshot.hasError)
            return Scaffold(
              backgroundColor: Colors.white,
              body: CustomRetry(
                retry: mOnRetry,
              ),
            );
          else
            return CustomProgress();
        });
  }

  Widget getFooterWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(child: rbSubmit()),
        mVPartType
            ? SizedBox(
                width: 5,
              )
            : Container(
                height: 0,
              ),
        mVPartType
            ? Expanded(child: rbShort())
            : Container(
                height: 0,
              )
      ],
    );
  }

  Widget rbSubmit() {
    return CustomRaisedButton(
      text: 'Submit',
      buttonColor: mEnableSubmit ? Colors.blue : Colors.grey,
      textColor: Colors.white,
      onPress: mEnableSubmit
          ? () {
              isShort = false;
              mScanBloc.validateInputsAndMakeServiceCall();
            }
          : null,
    );
  }

  Widget rbShort() {
    return CustomRaisedButton(
      text: 'Short',
      buttonColor: mEnableSubmit ? Colors.blue : Colors.grey,
      textColor: Colors.white,
      onPress: mEnableSubmit
          ? () {
              isShort = true;
              mScanBloc.validateInputsAndMakeServiceCall();
            }
          : null,
    );
  }

  visibilityBinning() {
    return Column(
      children: <Widget>[
        binOrLPN(),
        SizedBox(
          height: 20,
        ),
        quantity(),
        SizedBox(
          height: 20,
        ),
        iconCamera()
      ],
    );
  }

  Widget binOrLPN() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
            child: CustomTextField(
          hint: 'Enter Bin/LPN',
          inputType: TextInputType.text,
          enable: !(mBinScanned & mVPartType),
          title: 'Bin/LPN',
          isTitleRequired: true,
          controller: tecBinOrLPN,
          onChanged: (str) {
            mScannedBinOrPart = tecBinOrLPN.text;
            mEnableSubmit = tecBinOrLPN.text.length != 0;
            mScanBloc.showProgress(false);
          },
        )),
        (mVPartType)
            ? IconButton(
                padding: EdgeInsets.only(top: 25),
                icon: Icon(
                  Icons.cancel,
                  color: Colors.grey,
                ),
                onPressed: () {
                  if (!Utils.isEmpty(tecBinOrLPN.text)) {
                    tecBinOrLPN.clear();
                    mScannedBinOrPart = "";
                    mVPartType = false;
                    isShort = false;
                    mValidationContent = "Please scan the Bin/LPN";
                    hasError = true;
                    mEnableSubmit = false;
                    tecVPartQuantity.clear();
                    mValidationResult = null;
                    mScanBloc.showProgress(false);
                  }
                })
            : Container()
      ],
    );
  }

  Widget quantity() {
    return mBinScanned & mVPartType
        ? CustomTextField(
            hint: 'Enter Quantity',
            numbersOnly: true,
            inputType: TextInputType.number,
            title: 'Quantity',
            isTitleRequired: true,
            controller: tecVPartQuantity,
            onChanged: (str) {
              mQuantity = str;
              canShowShortAlert = true;
              mEnableSubmit = tecVPartQuantity.text.length != 0 &&
                  int.parse(tecVPartQuantity.text) != 0;
              mScanBloc.showProgress(false);
            },
          )
        : Container();
  }

  Widget iconCamera() {
    return !mVPartType
        ? GestureDetector(
            onTap: () {
              onScanBinOrPart();
            },
            child: Image(image: AssetImage(BaseConstants.IMAGES_CAMERA)),
          )
        : Container();
  }

  showCustomAlertForShort() {
    return CustomAlerts.showAlertWithCancel(
        context, "Binned quantity is short. Do you want to proceed for approval?", () {
      canShowShortAlert = false;
      mScanBloc.validateInputsAndMakeServiceCall();
    }, () {});
  }

  showCustomAlertForExcess() {
    return CustomAlerts.showAlertWithCancel(
        context, "Binned quantity is excess. Do you want to proceed for approval?", () {
      canShowShortAlert = false;
      mScanBloc.validateInputsAndMakeServiceCall();
    }, () {});
  }

  onScanBinOrPart() async {
    mScannedBinOrPart = await BarCodeScanner.barcodeScanning(
        context: context, isVisibility: true);

    if ((mScannedBinOrPart != BaseConstants.STR_CANCELLED) &&
        (mScannedBinOrPart != BaseConstants.STR_PERMISSION_NOT_GRANTED) &&
        (mScannedBinOrPart != BaseConstants.STR_RECAPTURE_BARCODE)) {
      CustomToast.showToast(mScannedBinOrPart);
      if (Utils.regexCompare(mScannedBinOrPart)) {
        CustomToast.showToast(
            "${BaseConstants.STR_RECAPTURE_BARCODE}: $mScannedBinOrPart");
        mScannedBinOrPart = "";
      } else {
        mScanBloc.validateInputsAndMakeServiceCall();
      }
      tecBinOrLPN.text = mScannedBinOrPart;
    } else {
      mScannedBinOrPart = "";
      tecBinOrLPN.text = mScannedBinOrPart;
      CustomToast.showToast(mScannedBinOrPart);
    }
  }

  @override
  get getScannedBinOrPart => mScannedBinOrPart;

  @override
  get getIsBinScanned => mBinScanned;

  @override
  get getIsVPartType => mVPartType;

  @override
  void set setIsVPartType(bool mVPartType) {
    this.mVPartType = mVPartType;
  }

  @override
  void set setScannedBinOrPart(String mScannedBinOrPart) {
    this.tecBinOrLPN.text = mScannedBinOrPart;
    this.mScannedBinOrPart = mScannedBinOrPart;
  }

  @override
  void set setIsBinScanned(bool isBinScanned) {
    this.mBinScanned = isBinScanned;
    this.mEnableSubmit = false;
  }

  @override
  get getBinScanningResponse => mValidationResult;

  @override
  void set setBinScanningResponse(BinScanningResponse response) {
    mValidationResult = response;
    this.mEnableSubmit = false;
  }

  @override
  get getMessage => mValidationContent;

  @override
  void set setMessage(String message) {
    mValidationContent = message;
  }

  @override
  void set setRetry(Function retry) {
    mOnRetry = retry;
  }

  @override
  get getQuantity => mQuantity;

  @override
  void set setShortOrExcess(String alertType) {
    if (alertType == "Excess") {
      showCustomAlertForExcess();
    } else if (alertType == "ShortException") {
      this.mValidationContent = "Short exception not allowed";
      this.hasError = true;
      mScanBloc.showProgress(false);
    } else {
      showCustomAlertForShort();
    }
  }

  @override
  get getCanShowShortAlert => canShowShortAlert;

  @override
  void set setCanShowShortAlert(bool canShowShortAlert) {
    this.canShowShortAlert = canShowShortAlert;
  }

  @override
  void set setHasError(bool hasError) {
    this.hasError = hasError;
  }

  @override
  var getShortOrExcess;

  @override
  get getIsShortClicked => isShort;

  @override
  void set setIsShortClicked(bool isShort) {
    this.isShort = isShort;
  }

  @override
  void set setQuantity(String Quantity) {
    this.tecVPartQuantity.text = Quantity;
    this.mQuantity = Quantity;
  }

  @override
  get getBinLabel => mBinLabel;

  @override
  void set setBinLabel(String binLabel) {
    this.mBinLabel = binLabel;
  }

  @override
  get getBinMasterID => mBinMasterId;

  @override
  void set setBinMasterId(String binMasterId) {
    this.mBinMasterId = binMasterId;
  }

  @override
  String get getResult {
    return result;
  }

  @override
  void set setResult(String result) {
    this.result = result;
  }
}
