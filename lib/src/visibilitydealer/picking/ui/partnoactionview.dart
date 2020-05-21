import 'package:tvs_visibility/src/visibility/ui/homeview.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/Utility/utils.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/Widgets/customretry.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/baseconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/businessconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/validationconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customalerts/customalert.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customprogress.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customraisedbutton.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customtextformfield.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customtextview.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/navigaton/navigationutils.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/toast/customtoast.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/bloc/partnoactionbloc.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/postdispatchmasterdetailsmodel/postdispatchmasterdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/ui/partnocompletionview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class PartNumberActionView extends StatefulWidget {
  List<List<PostDispatchMasterDetailsModel>> mScannedResult=[];

  PartNumberActionView(this.mScannedResult);

  @override
  State<StatefulWidget> createState() {
    return PartNumberActionViewState(mScannedResult);
  }
}

class PartNumberActionViewState extends State<PartNumberActionView> {
  List<List<PostDispatchMasterDetailsModel>> mScannedResult=[];
  List<PostDispatchMasterDetailsModel> mDispatchDetailsList=[];
  PartNumberActionBloc mPartNumberActionBloc;
  final formKey = new GlobalKey<FormState>();
  String mDispatchPartMasetrTypeId;
  String mUserName;
  String mOrderNumber;
  String mUserMobileNumber;

  PartNumberActionViewState(this.mScannedResult){
    var container = kiwi.Container();
    mPartNumberActionBloc=container<PartNumberActionBloc>();
  }

  @override
  void initState() {
    mDispatchDetailsList=mPartNumberActionBloc.getPostDispatchMasterDetailsInList(mScannedResult);
    super.initState();
  }

  @override
  void dispose() {
    mPartNumberActionBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(initialData: true,stream: mPartNumberActionBloc.isLoad,builder: (context,AsyncSnapshot<bool> loadSnapshot){
      if(loadSnapshot.hasData && !loadSnapshot.data)
       return StreamBuilder(stream: mPartNumberActionBloc.dispatchResults,builder: (BuildContext context,AsyncSnapshot<List<PostDispatchMasterDetailsModel>> snapshot){
         if(snapshot.hasData){
           return Scaffold(
             backgroundColor: Colors.white,
             appBar: appBar(),
             body: ListView.builder(itemCount: snapshot.data.length,itemBuilder: (BuildContext context,int index){
               return Card(margin: EdgeInsets.all(10),
                 color: Colors.white,
                 child: Container(child: Column(
                   children: <Widget>[
                     Column(
                       children: <Widget>[
                         CustomTextView(
                           text: '${snapshot.data[index].mPartNumber??'-'}',
                           title: 'Part Number',),
                         CustomTextView(
                           text: '${snapshot.data[index].mReqQty??'-'}',
                           title: 'Required Quantity',),
                         CustomTextView(
                           text: '${snapshot.data[index].mPartSerialNo??'-'}',
                           title: 'Serial Number',),
                         CustomTextView(
                           text: '${snapshot.data[index].mBinLabel??'-'}',
                           title: 'Bin Location',),
                         CustomTextView(
                           text: '${snapshot.data[index].mPickQty??'-'}',
                           title: 'Picked Quantity',),
                       ],
                     )
                   ],
                 ),padding: EdgeInsets.all(5),),
               );
             }),
             bottomNavigationBar: Row(children: <Widget>[
               Expanded(child: rbDespatch(),),
               SizedBox(width: 5,),
               Expanded(child: rbWorkshop(),)],
             ),);
         }else{
           return Scaffold(backgroundColor: Colors.white,appBar: appBar(),body: CustomProgress(isTitleRequired: false,),);
         }
       },);
      else if(loadSnapshot.hasError)
       return Scaffold(body: CustomRetry(retry: submit,),);
      else
        return Scaffold(backgroundColor: Colors.white,body: CustomProgress(),);
    });
  }

  appBar(){
    return PreferredSize(child: AppBar(
      title: Text("Dealer Picking"),
      backgroundColor: Colors.blue,
    ), preferredSize: Size.fromHeight(60));
  }

  Widget rbDespatch() {
    return CustomRaisedButton(text: 'DESPATCH',
      buttonColor: Colors.blue,
      textColor: Colors.white,
      onPress: () {
        mDispatchPartMasetrTypeId=BusinessConstants.PICKING_DESPATCH;
        onPartNumberAction();
      },);
  }

  Widget rbWorkshop() {
    return CustomRaisedButton(text: 'WORKSHOP',
      buttonColor: Colors.blue,
      textColor: Colors.white,
      onPress: () {
        mDispatchPartMasetrTypeId=BusinessConstants.PICKING_WORKSHOP;
        onPartNumberAction();
      },);
  }

  Widget iconCheck() {
    return Icon(
      Icons.check,
      color: Colors.green,
      size: 100,
    );
  }

  onPartNumberAction() async{
    if (await Utility.onCheckNetworkConnection()) {
      if(Utility.isEmpty(mUserName) || Utility.isEmpty(mUserMobileNumber))
        getUserDetailsDialog();
      else
        submit();
    } else
      CustomToast.showToast(BaseConstants.STR_NO_INTERNET);
  }

  getUserDetailsDialog(){
    TextEditingController tecUserName = new TextEditingController();
    TextEditingController tecUserMobileNumber = new TextEditingController();
    TextEditingController tecOrderNumber = new TextEditingController();

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return SimpleDialog(backgroundColor: Color(0xffE6E6E6),
            children: <Widget>[
              SingleChildScrollView(
                padding: EdgeInsets.all(10.0), child: Column(children: <Widget>[
                iconClose(),
                Container(
                    margin: EdgeInsets.all(10.0),
                    child: Form(
                        key: formKey,
                        child: new Container(
                            child: Column(
                              children: <Widget>[
                                Center(child: Text(
                                  mDispatchPartMasetrTypeId==BusinessConstants.PICKING_DESPATCH?"Despatcher Details":"Workshopper Details",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                  strutStyle: StrutStyle(),
                                ),),
                                SizedBox(height: 10,),
                                tffUserName(tecUserName),
                                SizedBox(height: 5,),
                                tffUserMobileNumber(tecUserMobileNumber),
                                SizedBox(height: 5,),
                                tffOrderNumber(tecOrderNumber),
                                SizedBox(height: 5,),
                                rbOk()
                              ],
                            ))))
              ],),)
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

  tffUserName(tecUserName) {
    return Container(child: CustomTextFormField(
      hint: 'Name',
      numbersOnly: false,
      enable: true,
      inputType: TextInputType.text,
      title: 'Name',
      isTitleRequired: false,
      controller: tecUserName,
      onValidate: (val) {
        return Utility.isEmpty(val)
            ? "Please enter name"
            : null;
      },
      onSave: (v){
        this.mUserName=v;
      },
    ),);
  }

  tffUserMobileNumber(tecUserMobileNumber) {
    return Container(child: CustomTextFormField(
      hint: 'Mobile Number',
      numbersOnly: true,
      enable: true,
      inputType: TextInputType.number,
      maxLength: 10,
      title: 'Mobile Number',
      isTitleRequired: false,
      controller: tecUserMobileNumber,
      onSave: (v){
        this.mUserMobileNumber=v;
      },
    ),);
  }

  tffOrderNumber(tecOrderNumber) {
    return Container(child: CustomTextFormField(
      hint: 'Order Number',
      numbersOnly: false,
      enable: true,
      inputType: TextInputType.text,
      title: 'Order Number',
      isTitleRequired: false,
      controller: tecOrderNumber,
      onSave: (v){
        this.mOrderNumber=v;
      },
    ),);
  }

  rbOk() {
    return CustomRaisedButton(
      isCircularBorder: true,
      text: "OK",
      buttonColor: Colors.blue,
      textColor: Colors.white,
      isWrap: true,
      onPress: () {
        if (this.formKey.currentState.validate())
          formKey.currentState.save();
        else
          return null;
        Navigator.pop(context);
        showAlertDespatchWorkshopDialog();
      },);
  }

  showAlertDespatchWorkshopDialog(){
    return CustomAlerts.showAlertWithCancel(context, "Are you sure want to submit..?",(){
      submit();
    },(){
      mUserName="";
      mUserMobileNumber="";
      onShowCancelDialog();
    });
  }

  onShowCancelDialog(){
    return CustomAlerts.showAlertWithCancel(context, "Are you sure want to cancel...?", (){
      NavigationUtils.pushAndRemoveUntil(context, HomeView());
    }, (){});
  }

  submit() async{
    if(await Utility.onCheckNetworkConnection()){
      List<PostDispatchMasterDetailsModel> postDispatchResponse=[];
      postDispatchResponse=await mPartNumberActionBloc.getPartNumberActionResult(mDispatchPartMasetrTypeId,mOrderNumber,mDispatchDetailsList,mUserName,mUserMobileNumber);
      //INDIVIDUAL RECORDS-PICK STATUS
      if(postDispatchResponse.length!=0 && !postDispatchResponse[0].mError){
        if(Utility.isEmpty(postDispatchResponse[0].mOrderId)){
          mUserName="";
          mUserMobileNumber="";
          CustomAlerts.showAlert(context, ValidationConstants.STR_SOMETHING_WENT_WRONG);
        }else{
          NavigationUtils.push(context, PartNumberCompletionView()).whenComplete((){
            return NavigationUtils.pushAndRemoveUntil(context, HomeView());
          });
        }
      }
    }else
      CustomToast.showToast(BaseConstants.STR_NO_INTERNET);
  }

}
