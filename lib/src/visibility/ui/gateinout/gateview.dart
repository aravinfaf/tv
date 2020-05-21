import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:tvs_visibility/src/visibility/bloc/gateinout/gatelistbloc.dart';
import 'package:tvs_visibility/src/visibility/constants/StringConstants.dart';
import 'package:tvs_visibility/src/visibility/constants/baseconstants.dart';
import 'package:tvs_visibility/src/visibility/model/gateinout/creategatein.dart';
import 'package:tvs_visibility/src/visibility/model/gateinout/creategateout.dart';
import 'package:tvs_visibility/src/visibility/model/podmodel/postfiltermodel.dart';
import 'package:tvs_visibility/src/visibility/ui/gateinout/gatelistitem.dart';
import 'package:tvs_visibility/src/visibility/ui/homeview.dart';
import 'package:tvs_visibility/src/visibility/utililty/utils.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customalerts/customalerts.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/custombutton/cutombutton.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customprogressindicator/customprogress.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customprogressindicator/customretry.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customtextfields/customeditformtext.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customview/customtoast.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/base/baseinterface.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customlistwidget/customlistandsearch.dart';

class GateView extends StatefulWidget {
  GateViewState mGateViewState;

  GateView();

  @override
  GateViewState createState() {
   mGateViewState = GateViewState();
   return mGateViewState;
  }
}

class GateViewState extends State<GateView> implements OnProcessListener<GenericDtoList, GateListItems>, GateOutListener {
  String mGateInNumber;
  bool isRegistration = false;
  CreateGateInModel mCreateGateInModel;
  CreateGateInModel createGateInModel = new CreateGateInModel();
  TextEditingController tecVehNumber;
  TextEditingController tecDriverName;
  TextEditingController tecDriverMobile;
  final formKey = new GlobalKey<FormState>();
  GateListBloc mGateInListBloc;
  List<String> mFilterColumnList = [];
  List<String> mFilterList = [];

  GateViewState() {
    var container = kiwi.Container();
    mGateInListBloc = container<GateListBloc>();
  }

  @override
  void initState() {
    mFilterColumnList.clear();
    mFilterList.clear();
    mFilterColumnList.add("vehNumber");
    mFilterColumnList.add("driverName");
    mFilterColumnList.add("phonenumber");
    mFilterColumnList.add("GateInnumber");
    mFilterList.add("Vehicle Number");
    mFilterList.add("Driver Name");
    mFilterList.add("Driver Mobile");
    mFilterList.add("Gate-In Number");

    super.initState();
  }

  @override
  void dispose() {
    mGateInListBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(initialData: false,stream: mGateInListBloc.isLoading,builder: (context,AsyncSnapshot<bool> snapshot){
           if(snapshot.hasData && !snapshot.data){
              return Scaffold(
               resizeToAvoidBottomInset: false,
                body: CustomListAndSearch<GenericDtoList>(
                  onProcessListener: this,
                  mFilterColumnList: mFilterColumnList,
                  mFilterList: mFilterList,
                ),
                floatingActionButton: FloatingActionButton(
                  tooltip: 'Vehicle Gate-In',
                  child: Icon(Icons.add),
                  onPressed:(){
                    gateInRegistrationView(context);
                  },
                ),
              );
            }else if(snapshot.hasError){
              return Scaffold(backgroundColor: Colors.white,body: CustomRetry(isTitleRequired: false,retry: isRegistration?gateIn:onGateOut,),);
            }else{
              return CustomProgress(isTitleRequired: false,);
            }
          });

  }

  gateInRegistrationView(BuildContext context) {
    tecVehNumber = new TextEditingController();
    tecDriverName = new TextEditingController();
    tecDriverMobile = new TextEditingController();

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Vehicle Details',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
            ),
          ),
          content: SingleChildScrollView(
              child: Form(
            key: formKey,
            child: ListBody(
              children: <Widget>[
                CustomEditFormText(
                  label: 'Vehicle Number',
                  hint: 'Enter Vehicle Number',
                  allowOnlyAlphaNumerals: true,
                  controller: tecVehNumber,
                  onTextSaved: (val){
                    createGateInModel.vehNumber = Utils.regexRemoveWhitespace(val.toString().trim());
                  },
                  validator: (val){
                    return val != null && val.toString().trim().length != 0 ? !Utils.regexCompare(val)? null:"Please enter valid vehicle number" : "Please enter vehicle number";
                  },
                  textCaps: true,
                ),
                CustomEditFormText(
                  label: 'Driver Name',
                  hint: 'Enter Driver Name',allowOnlyAlphabets: true,
                  onTextSaved: (val){
                    createGateInModel.driverName = val.toString().trim();
                  },
                  controller: tecDriverName,
                  validator: (val){
                    return val != null && val.toString().trim().length!=0? null: 'Please enter driver name';
                  },
                ),
                CustomEditFormText(
                  label: 'Driver Mobile',
                  hint: 'Enter Driver Mobile',
                  onTextSaved: (val){
                    createGateInModel.phonenumber = int.parse(val);
                  },
                  controller: tecDriverMobile,
                  inputType: TextInputType.number,
                  validator: (val){
                    return Utils.isValidMobileNumber(val) ? null : 'Please enter valid mobile number';
                  },
                  numbersOnly: true,
                  maxLength: 10,
                ),
                CustomButton(
                  formKey: formKey,
                  text: "Gate-In",isCircularEdge: true,
                  onPress: (){
                    gateIn();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          )),
        );
      },
    );
  }

  gateIn() async {
    isRegistration = true;

    if (await Utils.onCheckNetworkConnection()) {

      int gateIn = await mGateInListBloc.gateInVehicle(createGateInModel);

      if(gateIn == BaseConstants.GateIn_Success){
        return CustomAlerts.showAlertWithFunctionAction(
            context, StringConstants.GateIn_Success, () {
          mGateInListBloc.showProgress(false);
        });
      }
      else if(gateIn ==  BaseConstants.GateIn_VehicleAlreadyExist){
        return CustomAlerts.showAlertWithFunctionAction(
            context, StringConstants.GateIn_VehicleAlreadyExist, () {
          mGateInListBloc.showProgress(false);
        });
      }
      else {
        //Log for developer testing purpose
        if(gateIn ==  BaseConstants.GateIn_Failed_siteMasterNull){
          print("gateIn Failed: " + "siteMaster Cannot be null");
        }else if(gateIn == BaseConstants.GateIn_Failed_vehicleInTimeNull){
          print("gateIn Failed: " + "vehicle In Time Cannot be null");
        }else if(gateIn == BaseConstants.GateIn_Failed_vehicleNumberNull){
          print("gateIn Failed: " + " vehicle number Cannot be null");
        }
          return CustomAlerts.showAlertWithFunctionAction(
            context, StringConstants.GateIn_Failed, () {
            mGateInListBloc.showProgress(false);
          });

        }

/*      if (!Utils.isEmpty(gateIn)) {
        if (gateIn.contains('SIT') || gateIn.contains('IN')) {
          return CustomAlerts.showAlertWithFunctionAction(
              context, 'Gate in data saved successfully', () {
            NavigationUtils.pushReplacement(context, navigateToHomeView());
          });
        } else if (gateIn == "This vehicle Number already exists!")
          return CustomAlerts.showAlertWithFunctionAction(
              context, 'This vehicle Number already exist!', () {});
      } else {
        return CustomAlerts.showAlertWithFunctionAction(
            context, 'Gate in Failed!', () {});
      }*/
    } else {
      CustomToast.showToast(StringConstants.NO_INTERNET_CONNECTION);
    }
  }

  @override
  GateListItems createView(BuildContext context) {
    return GateListItems(widget.mGateViewState,);
  }

  @override
  String getSavedDate(GenericDtoList item) {
    return null;
  }

  @override
  Future<List<GenericDtoList>> onProcessing(String filter, String filterColumn,
      bool paging, int currentPage, int limit, String minDate) {
    return mGateInListBloc.onProcess(
        filter, filterColumn, paging, currentPage, limit, minDate);
  }

  @override
  onGateOut(String gateInNumber) async {
    mGateInNumber = gateInNumber;
    if (await Utils.onCheckNetworkConnection()) {
      await CustomAlerts.showAlertWithOkCancel(context, "Do u want to gate out the vehicle?", "Yes", "No", () async{
        bool gateOutResult = await mGateInListBloc.gateOutVehicle(CreateGateOutModel(gateInNumber: gateInNumber));

        if (gateOutResult != null) {
          mGateInListBloc.showProgress(false);
          return await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Alert'),
                content: new Text(gateOutResult
                    ? StringConstants.GateOut_Success
                    : StringConstants.GateOut_Failed),
                actions: <Widget>[
                  FlatButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.pop(context);
                      /* NavigationUtils.pushReplacement(
                          context, navigateToHomeView());*/
                    },
                  ),
                ],
              );
            },
          );
        }else{
          mGateInListBloc.showProgress(false);
        }
      }, (){});
    } else {
      CustomToast.showToast(StringConstants.NO_INTERNET_CONNECTION);
    }
  }

  navigateToHomeView() {
    return HomeView();
  }
}
