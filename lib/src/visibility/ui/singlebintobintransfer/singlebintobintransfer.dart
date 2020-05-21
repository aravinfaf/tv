import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:tvs_visibility/src/visibility/bloc/singlebintobinbloc/singlebintobinbloc.dart';
import 'package:tvs_visibility/src/visibility/constants/baseconstants.dart' as prefix0;
import 'package:tvs_visibility/src/visibility/ui/singlebintobintransfer/singlebintobincontract.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customprogressindicator/customprogress.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customprogressindicator/customretry.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customview/customtoast.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/assetsconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/baseconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/utility/utils.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/barcodescanner/barcodescanner.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customraisedbutton.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customtextformfield.dart';

class SingleBinToBin extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SingleBinToBinState();
  }
}

class SingleBinToBinState extends State<SingleBinToBin>implements SingleBinToBinContract{
  TextEditingController tecBinOrSerialNo = new TextEditingController();
  TextEditingController tecQuantity;
  SingleBinToBinBloc mSingleBinToBinBloc;
  final formKey = new GlobalKey<FormState>();
  String mBinNumber;
  String mBinOrPart;
  Function function;
  String mBinLabel;
  int statusCode;
  String mBinOrPartResponse;
  bool mSuccess=false;

  @override
  void dispose() {
    mSingleBinToBinBloc.dispose();
    super.dispose();
  }

  SingleBinToBinState() {
    var container = kiwi.Container();
    mSingleBinToBinBloc = container<SingleBinToBinBloc>();
    mSingleBinToBinBloc.mView = this;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(initialData: false,stream: mSingleBinToBinBloc.isLoading,
        builder: (BuildContext context,AsyncSnapshot<bool> snapshot){
      if(snapshot.hasData && !snapshot.data)
        return Scaffold(
          backgroundColor: Colors.white,
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
                      Center(child: Text('${mBinOrPartResponse??""}',
                        style: TextStyle(fontSize: 16,color: mSuccess?Colors.green:Colors.red,fontFamily: AssetsConstants.OPEN_SANS_SEMI_BOLD)
                          ,textAlign: TextAlign.center)),
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
          bottomNavigationBar: rbSubmit(),);
      else if(snapshot.hasError)
        return Scaffold(backgroundColor: Colors.white,body: CustomRetry(retry: function,isTitleRequired: false,),);
      else
        return Scaffold(
          backgroundColor: Colors.white,
          body: CustomProgress(isTitleRequired: false,),);
    });
  }

  tffBinNumber(){
    return Column(children: <Widget>[
      Center(child: Text(
        'Bin Number',
        style: TextStyle(
            fontSize: 18,
            color: Colors.black38),
      ),),
      Center(child: Text("${!Utility.isEmpty(mBinLabel)?mBinLabel:' - '}",style: TextStyle(fontSize: 17),),)
    ],);
  }

  tffBinOrSerialNumber(){
    return Flexible(child: Column(children: <Widget>[
      CustomTextFormField(
        hint: 'Bin/LPN Number',
        inputType: TextInputType.text,
        title: 'Bin/LPN Number',
        isTitleRequired: true,
        controller: tecBinOrSerialNo,
        onValidate: (val) {
          return val.length == 0
              ? 'Enter or scan Bin/LPN Number'
              : Utility.validSpecialCharactersInBackend(val)?null:"Enter valid Bin/LPN Number";
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

  rbSubmit() {
    return CustomRaisedButton(
      text: 'Ok',
      buttonColor: Colors.blue,
      textColor: Colors.white,
      onPress: () {
        mBinOrPartResponse="";

        if (this.formKey.currentState.validate())
          formKey.currentState.save();
        else
          return null;

        submit();
      },
    );
  }

  getBinOrSerialBarcodeDetails() async{
    String barcode = await BarCodeScanner.barcodeScanning(context: context,isVisibility: true);

    if (barcode != prefix0.BaseConstants.STR_CANCELLED && barcode != prefix0.BaseConstants.STR_PERMISSION_NOT_GRANTED
        && barcode != prefix0.BaseConstants.STR_RECAPTURE_BARCODE) {
      mBinOrPartResponse="";
      tecBinOrSerialNo.text=barcode;
      mBinOrPart=tecBinOrSerialNo.text;

      submit();
    } else if (barcode == prefix0.BaseConstants.STR_RECAPTURE_BARCODE) {
      mBinOrPartResponse="";
      tecBinOrSerialNo.clear();
      mSingleBinToBinBloc.showProgress(false);
      CustomToast.showToast(prefix0.BaseConstants.STR_RECAPTURE_BARCODE);
    } else
      CustomToast.showToast(barcode);
  }

  void submit() async{
    if(await Utility.onCheckNetworkConnection()){
      mSuccess=false;
      this.function=submit;
      mBinOrPartResponse="";
      tecBinOrSerialNo.clear();
      statusCode=await mSingleBinToBinBloc.singleBinToBinTransfer(mBinOrPart,mBinLabel);
      mSingleBinToBinBloc.showProgress(false);
    }else
      CustomToast.showToast(BaseConstants.STR_NO_INTERNET);
  }

  @override
  setStatusMessage(String validationMessage,bool isSuccess) {
    mBinOrPartResponse = validationMessage;
    mSuccess = isSuccess;
  }

  @override
  setScanNumber (String binLabel){
    mBinLabel= binLabel;
  }

  @override
  getBinLabel() {
    return mBinLabel;
  }
}