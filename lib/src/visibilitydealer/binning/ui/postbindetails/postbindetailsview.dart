import 'package:tvs_visibility/src/visibility/ui/homeview.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/bloc/postbindetailsbloc.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/model/partorbinvalidationmodel/partorbinvalidationmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/model/postbindetailsmodel/postbindetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/assetsconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/baseconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/businessconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/utility/utils.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/CustomRetry.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/barcodescanner/barcodescanner.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customalerts/customalert.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customprogress.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customraisedbutton.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customtextformfield.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/navigaton/navigationutils.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/toast/customtoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class PostBinDetailsView extends StatefulWidget{
  String mOrderId;
  String mPartsInOrderId;
  String mPartType;
  String mPartNumber;

  PostBinDetailsView(this.mOrderId,this.mPartsInOrderId,this.mPartType,this.mPartNumber);

  @override
  State<StatefulWidget> createState() {
    return PostBinDetailsViewState(this.mOrderId,this.mPartsInOrderId,this.mPartType,this.mPartNumber);
  }
}

class PostBinDetailsViewState extends State<PostBinDetailsView>{
  TextEditingController tecBinOrSerialNo = new TextEditingController();
  TextEditingController tecBinNo = new TextEditingController();
  TextEditingController tecQuantity;
  final formKey = new GlobalKey<FormState>();
  final qtyFormKey = new GlobalKey<FormState>();
  PostBinDetailsBloc mPostBinDetailsBloc;
  String mOrderId;
  String mBinNumber;
  String mBinOrPart;
  int mPartSerialNumberStatus=0;
  String mPartType;
  String mPartsInOrderId;
  Function function;
  int mQuantity=0;
  String mBinOrPartResponse;
  bool mSuccess=false;
  bool isFinish=false;
  String mPartNumber;

  PostBinDetailsViewState(this.mOrderId,this.mPartsInOrderId,this.mPartType,this.mPartNumber){
    var container = kiwi.Container();
    mPostBinDetailsBloc = container<PostBinDetailsBloc>();
  }

  @override
  void dispose() {
    mPostBinDetailsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(initialData: false,stream: mPostBinDetailsBloc.isLoading,builder: (BuildContext context,AsyncSnapshot<bool> snapshot){
      if(snapshot.hasData && !snapshot.data)
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: appBar("Dealer Binning"),
          body: Container(
              margin: EdgeInsets.all(10.0),
              child: Form(
                key: formKey,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    tffBinNumber(),
                    SizedBox(height: 10,),
                    Column(children: <Widget>[
                      Center(child: Text('${mBinOrPartResponse??""}',textAlign: TextAlign.center,style: TextStyle(fontSize: 16,color: mSuccess?Colors.green:Colors.red,fontFamily: AssetsConstants.OPEN_SANS_SEMI_BOLD),),),
                    ],),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        tffBinOrSerialNumber(),
                        iconCamera(),
                      ],
                    ),
                  ],),)),
          bottomNavigationBar: mPartType==BusinessConstants.STR_V_PART?Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
            Expanded(child: rbSubmit()),
            SizedBox(width: 5,),
            Expanded(child: rbFinish())
          ],):rbSubmit(),);
      else if(snapshot.hasError)
        return Scaffold(backgroundColor: Colors.white,body: CustomRetry(retry: function,),);
      else
        return Scaffold(
          backgroundColor: Colors.white,
          body: CustomProgress(),);
    });
  }

  appBar(String module) {
    return PreferredSize(
        child: AppBar(title: Text(
          '$module', style: TextStyle(fontSize: 18.0),),
          backgroundColor: Colors.blue,),
        preferredSize: Size.fromHeight(60));
  }

  tffBinNumber(){
    return Column(children: <Widget>[
      Center(child: Text(
        'Bin Number',
        style: TextStyle(
            fontSize: 18,
            color: Colors.black38),
      ),),
      Center(child: Text("${!Utility.isEmpty(tecBinNo.text)?tecBinNo.text:' - '}",style: TextStyle(fontSize: 17),),)
    ],);
  }

  tffBinOrSerialNumber(){
    return Flexible(child: Column(children: <Widget>[
      CustomTextFormField(
        hint: 'Bin/Serial Number',
        inputType: TextInputType.text,
        title: 'Bin/Serial Number',
        isTitleRequired: true,
        controller: tecBinOrSerialNo,
        onValidate: (val) {
          return val.length == 0
              ? 'Enter or scan Bin/Serial Number'
              : Utility.validSpecialCharactersInBackend(val)?null:"Enter valid Bin/Serial Number";
        },
        onSave: (val) {
          this.mBinOrPart=val;
        },
      ),
    ],));
  }

  iconCamera(){
    return Container(child: IconButton(
        iconSize: 20.0,
        icon: Icon(
          Icons.camera_alt,
          size: 45.0,
        ),
        onPressed: () {
          getBinOrSerialBarcodeDetails();
        }),margin: EdgeInsets.only(top: 10),);
  }

  tffRequiredQuantity(){
    return CustomTextFormField(
      hint: 'Quantity',
      numbersOnly: true,
      inputType: TextInputType.number,
      isTitleRequired: false,
      controller: tecQuantity,
      onValidate: (val){
        return  Utility.isEmpty(val) || int.parse(val) == 0
            ? 'Enter quanity'
            : null;
      },
      onSave: (val){
        this.mQuantity=int.parse(val);
      },
    );
  }

  rbSubmit() {
    return CustomRaisedButton(
      text: 'Ok',
      buttonColor: Colors.blue,
      textColor: Colors.white,
      onPress: () {
        mBinOrPartResponse="";
        mPostBinDetailsBloc.showProgress(false);

        if (this.formKey.currentState.validate())
          formKey.currentState.save();
        else
          return null;

        mQuantity=0;
        submit();
      },
    );
  }

  rbFinish() {
    return CustomRaisedButton(
      text: 'Finish',
      buttonColor: Colors.blue,
      textColor: Colors.white,
      onPress: () {
        isFinish=true;
        CustomAlerts.showAlertWithCancel(context, "Quantity is short.Do you want to proceed?",(){
          mPartSerialNumberStatus=7;
          mBinOrPart=tecBinOrSerialNo.text;
          if(!Utility.isEmpty(mBinOrPart))
            submit();
          else
            postBinDetails();
        },(){
          mBinOrPart="";
          isFinish=false;
          mPartSerialNumberStatus=0;
        });
      },
    );
  }

  getBinOrSerialBarcodeDetails() async{
    String barcode = await BarCodeScanner.barcodeScanning(context: context,);

    if (barcode != BaseConstants.STR_CANCELLED && barcode != BaseConstants.STR_PERMISSION_NOT_GRANTED && barcode != BaseConstants.STR_RECAPTURE_BARCODE) {
      mBinOrPartResponse="";
      tecBinOrSerialNo.text=barcode;
      mBinOrPart=tecBinOrSerialNo.text;
      mQuantity=0;
      submit();
    } else if (barcode == BaseConstants.STR_RECAPTURE_BARCODE) {
      mBinOrPartResponse="";
      tecBinOrSerialNo.text="";
      mPostBinDetailsBloc.showProgress(false);
      CustomToast.showToast(BaseConstants.STR_RECAPTURE_BARCODE);
    } else
      CustomToast.showToast(barcode);
  }

  dialogQty(int remQty){
    mQuantity=0;
    mPartSerialNumberStatus=0;
    tecQuantity= new TextEditingController();
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return SimpleDialog(backgroundColor: Color(0xffE6E6E6),
            children: <Widget>[
              iconClose(),
              Container(
                  margin: EdgeInsets.all(10.0),
                  child: Form(
                      key: qtyFormKey,
                      child: new Container(
                          child: Column(
                            children: <Widget>[
                              Center(child: Text(
                                "Quantity required",
                                style: TextStyle(
                                    fontSize: 21.0,
                                    fontWeight: FontWeight.bold),
                                strutStyle: StrutStyle(),
                              ),),
                              Center(child: Text(
                                "for this serial",
                                style: TextStyle(
                                    fontSize: 21.0,
                                    fontWeight: FontWeight.bold),
                                strutStyle: StrutStyle(),
                              ),),
                              SizedBox(height: 15,),
                              tffRequiredQuantity(),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                                rbSubmitDialog(remQty),
                                SizedBox(width: 5,),
                                rbFinishDialog(remQty)
                              ],)
                            ],
                          ))))
            ],
          );
        });
  }

  iconClose(){
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

  Widget rbSubmitDialog(int remQty) {
    return Column(children: <Widget>[
      SizedBox(height: 10,),
      CustomRaisedButton(text: 'Ok',isWrap: true,
        buttonColor: Colors.blue,
        textColor: Colors.white,
        onPress: () {
          if(this.qtyFormKey.currentState.validate())
            this.qtyFormKey.currentState.save();
          else
            return null;

          Navigator.pop(context);
          if(mQuantity > remQty){
            isFinish=true;
            showCustomAlertForExcess();
          }else
            postBinDetails();
        },)
    ],);
  }

  Widget rbFinishDialog(int remQty) {
    return Column(children: <Widget>[
      SizedBox(height: 10,),
      CustomRaisedButton(text: 'FINISH',isWrap: true,
        buttonColor: Colors.blue,
        textColor: Colors.white,
        onPress: () {
          if(this.qtyFormKey.currentState.validate())
            this.qtyFormKey.currentState.save();
          else
            return null;

          Navigator.pop(context);
          if(mQuantity < remQty){
            isFinish=true;
            showCustomAlertForShort();
          }else if(mQuantity > remQty){
            isFinish=true;
            showCustomAlertForExcess();
          }else{
            postBinDetails();
          }
        },)
    ],);
  }

  showCustomAlertForShort(){
    return CustomAlerts.showAlertWithCancel(context, "Quantity is short.Do you want to proceed?",(){
      mPartSerialNumberStatus=8;
      postBinDetails();
    },(){
      isFinish=false;
    });
  }

  showCustomAlertForExcess(){
    return CustomAlerts.showAlertWithCancel(context, "Quantity is excess.Do you want to proceed?",(){
      mPartSerialNumberStatus=0;
      postBinDetails();
    },(){
      isFinish=false;
    });
  }

  void postBinDetails() async{
    if(await Utility.onCheckNetworkConnection()){
      mSuccess=false;
      mBinOrPartResponse="";
      this.function=this.postBinDetails;
      PostBinDetailsModel postBinDetailsModel=PostBinDetailsModel(binLabel: mBinNumber,orderId: mOrderId,partSerialNo: mBinOrPart,quantity: mQuantity,proceedExcessOrShort: mPartSerialNumberStatus,mPartsInOrderId: mPartsInOrderId);
      PostBinDetailsModel binnedDetailsModel=PostBinDetailsModel();
      binnedDetailsModel=await mPostBinDetailsBloc.postBinningDetailsModel(postBinDetailsModel);
      if( !binnedDetailsModel.mError){
        if(binnedDetailsModel.binStatus==BusinessConstants.BIN_SHORT_ACCEPTED){
          CustomAlerts.showAlertWithFunctionAction(context, BusinessConstants.STR_BIN_SHORT_ACCEPTED,(){
            NavigationUtils.pushAndRemoveUntil(context, HomeView());
          });
        } else if(binnedDetailsModel.binStatus==BusinessConstants.BIN_PART_BIN_SUCCESS){
          CustomAlerts.showAlertWithFunctionAction(context, BusinessConstants.STR_BIN_PART_BIN_SUCCESS,(){
            NavigationUtils.pushAndRemoveUntil(context, HomeView());
          });
        }else if(binnedDetailsModel.binStatus==BusinessConstants.BINNING_SUCCESS_PROCEED){
          if(mPartType==BusinessConstants.STR_NV_PART){
            tecBinOrSerialNo.text="";
            mBinOrPart=tecBinOrSerialNo.text;
          }
          mSuccess=true;
          mBinOrPartResponse="${BusinessConstants.STR_BINNING_SUCCESS_PROCEED}";
        }else if(binnedDetailsModel.binStatus==BusinessConstants.BIN_SITE_BIN_NOT_MATCH){
          mBinOrPartResponse="${BusinessConstants.STR_BIN_SITE_BIN_NOT_MATCH}";
        }else if(binnedDetailsModel.binStatus==BusinessConstants.BIN_INVALID_SERIAL_NUMBER){
          mBinOrPartResponse="${BusinessConstants.STR_BIN_INVALID_SERIAL_NUMBER}";
        } else
          CustomAlerts.showAlert(context, BusinessConstants.STR_BINNING_ALREADY_COMPLETED);
      }
      mPostBinDetailsBloc.showProgress(false);
    }else
      CustomToast.showToast(BaseConstants.STR_NO_INTERNET);
  }

  void submit() async{
    if(await Utility.onCheckNetworkConnection()){
      mSuccess=false;
      this.function=this.submit;
      mBinOrPartResponse="";
      PartOrBinValidationModel partOrBinModel=PartOrBinValidationModel();
      partOrBinModel=await mPostBinDetailsBloc.validatePartOrBin(mBinOrPart,mOrderId,mPartNumber);
      if(!partOrBinModel.mError){
        if(!Utility.isEmpty(partOrBinModel.mPartMasterId) && !Utility.isEmpty(mBinNumber)) {
          mSuccess=true;
          mBinOrPartResponse="Serial number scanned successfully";
          if(!Utility.isEmpty(partOrBinModel.mBinLocation) && partOrBinModel.mBinLocation!=mBinNumber ){
            mSuccess=false;
            mBinOrPartResponse="Serial number already scanned in \n${partOrBinModel.mBinLocation}";
          }else if(!isFinish){
            if (partOrBinModel.mPartTypeCode == BusinessConstants.STR_V_PART) {
              dialogQty(partOrBinModel.mRemainingQty);
            }else {
              mQuantity=1;
              mPartSerialNumberStatus = 1;
              postBinDetails();
            }
          } else {
            isFinish=false;
            postBinDetails();}
        }else if(!Utility.isEmpty(partOrBinModel.mBinLocation) && !Utility.isEmpty(partOrBinModel.mPartMasterId) && Utility.isEmpty(mBinNumber)){
          mBinOrPartResponse="${BusinessConstants.STR_BIN_SCAN_BIN_FIRST}";
        } else if(!Utility.isEmpty(partOrBinModel.mBinLocation)){
          mSuccess=true;
          mBinOrPartResponse="Bin scanned successfully";
          tecBinNo.text=partOrBinModel.mBinLocation??"";
          mBinNumber=tecBinNo.text;
          tecBinOrSerialNo.text="";
        } else if(!Utility.isEmpty(partOrBinModel.mPartMasterId)){
          mBinOrPartResponse="${BusinessConstants.STR_BIN_SCAN_BIN_FIRST}";
        } else if(Utility.isEmpty(mBinNumber)) {
          mBinOrPartResponse="${BusinessConstants.STR_BIN_INVALID_BIN_NUMBER}";
        }else {
          mBinOrPartResponse="${BusinessConstants.STR_BIN_INVALID_SERIAL_NUMBER}";
        }
      }
      mPostBinDetailsBloc.showProgress(false);
    }else
      CustomToast.showToast(BaseConstants.STR_NO_INTERNET);
  }

}