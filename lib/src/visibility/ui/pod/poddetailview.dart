import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:tvs_visibility/src/visibility/bloc/podbloc/savepodbloc.dart';
import 'package:tvs_visibility/src/visibility/constants/StringConstants.dart';
import 'package:tvs_visibility/src/visibility/constants/businessconstants.dart';
import 'package:tvs_visibility/src/visibility/model/podmodel/postpoddetailsmodel.dart';
import 'package:tvs_visibility/src/visibility/ui/homeview.dart';
import 'package:tvs_visibility/src/visibility/utililty/utils.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customalerts/customalerts.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/custombutton/cutombutton.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customprogressindicator/customprogress.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customprogressindicator/customretry.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customtextfields/customeditformtext.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customview/customwebview.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/navigaton/navigationutils.dart';

class PodDetailView extends StatefulWidget {
  String vehicleInOut;
  String taskInstanceId;

  PodDetailView(this.vehicleInOut, this.taskInstanceId,);

  @override
  PodDetailViewState createState() => PodDetailViewState();
}

class PodDetailViewState extends State<PodDetailView> {
  TextEditingController tecExpectedPackage = new TextEditingController();
  TextEditingController tecReceivedPackage = new TextEditingController();
  TextEditingController tecComments = new TextEditingController();
  TextEditingController tecDamagedPackage;
  final formKey = new GlobalKey<FormState>();
  PodDetailBloc mSavePodBloc;
  Function mOnRetry;

  PodDetailViewState() {
    var container = kiwi.Container();
    mSavePodBloc = container<PodDetailBloc>();
  }

  @override
  void initState() {
    mSavePodBloc.setCheckBox(false);
    super.initState();
  }

  @override
  void dispose() {
    mSavePodBloc.dispose();
    tecExpectedPackage.dispose();
    tecReceivedPackage.dispose();
    tecComments.dispose();
    tecDamagedPackage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(initialData: false,stream: mSavePodBloc.isLoading,builder: (BuildContext context,AsyncSnapshot<bool> snapshot){
      if(snapshot.hasData && !snapshot.data){
        return Scaffold(appBar: AppBar(title: Text("Pod Details"),),body: SingleChildScrollView(child: Container(
          padding: EdgeInsets.all(8.0),
          child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  CustomEditFormText(
                    label: "Expected Package",
                    onTextSaved: (val){},
                    controller: tecExpectedPackage,
                    inputType: TextInputType.phone,
                    hint: "Expected Package",
                    validator: (val){
                      return !Utils.isEmpty(val) && int.parse(val) != 0
                          ? null
                          : 'Please enter expected package';
                    },
                    maxLength: 10,
                  ),
                  CustomEditFormText(
                    onTextSaved: (val){},
                    label: "Received Package",
                    inputType: TextInputType.phone,
                    hint: "Received Package",
                    maxLength: 10,
                    controller: tecReceivedPackage,
                    validator: (val){
                      return !Utils.isEmpty(val) && int.parse(val) != 0
                          ? null
                          : 'Please enter received package';
                    },
                  ),
                  Row(
                    children: <Widget>[
                      StreamBuilder(
                        initialData: false,
                        stream: mSavePodBloc.mChecked.stream,
                        builder: (context, snapshot) {
                          return Checkbox(
                            value: snapshot.data,
                            onChanged: (bool value) {
                              mSavePodBloc.setCheckBox(value);
                            },
                          );
                        },
                      ),
                      Text("Is there any damage?",
                          style: TextStyle(
                            color: Colors.black,
                          ))
                    ],
                  ),
                  StreamBuilder(
                    initialData: false,
                    stream: mSavePodBloc.mChecked.stream,
                    builder: (context, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.data) {
                        return CustomEditFormText(
                          label: "Damaged Package",
                          onTextSaved: (val){},
                          inputType: TextInputType.number,
                          hint: "Damaged Package",
                          controller: tecDamagedPackage,
                          maxLength: 10,
                          validator:(val){
                            return !Utils.isEmpty(val) ? !(int.parse('$val')<int.parse('$val')) ?null:'Damage qty cannot be greater than received qty' :"Please enter damaged package";
                          },
                        );
                      } else {
                        tecDamagedPackage = new TextEditingController();
                        return new Container();
                      }
                    },
                  ),
                  CustomEditFormText(
                    label: "Comment",
                    onTextSaved: (val){},
                    hint: "Comment",
                    controller: tecComments,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        child: RaisedButton(
                          child: Text('Cancel',
                              style: TextStyle(color: Colors.white)),
                          padding: EdgeInsets.all(12),
                          color: Colors.lightBlueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          onPressed: () {
                            navigateToHomeView();
                          },
                        ),
                      ),
                      CustomButton(
                        text: 'Save',
                        isCircularEdge: true,
                        formKey: formKey,
                        onPress: (){
                          submitPODDetails();
                        },
                      ),
                    ],
                  )
                ],
              )),
        ) ),);
      }else if(snapshot.hasError){
        return Scaffold(backgroundColor: Colors.white,body: CustomRetry(retry: mOnRetry,),);
      }else{
        return CustomProgress();
      }
    });
  }

  void submitPODDetails() async {
    if (await Utils.onCheckNetworkConnection()) {
      this.mOnRetry=submitPODDetails;
      PostPodDetailsModel podDetailsModel = PostPodDetailsModel(
          expectedQty: int.parse(tecExpectedPackage.text),
          receivedQty: int.parse(tecReceivedPackage.text),
          damagedQty: Utils.isEmpty(tecDamagedPackage.text)
              ? 0
              : Utils.parseStringToInt('${tecDamagedPackage.text}'),
          comments: tecComments.text,
          taskInstanceId: widget.taskInstanceId,
          vehicleInOutId: widget.vehicleInOut,
          partsInOrderStatusesDtOs: []);

      var podDetailResponse = await mSavePodBloc.submitPODDetails(podDetailsModel);

      if(podDetailResponse!=null && podDetailResponse!="ERROR"){
        if (podDetailsModel.receivedQty == podDetailsModel.expectedQty && podDetailsModel.damagedQty == 0) {
          alertOnNavigateToPODWebView(BusinessConstants.STR_PARTIAL_POD_GENERATED, podDetailResponse);
        } else if (podDetailsModel.expectedQty >= podDetailsModel.receivedQty) {
          alertOnNavigateToPODWebView(BusinessConstants.STR_CONDITIONAL_POD_GENERATED_AND_SENT_FOR_WAREHOUSE_MANAGER_APPROVAL, podDetailResponse);
        } else if (podDetailsModel.receivedQty > podDetailsModel.expectedQty) {
          if (podDetailsModel.damagedQty > 0)
            alertOnNavigateToPODWebView(BusinessConstants.STR_EXCESS_WITH_CONDITIONAL_POD_GENERATED_AND_SENT_FOR_WAREHOUSE_MANAGER_APPROVAL, podDetailResponse);
          else
            alertOnNavigateToPODWebView(BusinessConstants.STR_EXCESS_POD_GENERATED_AND_SENT_FOR_WAREHOUSE_MANAGER_APPROVAL, podDetailResponse);
        }
      }
    } else {
      CustomAlerts.showToast(StringConstants.NO_INTERNET_CONNECTION);
    }
  }

  alertOnNavigateToPODWebView(String message, String htmlData) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: new Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                navigateToPODWebView(htmlData);
              },
            ),
          ],
        );
      },
    );
  }

  navigateToPODWebView(String htmlData) async {
    var data = NavigationUtils.push(
        context,
        CustomWebView(
          title: 'POD',
          path: htmlData,
          isPrintable: true,
        ));
    data.whenComplete(() {
      navigateToHomeView();
    });
  }

  navigateToHomeView() {
    return NavigationUtils.pushAndRemoveUntil(context, HomeView());
  }

}
