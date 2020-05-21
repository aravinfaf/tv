import 'dart:collection';
import 'package:tvs_visibility/src/visibility/constants/baseconstants.dart' as prefix0;
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/baseconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/businessconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/utility/utils.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/CustomRetry.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/custompopup/popupwindow.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customprogress.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customraisedbutton.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customtextformfield.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/navigaton/navigationutils.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/toast/customtoast.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/bloc/partnumberdetailsbloc.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/partnumberdetailsmodel/partnumberdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/postpartmasterdetailsmodel/postpartmasterdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/ui/partbinlocationdetailview/partbinlocationdetailview.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/ui/partnumberdetailsview/serialnumberlistingitems.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/ui/partnumberdetailsview/serialnumberlistingview.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class PostDespatchDetailsView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return PostDespatchDetailsViewState();
  }
}

class PostDespatchDetailsViewState extends State<PostDespatchDetailsView> implements SerialNumberListener{
  List<TextEditingController> tecSerialNo = new List<TextEditingController>();
  List<TextEditingController> tecQtyNo = new List<TextEditingController>();
  final formKey = new GlobalKey<FormState>();
  List<PostPartMasterDetailsModel> mPartMasterDetailsList=List();
  LinkedHashMap<String,PostPartMasterDetailsModel> mPartNumberMap;
  PartNumberDetailsBloc mPostDespatchDetailsBloc;
  int mIndex;

  PostDespatchDetailsViewState(){
    var container = kiwi.Container();
    mPostDespatchDetailsBloc = container<PartNumberDetailsBloc>();
  }

  @override
  void initState() {
    super.initState();
    tecSerialNo..add(TextEditingController());
    tecQtyNo..add(TextEditingController());
    mPartMasterDetailsList..add(PostPartMasterDetailsModel());
  }

  @override
  void dispose() {
    mPostDespatchDetailsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(initialData: false,stream: mPostDespatchDetailsBloc.isLoad,builder: (BuildContext context,AsyncSnapshot<bool> loadSnapshot){
      if(loadSnapshot.hasData && !loadSnapshot.data)
        return Scaffold(backgroundColor: Colors.white,
          body:Form(
              key: formKey,
              child: ListView.builder(itemCount: tecQtyNo.length,itemBuilder: (BuildContext context,int index){
                return cardSerialNoDetails(index);
              })),
          bottomNavigationBar: rbNext(),
          floatingActionButton: FloatingActionButton(onPressed: (){
            tecSerialNo..add(TextEditingController());
            tecQtyNo..add(TextEditingController());
            mPartMasterDetailsList..add(PostPartMasterDetailsModel());
            mPostDespatchDetailsBloc.showProgress(false);
          },
            backgroundColor: BaseConstants.LIGHT_VISIBILITY_BLUE,child: Icon(Icons.add),),
        );
      else if(loadSnapshot.hasError)
        return Scaffold(backgroundColor: Colors.white,body: CustomRetry(retry: submit,isTitleRequired: false,),);
      else
        return CustomProgress(isTitleRequired: false,);
    });
  }

  cardSerialNoDetails(int index){
    return Container(margin: EdgeInsets.only(left: 15,right: 15,top: 10),
      child: Column(mainAxisSize: MainAxisSize.min,children: <Widget>[
        index!=0?iconClose(index):Container(),
        serialNumberDialog(index),
        tffQtyNumber(index),
      ],),);
  }

  iconClose(index){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.close,size: 20,),
          onPressed: () {
            mPartMasterDetailsList.removeAt(index);
            tecSerialNo.removeAt(index);
            tecQtyNo.removeAt(index);
            mPostDespatchDetailsBloc.showProgress(false);
            },
          )
      ],
    );
  }

  tffQtyNumber(int index) {
    return Column(children: <Widget>[
      SizedBox(height: 10,),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
              child: CustomTextFormField(
                hint: 'Quantity',
                inputType: TextInputType.number,
                title: 'Quantity',
                isTitleRequired: true,
                controller: tecQtyNo[index],
                onValidate: (val) {
                  return val.length==0
                      ? 'Enter Quantity'
                      : null;
                },
                onSave: (val) {

                },)),],
      ),],);
  }

  Widget serialNumberDialog(index) {
    return Container(
      child: InkWell(
        onTap: () {
          mIndex=index;
          onPopUpProcessing();
        },
        child: CustomTextFormField(
          hint: 'Select Part Number',
          enable: false,
          numbersOnly: true,
          inputType: TextInputType.number,
          title: 'Part Number',
          isTitleRequired: true,
          controller: tecSerialNo[index],
          onValidate: (val) {
            return Utility.isEmpty(val)
                ? 'Please select part number'
                : null;
          },
        ),
      ),
    );
  }

  Widget rbNext() {
    return CustomRaisedButton(text: 'Next',
      buttonColor: Colors.blue,
      textColor: Colors.white,
      onPress: () {
        onValidateSerialNumber();
      },);
  }

  void onPopUpProcessing() async{
    if(await Utility.onCheckNetworkConnection())
      PopUpWindow(title: 'Part Number',
          context: context,
          content: SerialNumberListingView(this));
    else
      CustomToast.showToast(BaseConstants.STR_NO_INTERNET);
  }

  @override
  void onItemSelect(BuildContext context, PartNumberDetailsModel item) {
    tecSerialNo[mIndex].text=item.mPartNumber;
    tecQtyNo[mIndex].text="";

    mPartMasterDetailsList[mIndex]..mPartTypeMaster=item.mPartTypeMaster
                                  ..mPartMaster=item.mPartNumber
                                  ..mPartMasterId=item.mId;
    mPostDespatchDetailsBloc.showProgress(false);
  }

  onValidateSerialNumber() async {
    String emptyData = "";
    mPartNumberMap=LinkedHashMap();
    if(mPartMasterDetailsList.length!=0) {
      for (int i = 0; i < mPartMasterDetailsList.length; i++) {

        if(!Utility.isEmpty(tecSerialNo[i].text)){
          if(mPartNumberMap.containsKey(tecSerialNo[i].text)){
            mPartNumberMap.update(tecSerialNo[i].text, (v){
              return v..mQuantity=v.mQuantity+int.parse(Utility.isEmpty(tecQtyNo[i].text)?getQty(i):tecQtyNo[i].text);
            });
          }else{
            mPartNumberMap.putIfAbsent(tecSerialNo[i].text, (){
              return mPartMasterDetailsList[i]..mQuantity=int.parse(Utility.isEmpty(tecQtyNo[i].text)?getQty(i):tecQtyNo[i].text);
            });
          }
        }

        bool isPartNumberAbsent = Utility.isEmpty(tecSerialNo[i].text);
        bool isQuantityAbsent = Utility.isEmpty(tecQtyNo[i].text) || tecQtyNo[i].text == "0";
        if(isPartNumberAbsent || isQuantityAbsent) {
          emptyData = emptyData+
              "${i+1}) ${isPartNumberAbsent
                  ? "Part Number" : ""}${(isPartNumberAbsent & isQuantityAbsent)
                  ? "," : ""}${isQuantityAbsent ? "Quantity" : ""}.\n";
        }
      }
    }else {
      emptyData = "1) Part Number,Quanity";
    }
    if(!Utility.isEmpty(emptyData))
      showValidationAlertDialog("Invalid Fields",emptyData);
    else
      submit();
  }

  submit() async{
    if(await Utility.onCheckNetworkConnection()){
      String emptyData="";
      List<PostPartMasterDetailsModel> postPartMasterDetails=[];
      mPartNumberMap.values.forEach((v){
        postPartMasterDetails..add(v);
      });

      List<PostPartMasterDetailsModel> partMasterDetails = [];
      partMasterDetails = await mPostDespatchDetailsBloc.validatePartAvailableBin(postPartMasterDetails);

      if(partMasterDetails.length!=0 && !partMasterDetails[0].mError){
        for (int i = 0,j=0; i < partMasterDetails.length; i++) {

          if(postPartMasterDetails[i].mPartMasterId==partMasterDetails[i].mPartMasterId){
            if(partMasterDetails[i].mQuantity!=0 && postPartMasterDetails[i].mQuantity > partMasterDetails[i].mQuantity){
              j++;
              emptyData = emptyData+ "$j) ${postPartMasterDetails[i].mPartMaster}-${partMasterDetails[i].mQuantity}.\n";
            }
            if(partMasterDetails[i].mQuantity==0){
              j++;
              emptyData = emptyData+ "$j) ${postPartMasterDetails[i].mPartMaster}-0.\n";
            }
          }
        }
        if(!Utility.isEmpty(emptyData))
          showValidationAlertDialog("Available Quantity",emptyData);
        else
          NavigationUtils.push(context, PartBinLocationDetailView(partMasterDetails,mPartNumberMap));
      }
    }else{
      CustomToast.showToast(BaseConstants.STR_NO_INTERNET);
    }
  }

  getQty(i){
    return mPartMasterDetailsList[i].mPartTypeMaster==BusinessConstants.STR_VARIABLE_PART?'0':'1';
  }

  showValidationAlertDialog(String title,String content){
    List validationMsg=[];
    validationMsg=content.split(".");
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Container(width: double.infinity,
            child: AlertDialog(title: Row(children: <Widget>[
              Expanded(child: Text("$title")),
              IconButton(alignment: Alignment.topLeft,icon: Icon(Icons.close,color: Colors.blue[900],),iconSize: 18,onPressed: (){
                Navigator.pop(context);
              },),
            ],),backgroundColor: Colors.white,
            content:Container(
          width: double.infinity,
          child: ListView.builder(shrinkWrap: true,itemCount: validationMsg.length,itemBuilder: (BuildContext context,int index){
              return Text("${validationMsg[index]}",style: TextStyle(fontSize: 16,),);
            }))),);
        });
  }
}






