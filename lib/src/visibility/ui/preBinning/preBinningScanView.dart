import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:tvs_visibility/src/visibility/bloc/preBinning/preBinningScanBloc.dart';
import 'package:tvs_visibility/src/visibility/model/preBinning/PreBinningScanRequestModel.dart';
import 'package:tvs_visibility/src/visibility/ui/preBinning/preBinningScanContract.dart';
import 'package:tvs_visibility/src/visibility/utililty/utils.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customview/customtoast.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/baseconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/barcodescanner/barcodescanner.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customraisedbutton.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customtextfield.dart';

class PreBinningScanView extends StatefulWidget {
  @override
  PreBinningScanViewState createState() => PreBinningScanViewState();
}

class PreBinningScanViewState extends State<PreBinningScanView>
    implements PreBinningScanContract {
  PreBinningScanBloc mPreBinningScanBloc;

  TextEditingController serialNoTC = new TextEditingController();

  PreBinningScanRequestModel preBinningScanModel;

  bool mEnableSubmit = false;

  Function mOnRetry;

  String mScannedBinOrPart = '';

  String result;

  PreBinningScanViewState() {
    var container = kiwi.Container();
    mPreBinningScanBloc = container<PreBinningScanBloc>();
    mPreBinningScanBloc.mView = this;
  }

  @override
  void dispose() {
    mPreBinningScanBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
        initialData: false,
        stream: mPreBinningScanBloc.isLoad,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && !snapshot.data)
            return WillPopScope(
                onWillPop: () async {
                  Navigator.pop(context, result);
                  return false;
                },
                child: Scaffold(
                    backgroundColor: Colors.black26,
                    body: Center(
                      child: Card(
                          margin: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                height: 60,
                                width: double.maxFinite,
                                decoration: new BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: new BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10))),
                                child: Container(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: Text(
                                        "        Scan Serial No",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      )),
                                      IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          result = getResult;
                                          Navigator.pop(context, result);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.all(5),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.all(30.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        binOrLPN(),
                                        Container(
                                          height: 30,
                                        ),
                                        rbSubmit()
                                      ],
                                    ),
                                  ))
                            ],
                          )),
                    )));
        });
  }

  Widget binOrLPN() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
            child: CustomTextField(
          hint: 'Enter Serial No',
          inputType: TextInputType.text,
          isTitleRequired: false,
          controller: serialNoTC,
          onChanged: (str) {
            mEnableSubmit = serialNoTC.text.trim().length != 0;
            mPreBinningScanBloc.showProgress(false);
          },
        )),
        Container(
          width: 20,
        ),
        iconCamera(),
      ],
    );
  }

  Widget iconCamera() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        serialNoTC.clear();
        onScanBinOrPart();
      },
      child: Image(
        image: AssetImage(BaseConstants.IMAGES_CAMERA),
        height: 35,
        width: 35,
      ),
    );
  }

  Widget rbSubmit() {
    return CustomRaisedButton(
      text: 'Submit',
      buttonColor: mEnableSubmit ? Colors.blue : Colors.grey,
      textColor: Colors.white,
      onPress: mEnableSubmit
          ? () {
              setSerialNo = serialNoTC.text;
              mPreBinningScanBloc.submitParts();
              FocusScope.of(context).requestFocus(FocusNode());
            }
          : () {
              setSerialNo = serialNoTC.text;
              CustomToast.showToast("Enter Serial No");
              FocusScope.of(context).requestFocus(FocusNode());
            },
    );
  }

  onScanBinOrPart() async {
    mScannedBinOrPart = await BarCodeScanner.barcodeScanning(
        context: context, isVisibility: true);

    if ((mScannedBinOrPart != BaseConstants.STR_CANCELLED) &&
        (mScannedBinOrPart != BaseConstants.STR_PERMISSION_NOT_GRANTED) &&
        (mScannedBinOrPart != BaseConstants.STR_RECAPTURE_BARCODE)) {
      if (Utils.regexCompare(mScannedBinOrPart)) {
        CustomToast.showToast(
            "${BaseConstants.STR_RECAPTURE_BARCODE}: $mScannedBinOrPart");
      } else {
        serialNoTC.text = mScannedBinOrPart;
        mEnableSubmit = true;
        mPreBinningScanBloc.submitParts();
        FocusScope.of(context).requestFocus(FocusNode());
      }
    } else {
      CustomToast.showToast(mScannedBinOrPart);
    }
  }

  @override
  String get getSerialNo {
    return serialNoTC.text;
  }

  @override
  void set setSerialNo(String serialNo) {
    serialNoTC.text = serialNo;
  }

  @override
  void set setRetry(Function retry) {
    mOnRetry = retry;
  }

  @override
  String get getResult {
    return result;
  }

  @override
  void set setResult(String result) {
    this.result = result;
  }

  @override
  clearSerialNo() {
    serialNoTC.clear();
    return null;
  }

  @override
  bool get getmEnableSubmit {
    return mEnableSubmit;
  }

  @override
  void set setmEnableSubmit(bool mEnableSubmit) {
    this.mEnableSubmit = mEnableSubmit;
  }
}
