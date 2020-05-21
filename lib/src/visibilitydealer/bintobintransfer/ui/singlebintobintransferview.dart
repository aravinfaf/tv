import 'package:tvs_visibility/src/visibilitydealer/bintobintransfer/bloc/singlebintobintransferbloc.dart';
import 'package:tvs_visibility/src/visibilitydealer/bintobintransfer/model/binmasterdetailsmodel/binmasterdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/assetsconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/baseconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/businessconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/utility/utils.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/CustomRetry.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/barcodescanner/barcodescanner.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customprogress.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customraisedbutton.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customtextformfield.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/toast/customtoast.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class SingleBinToBinTransferView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SingleBinToBinTransferViewState();
  }
}

class SingleBinToBinTransferViewState extends State<SingleBinToBinTransferView>{
  TextEditingController tecBinOrSerialNo = new TextEditingController();
  TextEditingController tecBinNo = new TextEditingController();
  TextEditingController tecQuantity;
  SingleBinToBinTransferBloc mSingleBinToBinTransferBloc;
  final formKey = new GlobalKey<FormState>();
  String mBinNumber;
  String mBinOrPart;
  Function function;
  String mBinMasterId;
  String mBinOrPartResponse;
  bool mSuccess=false;

  @override
  void dispose() {
    mSingleBinToBinTransferBloc.dispose();
    super.dispose();
  }

  SingleBinToBinTransferViewState(){
    var container = kiwi.Container();
    mSingleBinToBinTransferBloc = container<SingleBinToBinTransferBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(initialData: false,stream: mSingleBinToBinTransferBloc.isLoading,builder: (BuildContext context,AsyncSnapshot<bool> snapshot){
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
                      Center(child: Text('${mBinOrPartResponse??""}',style: TextStyle(fontSize: 16,color: mSuccess?Colors.green:Colors.red,fontFamily: AssetsConstants.OPEN_SANS_SEMI_BOLD),),),
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

  rbSubmit() {
    return CustomRaisedButton(
      text: 'Ok',
      buttonColor: Colors.blue,
      textColor: Colors.white,
      onPress: () {
        mBinOrPartResponse="";
        mSingleBinToBinTransferBloc.showProgress(false);

        if (this.formKey.currentState.validate())
          formKey.currentState.save();
        else
          return null;

        submit();
      },
    );
  }

  getBinOrSerialBarcodeDetails() async{
    String barcode = await BarCodeScanner.barcodeScanning(context: context,);

    if (barcode != BaseConstants.STR_CANCELLED && barcode != BaseConstants.STR_PERMISSION_NOT_GRANTED && barcode != BaseConstants.STR_RECAPTURE_BARCODE) {
      mBinOrPartResponse="";
      tecBinOrSerialNo.text=barcode;
      mBinOrPart=tecBinOrSerialNo.text;

      submit();
    } else if (barcode == BaseConstants.STR_RECAPTURE_BARCODE) {
      mBinOrPartResponse="";
      tecBinOrSerialNo.text="";
      mSingleBinToBinTransferBloc.showProgress(false);
      CustomToast.showToast(BaseConstants.STR_RECAPTURE_BARCODE);
    } else
      CustomToast.showToast(barcode);
  }

  void submit() async{
    if(await Utility.onCheckNetworkConnection()){
      mSuccess=false;
      this.function=submit;
      mBinOrPartResponse="";

      BinMasterDetailsModel binMasterDetails=BinMasterDetailsModel();
      binMasterDetails=await mSingleBinToBinTransferBloc.singleBinToBinTransfer(mBinOrPart,mBinMasterId);
      if(!binMasterDetails.mError){
        if(binMasterDetails.mStatusMasterId == BusinessConstants.BINNING_INVALID_SERIAL_NUMBER && !Utility.isEmpty(mBinNumber)){
          mBinOrPartResponse="Invalid serial number";
        }else if(binMasterDetails.mStatusMasterId == BusinessConstants.BINNING_INVALID_SERIAL_NUMBER){
          mBinOrPartResponse="Invalid bin number";
        }else if(binMasterDetails.mStatusMasterId == BusinessConstants.BINNING_BIN_NOT_SCANNED_FOR_SERIAL_NUMBER && Utility.isEmpty(mBinNumber)){
          mBinOrPartResponse="Scan bin first";
          tecBinOrSerialNo.text="";
        } else if(binMasterDetails.mStatusMasterId == BusinessConstants.BINNING_BIN_LOCATION_SITE_MAPPED){
          mSuccess=true;
          mBinOrPartResponse="Bin scanned successfully";
          tecBinOrSerialNo.text="";
          tecBinNo.text=binMasterDetails.mBinLabel??"";
          mBinNumber=tecBinNo.text;
          mBinMasterId=binMasterDetails.mBinId;
        } else if(binMasterDetails.mStatusMasterId == BusinessConstants.BINNING_SERIAL_NUMBER_MAPPED_TO_BIN){
          mSuccess=true;
          mBinOrPartResponse="Serial number transferred to bin";
          tecBinOrSerialNo.text="";
        } else if(binMasterDetails.mStatusMasterId == BusinessConstants.BINNING_SERIAL_NUMBER_ALREADY_IN_SAME_BIN){
          mBinOrPartResponse="Serial number already in same bin";
          tecBinOrSerialNo.text="";
        } else if(binMasterDetails.mStatusMasterId == BusinessConstants.BINNING_BIN_TYPE_MISMATCH){
          mBinOrPartResponse="Bin type mismatch";
          tecBinOrSerialNo.text="";
        } else if(binMasterDetails.mStatusMasterId == BusinessConstants.BINNING_SERIAL_NUMBER_NOT_AVAILABLE_IN_BIN){
          mBinOrPartResponse="Serial number not available in bin";
          tecBinOrSerialNo.text="";
        }else {
          mBinOrPartResponse="Serial number not binned";
          tecBinOrSerialNo.text="";
        }
      }
    }else
      CustomToast.showToast(BaseConstants.STR_NO_INTERNET);
  }

}