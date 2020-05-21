import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:tvs_visibility/src/visibility/bloc/binningbloc/binscanbloc.dart';
import 'package:tvs_visibility/src/visibility/constants/businessconstants.dart';
import 'package:tvs_visibility/src/visibility/model/binmodel/binvalidationresult.dart';
import 'package:tvs_visibility/src/visibility/ui/binning/binningscancontract.dart';
import 'package:tvs_visibility/src/visibility/utililty/utils.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customalerts/customalerts.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customprogressindicator/customprogress.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customprogressindicator/customretry.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customview/custompdfview.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customview/customtoast.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/assetsconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/baseconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/barcodescanner/barcodescanner.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customraisedbutton.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customtext.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customtextfield.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customtextview.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/navigaton/navigationutils.dart';

import '../homeview.dart';

class BinScanView extends StatefulWidget {
  BinScanView();

  @override
  State<StatefulWidget> createState() {
    return BinScanViewState();
  }
}

class BinScanViewState extends State<BinScanView> implements BinScanViewContract{
  BinScanBloc mScanBloc;
  bool mInvalidBinOrPart=true;
  bool mScannedBinAndPart = false;
  bool mScanBinOrPart=false;
  bool skipLabelGeneration = true;
  BinValidationResult mValidationResult=BinValidationResult();
  String mValidationContent = '';
  String mSerialLabel = 'BIN NO.';
  String mBinId;
  String mBinLabel;
  TextEditingController tecNoOfLabel = new TextEditingController();
  TextEditingController tecBinOrLPN = new TextEditingController();
  TextEditingController tecVPartQuantity = TextEditingController();
  String mWareHouseInBoundId;
  int mBinTypeId;
  String mPartLPN;
  bool mBinScanned=false;
  String mVPartsQtyExists;
  bool mVPartType=false;
  String mScannedBinOrPart = '';
  String mBinTypeMasterId = '0';
  int mClientExcessOrShortStatus=4;

  bool mEnableSubmit=false;
  Function mOnRetry;

  BinScanViewState() {
    var container = kiwi.Container();
    mScanBloc = container<BinScanBloc>();
    mScanBloc.mView=this;
  }

  @override
  void initState() {
    if (Utils.isEmpty(mBinId))
       mValidationContent = "Please Scan the Bin Now";
    super.initState();
  }

  @override
  void dispose() {
    mScanBloc.dispose();
    tecVPartQuantity.dispose();
    super.dispose();
  }

  void clearAll() {
    mScannedBinOrPart = null;
    tecBinOrLPN.clear();
    tecVPartQuantity.clear();
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
        initialData: false,
        stream: mScanBloc.isLoad,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && !snapshot.data)
            return Scaffold(
              appBar: AppBar(
                title: Text('Awaiting Binning'),
              ),
              body: SingleChildScrollView(child: Column(children: <Widget>[
                Container(
                  margin: EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      CustomTextView(
                        title: "Customer Reference",
                        text: mValidationResult.mCustomerReference ?? '-',
                      ),
                      CustomTextView(
                        title: "Part Number",
                        text: mValidationResult.mPartNumber ?? '-',
                      ),
                      CustomTextView(
                        title: "Scanned",
                        text: mValidationResult.mTotalQuantity!=null && mValidationResult.mTotalQuantity!=0?'${mValidationResult.mBinnedQuantity ?? 0}/' + '${mValidationResult.mTotalQuantity}':"-",
                      ),
                      SizedBox(height: 10,),
                      CustomText(text: "${!Utils.isEmpty(mValidationContent)?mValidationContent:"Please scan Bin/LPN"}",fontFamily: AssetsConstants.OPEN_SANS_SEMI_BOLD,
                        fontSize: 18,textAlign: TextAlign.center,
                        textColor: mInvalidBinOrPart == true
                            ? Colors.redAccent
                            : Colors.green,),
                      SizedBox(height: 10,),
                      CustomTextView(
                        title: "Bin Name",
                        text: '${mBinLabel??"-"}',
                      ),
                      (!Utils.isEmpty(mValidationResult?.mPartsMasterDTO?.mActorId) && mValidationResult?.mPartsMasterDTO?.mActorId == BusinessConstants.Actor_Type_Id_Dealer &&
                          skipLabelGeneration &&
                          (mValidationResult?.mPartsMasterDTO?.mPartTypesMasterIdName == BusinessConstants.STR_VARIABLE_PART))
                          ? textLabel(): visibilityBinning()
                    ],
                  ),
                )
              ],),),
              bottomNavigationBar:
              (!Utils.isEmpty(mValidationResult?.mPartsMasterDTO?.mActorId) && mValidationResult?.mPartsMasterDTO?.mActorId == BusinessConstants.Actor_Type_Id_Dealer &&
                  skipLabelGeneration &&
                  (mValidationResult?.mPartsMasterDTO?.mPartTypesMasterIdName == BusinessConstants.STR_VARIABLE_PART))?
              Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                Expanded(child: rbPrint()),
                SizedBox(width: 5,),
                Expanded(child: rbSkip())
              ],):
              Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                Expanded(child: rbSubmit()),
                mValidationResult?.mPartsMasterDTO?.mPartTypesMasterIdName == BusinessConstants.STR_VARIABLE_PART?SizedBox(width: 5,):Container(height: 0,),
                mValidationResult?.mPartsMasterDTO?.mPartTypesMasterIdName == BusinessConstants.STR_VARIABLE_PART? Expanded(child: rbShort()):Container(height: 0,)
              ],),
            );
          else if (snapshot.hasError)
            return Scaffold(backgroundColor: Colors.white,body: CustomRetry(retry: mOnRetry,),);
           else
            return CustomProgress();
        });
  }

  Widget binOrLPN() {
    return Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
      Flexible(child: CustomTextField(
        hint: 'Enter Bin/LPN',
        inputType: TextInputType.text,enable: !(((mValidationResult?.mPartsMasterDTO?.mActorId == BusinessConstants.Actor_Type_Id_Dealer) || mValidationResult?.mPartsMasterDTO?.mPartTypesMasterIdName == BusinessConstants.STR_VARIABLE_PART) && mBinScanned && mVPartType),
        title: 'Bin/LPN',
        isTitleRequired: true,
        controller: tecBinOrLPN,
        onChanged: (str){
          mEnableSubmit=tecBinOrLPN.text.length!=0;
          mScanBloc.showProgress(false);
        },
      )),
      (((mValidationResult?.mPartsMasterDTO?.mActorId == BusinessConstants.Actor_Type_Id_Dealer) || mValidationResult?.mPartsMasterDTO?.mPartTypesMasterIdName == BusinessConstants.STR_VARIABLE_PART) && mBinScanned && mVPartType)?
      IconButton(padding: EdgeInsets.only(top: 25),icon: Icon(Icons.cancel,color: Colors.grey,), onPressed: (){
        if(mBinScanned & !Utils.isEmpty(tecBinOrLPN.text)){
          tecBinOrLPN.clear();
          mScannedBinOrPart="";
          mVPartType=false;
          mScannedBinAndPart=false;
          mValidationContent="Please scan the Bin/LPN";
          mInvalidBinOrPart=true;
          mEnableSubmit=false;
          tecVPartQuantity.clear();
          mValidationResult=BinValidationResult();
          mScanBloc.showProgress(false);
        }
      }):Container()
    ],);
  }

  Widget quantity() {
    return
      (((!Utils.isEmpty(mValidationResult?.mPartsMasterDTO?.mActorId) && mValidationResult?.mPartsMasterDTO?.mActorId == BusinessConstants.Actor_Type_Id_Dealer) || mValidationResult?.mPartsMasterDTO?.mPartTypesMasterIdName == BusinessConstants.STR_VARIABLE_PART) && mBinScanned && mVPartType)?
      CustomTextField(
      hint: 'Enter Quantity',
      numbersOnly: true,
      inputType: TextInputType.number,
      title: 'Quantity',
      isTitleRequired: true,
      controller: tecVPartQuantity,
      onChanged: (str){
        mEnableSubmit=tecVPartQuantity.text.length!=0 && int.parse(tecVPartQuantity.text)!=0;
        mScanBloc.showProgress(false);
      },):Container();
  }

  Widget rbSubmit() {
    return CustomRaisedButton(
      text: 'Submit',
      buttonColor: (((!Utils.isEmpty(mValidationResult?.mPartsMasterDTO?.mActorId) && mValidationResult?.mPartsMasterDTO?.mActorId ==
          BusinessConstants.Actor_Type_Id_Dealer) ||
          mValidationResult?.mPartsMasterDTO?.mPartTypesMasterIdName == BusinessConstants.STR_VARIABLE_PART)  &&
          mBinScanned &&
          !Utils.isEmpty(tecVPartQuantity.text) && int.parse("${tecVPartQuantity.text??"0"}")!=0) || !Utils.isEmpty(tecBinOrLPN.text)?
      Colors.blue:Colors.grey,
      textColor: Colors.white,
      onPress: mEnableSubmit
          ? () {
        if (!Utils.isEmpty(mValidationResult?.mPartsMasterDTO?.mActorId) && mValidationResult?.mPartsMasterDTO?.mActorId ==
            BusinessConstants.Actor_Type_Id_Dealer) {
          mScanBloc.onProcessBinOrPartForDealer();
        } else if(mScannedBinAndPart){
          mScanBloc.submitVParts();
        }else{
          mScanBloc.onProcessBinOrPart();
        }
      } : null,
    );
  }

  Widget rbShort() {
    return CustomRaisedButton(
      text: 'Short',
      buttonColor: tecVPartQuantity.text.length!=0?Colors.blue:Colors.grey,
      textColor: Colors.white,
      onPress: tecVPartQuantity.text.length!=0?() {
        mClientExcessOrShortStatus=2;
        mScanBloc.submitVParts();
        }:null,
    );
  }

  Widget rbPrint() {
    return CustomRaisedButton(
      text: 'Print',
      buttonColor: tecNoOfLabel.text.length != 0 ?Colors.lightBlueAccent: Colors.grey,
      textColor: Colors.white,
      onPress: tecNoOfLabel.text.length != 0 ? () {
        mScanBloc.createHQLabel(int.parse(tecNoOfLabel.text));
      }:(){},
    );
  }

  Widget rbSkip() {
    return CustomRaisedButton(
      text: 'Skip',
      buttonColor: tecNoOfLabel.text.length == 0 ?Colors.lightBlueAccent: Colors.grey,
      textColor: Colors.white,
      onPress: tecNoOfLabel.text.length == 0 ? () {
        skipLabelGeneration = false;
        mValidationContent = "Please Scan the Bin Now";
        mScanBloc.showProgress(false);
      }:(){
      },
    );
  }

  Widget textLabel(){
    return CustomTextField(
      hint: 'Enter No.of Label',
      numbersOnly: true,
      inputType: TextInputType.number,
      title: 'Number Of Label',
      isTitleRequired: true,
      controller: tecVPartQuantity,
      onChanged: (str){
        mEnableSubmit=tecVPartQuantity.text.length!=0;
        mScanBloc.showProgress(false);
      },
      maxLength: 10,
    );
  }

  visibilityBinning(){
    return Column(children: <Widget>[
      binOrLPN(),
      quantity(),
      SizedBox(height: 20,),
      iconCamera()
    ],);
  }

  Widget iconCamera(){
    return !(((!Utils.isEmpty(mValidationResult?.mPartsMasterDTO?.mActorId) && mValidationResult?.mPartsMasterDTO?.mActorId == BusinessConstants.Actor_Type_Id_Dealer) || mValidationResult?.mPartsMasterDTO?.mPartTypesMasterIdName == BusinessConstants.STR_VARIABLE_PART) && mBinScanned && mVPartType)?
    GestureDetector(
      onTap: () {
        tecBinOrLPN.clear();
        (!Utils.isEmpty(mValidationResult?.mPartsMasterDTO?.mActorId) && mValidationResult?.mPartsMasterDTO?.mActorId == BusinessConstants.Actor_Type_Id_Dealer)
            ? scanBinOrPartForDealer()
            : onScanBinOrPart();
      },
      child: Image(image: AssetImage(BaseConstants.IMAGES_CAMERA)),
    ):Container();
  }

  onScanBinOrPart() async{
    mScannedBinOrPart =await BarCodeScanner.barcodeScanning(context: context,isVisibility: true);

    if ((mScannedBinOrPart != BaseConstants.STR_CANCELLED) && (mScannedBinOrPart != BaseConstants.STR_PERMISSION_NOT_GRANTED) && (mScannedBinOrPart!=BaseConstants.STR_RECAPTURE_BARCODE) ) {
      CustomToast.showToast(mScannedBinOrPart);
      if (Utils.regexCompare(mScannedBinOrPart)) {
        CustomToast.showToast("${BaseConstants.STR_RECAPTURE_BARCODE}: $mScannedBinOrPart");
      }else{
        tecBinOrLPN.text=mScannedBinOrPart;
        mScanBloc.onProcessBinOrPart();
      }
    }else{
      CustomToast.showToast(mScannedBinOrPart);
    }
  }

  scanBinOrPartForDealer() async{
    mScannedBinOrPart= await BarCodeScanner.barcodeScanning(context: context,isVisibility: true);

    if ((mScannedBinOrPart != BaseConstants.STR_CANCELLED) && (mScannedBinOrPart != BaseConstants.STR_PERMISSION_NOT_GRANTED) && (mScannedBinOrPart!=BaseConstants.STR_RECAPTURE_BARCODE) ) {
      CustomToast.showToast(mScannedBinOrPart);
      if (Utils.regexCompare(mScannedBinOrPart))
        CustomToast.showToast("${BaseConstants.STR_RECAPTURE_BARCODE}: $mScannedBinOrPart");
      else {
        tecBinOrLPN.text=mScannedBinOrPart;
        mScanBloc.onProcessBinOrPartForDealer();
      }
    }else{
      CustomToast.showToast(mScannedBinOrPart);
    }
  }

  onPartsLabelGenerated(String labels) {
    var data = NavigationUtils.push(context, MyPdfView(
      path: labels,
      title: 'PDF Viewer',
    ));
    data.whenComplete(() {navigateToHomeView();});
  }

  @override
  set setScanBinOrPart(bool scanBinOrPart){
    mScanBinOrPart=scanBinOrPart;
  }

  @override
  set setScannedBinAndPart(bool scannedBinAndPart){
    mScannedBinAndPart=scannedBinAndPart;
  }

  @override
  set setInValidBinOrPart(bool invalidBinOrPart){
    mInvalidBinOrPart=invalidBinOrPart;
  }

  @override
  setValidationContent(String validationContent,bool isInvalid){
    mValidationContent=validationContent;
    mInvalidBinOrPart=isInvalid;
  }

  @override
  set setSerialLabel(String serialLabel){
    mSerialLabel=serialLabel;
  }

  @override
  set setBinLabel(String binLabel){
    mBinLabel=binLabel;
  }

  @override
  set setBinScanned(bool binScanned){
    mBinScanned=binScanned;
  }

  @override
  set setVPartsQtyExist(String vPartQtyExist){
    mVPartsQtyExists=vPartQtyExist;
  }

  @override
  set setScannedBinOrPart(String scannedBinOrPart){
    mScannedBinOrPart=scannedBinOrPart;
  }

  @override
  set setBinTypeMasterId(String binTypeMasterId){
    mBinTypeMasterId=binTypeMasterId;
  }

  @override
  set setEnableSubmit(bool enableSubmit){
    mEnableSubmit=enableSubmit;
  }

  @override
  set setWarehouseInboundId(String wareHouseInboundId){
    mWareHouseInBoundId=wareHouseInboundId;
  }

  @override
  set setInvalidBinOrPart(bool inValid){
    mInvalidBinOrPart=inValid;
  }

  @override
  set setVPartType(bool type){
    mVPartType=type;
  }

  @override
  set setBinTypeId(int typeId){
    mBinTypeId=typeId;
  }

  @override
  set setBinId(String binId){
    mBinId=binId;
  }

  @override
  set setRetry(Function retry){
    mOnRetry=retry;
  }

  @override
  set setPartLPN(String partLPN){
    mPartLPN=partLPN;
  }

  @override
  set setBinValidationResult(BinValidationResult model){
    mValidationResult=model;
  }

  get getBinValidationResult{
    return mValidationResult;
  }

  @override
  set setTecNoOfLabel(String label){
    tecNoOfLabel.text=label;
  }

  @override
  set setTecVPartQuantity(String qty){
    tecVPartQuantity.text=qty;
  }

  @override
  set setTecBinOrLPN(String binOrLPN){
    tecBinOrLPN.text=binOrLPN;
  }

  @override
  get getPartLPN{
    return mPartLPN;
  }

  @override
  get getBinId{
    return mBinId;
  }

  @override
   get getBinLabel{
    return mBinLabel;
  }

  @override
  TextEditingController get getTecNoOfLabel{
    return tecNoOfLabel;
  }

  @override
  TextEditingController get getTecBinOrLPN{
    return tecBinOrLPN;
  }

  @override
  TextEditingController get getTecVPartQuantity{
    return tecVPartQuantity;
  }

  @override
  get getBinScanned{
    return mBinScanned;
  }

  @override
  get getScannedBinOrPart{
    return mScannedBinOrPart;
  }

  @override
  get getBinTypeId{
  return mBinTypeId;
  }

  @override
  navigateToHomeView() {
    return NavigationUtils.pushReplacement(context, HomeView());
  }

  @override
  get getVPartsQtyExists => mVPartsQtyExists;

  @override
  get getWarehouseInboundId{
    return mWareHouseInBoundId;
  }

  @override
  get getBinTypeMasterId{
    return mBinTypeMasterId;
  }

  alertDialogOnAllPartsBinned(String alertMsg){
    CustomAlerts.showAlertWithFunctionAction(context, alertMsg, () {
      Navigator.pop(context);
    });
  }

  alertDialogOnLabelGenerated(String alertMsg,String label){
    CustomAlerts.showAlertWithFunctionAction(context, alertMsg, () {
      onPartsLabelGenerated(label);
    });
  }

  @override
  alertDialogForExcess() {
    CustomAlerts.showAlertWithOkCancel(context, BusinessConstants.STR_BINNING_USER_CAN_PROCEED_TO_EXCESS,"Yes","No",(){
      mClientExcessOrShortStatus=1;
      mScanBloc.submitVParts();
    }, () {
      mClientExcessOrShortStatus=4;
    });
  }

  @override
  alertDialogForShort() {
    CustomAlerts.showAlertWithOkCancel(context, BusinessConstants.STR_BINNING_USER_CAN_PROCEED_TO_SHORT,"Yes","No",(){
      mClientExcessOrShortStatus=3;
      mScanBloc.submitVParts();
    }, () {
      mClientExcessOrShortStatus=4;
    });
  }

  @override
  alertDialog(String content) {
    CustomAlerts.showAlert(context, content);
  }


  @override
  get getClientExcessOrShortStatus{
    return mClientExcessOrShortStatus;
  }

  @override
  setClientExcessOrShortStatus(int status){
    mClientExcessOrShortStatus=status;
  }

}


