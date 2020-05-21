import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:tvs_visibility/src/visibility/bloc/dispatchbloc/dispatchviewbloc.dart';
import 'package:tvs_visibility/src/visibility/constants/StringConstants.dart';
import 'package:tvs_visibility/src/visibility/constants/businessconstants.dart';
import 'package:tvs_visibility/src/visibility/model/despatchlistmodel/despatchdetailstatusmodel.dart';
import 'package:tvs_visibility/src/visibility/model/despatchlistmodel/dispatchdetailsmodel.dart';
import 'package:tvs_visibility/src/visibility/model/despatchlistmodel/scandespatchmodel.dart';
import 'package:tvs_visibility/src/visibility/model/endcustomerdetailmodel/endcustomerdetailmodel.dart';
import 'package:tvs_visibility/src/visibility/model/getmodeoftransportmodel/getmodeoftransportmodel.dart';
import 'package:tvs_visibility/src/visibility/ui/despatch/dispatchdetailviewcontract.dart';
import 'package:tvs_visibility/src/visibility/ui/despatch/modeoftransportlistingitems.dart';
import 'package:tvs_visibility/src/visibility/ui/despatch/modeoftransportlistingview.dart';
import 'package:tvs_visibility/src/visibility/ui/despatch/sitenamelistingitems.dart';
import 'package:tvs_visibility/src/visibility/ui/despatch/sitenamelistingview.dart';
import 'package:tvs_visibility/src/visibility/utililty/utils.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customalerts/customalerts.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customprogressindicator/customprogress.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customprogressindicator/customretry.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customview/custompdfview.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customview/customtoast.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/navigaton/navigationutils.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/assetsconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/baseconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/utility/utils.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/barcodescanner/barcodescanner.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/custompopup/popupwindow.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customraisedbutton.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customtext.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customtextfield.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customtextformfield.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/widgets/customtextview.dart';

import '../homeview.dart';

class DispatchDetailView extends StatefulWidget {
  DispatchListDTO model;

  DispatchDetailView(this.model);

  @override
  DispatchDetailViewState createState() => DispatchDetailViewState(this.model);
}

class DispatchDetailViewState extends State<DispatchDetailView>
    implements
        SiteNameListener,
        ModeOfTransportListener,
        DispatchDetailViewContract {
  TextEditingController tecSiteName = TextEditingController();
  TextEditingController tecModeOfTransport = TextEditingController();
  TextEditingController tecVehicleOrCourier = TextEditingController();
  TextEditingController tecCartonOrLPN = TextEditingController();
  DispatchListDTO model;
  String mModeOfTransportId;
  DispatchViewBloc dispatchBloc;
  Function retry;
  bool mDispatchDetailsAlreadyScanned = false;
  bool mSuccess = false;
  final formKey = new GlobalKey<FormState>();
  String mValidationMessage;
  DespatchDetailStatus despatchDetailStatus;
  ScanDespatchModel scanDespatchModel;
  String scannedCarton = '';

  DispatchDetailViewState(this.model) {
    var container = kiwi.Container();
    dispatchBloc = container<DispatchViewBloc>();
    dispatchBloc.mView = this;
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    dispatchBloc.showProgress(true);
    tecSiteName.text = model.mDestinationId;
    mModeOfTransportId = model.mModeOfTransportMasterId;

    await dispatchBloc.getDispatchDetails(model.mDeliveryTypeId,
        model.mConsolidationId, model.mActorName, model.mOrderMasterId);
    await dispatchBloc.getModeOfTransport();
    await dispatchBloc.getDespatchStatus(model.mConsolidationId).then((onValue) {
      despatchDetailStatus = onValue;
    });
    if (model.mModeOfTransportMasterId == "ABCM16001") {
      setAlreadyScannedDispatchDetails(true);
      tecVehicleOrCourier.text = model.mVehicleNumber;
      tecModeOfTransport.text = 'Vehicle';
    } else if (model.mModeOfTransportMasterId == "ABCM16002") {
      setAlreadyScannedDispatchDetails(true);
      tecVehicleOrCourier.text = model.mCourierName;
      tecModeOfTransport.text = 'Courier';
    }
    dispatchBloc.showProgress(false);
  }

  @override
  void dispose() {
    dispatchBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
        initialData: true,
        stream: dispatchBloc.isLoad,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && !snapshot.data)
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text("Dispatch Detail"),
              ),
              body: ListView(
                children: <Widget>[
                  Container(
                    child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            !Utility.isEmpty(mValidationMessage)
                                ? CustomText(
                              text: "${mValidationMessage ?? ""}",
                              fontFamily:
                              AssetsConstants.OPEN_SANS_SEMI_BOLD,
                              fontSize: 18,
                              textColor:
                              mSuccess ? Colors.green : Colors.red,
                            )
                                : Container(
                              height: 0,
                            ),
                            !Utility.isEmpty(mValidationMessage)
                                ? SizedBox(
                              height: 10,
                            )
                                : Container(
                              height: 0,
                            ),
                            CustomTextView(
                              title: "Order Id",
                              text: convertOrderMasterListToString(
                                  despatchDetailStatus.mOrderList) ??
                                  '-',
                            ),
                            CustomTextView(
                              title: "Scanned/Total Dispatch Carton",
                              text: "${despatchDetailStatus
                                  .mScannedDespatchCartons}" +
                                  '/' +
                                  "${despatchDetailStatus
                                      .mTotalDespatchCartons}",
                            ),
                            CustomTextView(
                              title: "Scanned/Total Unconsolidated LPN",
                              text: "${despatchDetailStatus
                                  .mTotalScannedUnconsolidatedLPN}" +
                                  '/' +
                                  "${despatchDetailStatus
                                      .mTotalUnconsolidatedLPN}",
                            ),
                            CustomTextView(
                              title: "Scanned/Total Picked LPN",
                              text: "${despatchDetailStatus.mTotalScannedLPN}" +
                                  '/' +
                                  "${despatchDetailStatus.mTotalPickedLPN}",
                            ),
                            CustomTextView(
                              title: "Dispatch Type",
                              text: "${model.mDevliverTypeDesc}" ?? "-",
                            ),
                            siteNameDialog(),
                            SizedBox(height: 7),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Expanded(
                                    child: CustomTextField(
                                      title: 'Carton No/ LPN',
                                      hint: "Scan Carton No/LPN",
                                      controller: tecCartonOrLPN,
                                      suffixIcon: Icon(
                                        Icons.send,
                                        color: tecCartonOrLPN.text.length!=0?Colors.blue[900]:Colors.grey,
                                      ),
                                      onPressSuffixIcon: () {
                                        if (this.formKey.currentState
                                            .validate()) {
                                          formKey.currentState.save();
                                          if (tecCartonOrLPN.text != null &&
                                              tecCartonOrLPN.text.length != 0) {
                                            dispatchBloc.scanDespatch(
                                                model,
                                                tecModeOfTransport.text,
                                                tecVehicleOrCourier.text,
                                                tecCartonOrLPN.text,
                                                mModeOfTransportId);
                                          }
                                        } else {
                                          return null;
                                        }
                                      },onChanged: (str){
                                        dispatchBloc.showProgress(false);
                                    },
                                    )),
                                SizedBox(width: 10),
                                iconCamera()
                              ],
                            )
                          ],
                        )),
                    margin: EdgeInsets.all(10),
                  )
                ],
              ),
              bottomNavigationBar: CustomRaisedButton(
                  textColor: Colors.white,
                  buttonColor: Colors.blue,
                  text: "Finish",
                  onPress: () {
                    if (tecVehicleOrCourier.text != null &&
                        tecVehicleOrCourier.text.length != 0) {
                      finishDispatch(
                          tecVehicleOrCourier.text, model.mConsolidationId);
                    } else {
                      CustomToast.showToast(
                          BusinessConstants.DISPATCH_AT_LEAST_ONE);
                    }
                  }),
            );
          else if (snapshot.hasError)
            return Scaffold(
                backgroundColor: Colors.white, body: CustomRetry(retry: retry));
          else
            return CustomProgress();
        });
  }

  convertOrderMasterListToString(List<String> model) {
    var concatenate = StringBuffer();
    if(model!=null) {
      if (model.length != 1) {
        concatenate.write(model.join('/'));
      } else {
        concatenate.write(model.first);
      }
    }
    else
      concatenate.write('-');
    return concatenate.toString();
  }

  Widget iconCamera() {
    return GestureDetector(
      onTap: () {
        tecCartonOrLPN.clear();
        scanCarton();
      },
      child: Image(image: AssetImage(BaseConstants.IMAGES_CAMERA)),
    );
  }

  scanCarton() async {
    scannedCarton = await BarCodeScanner.barcodeScanning(
        context: context, isVisibility: true);

    if ((scannedCarton != BaseConstants.STR_CANCELLED) &&
        (scannedCarton != BaseConstants.STR_PERMISSION_NOT_GRANTED) &&
        (scannedCarton != BaseConstants.STR_RECAPTURE_BARCODE)) {
      CustomToast.showToast(scannedCarton);
      if (Utils.regexCompare(scannedCarton))
        CustomToast.showToast(
            "${BaseConstants.STR_RECAPTURE_BARCODE}: $scannedCarton");
      else {
        tecCartonOrLPN.text = scannedCarton;
        dispatchBloc.showProgress(false);
        if (this.formKey.currentState
            .validate()) {
          dispatchBloc.scanDespatch(
              model,
              tecModeOfTransport.text,
              tecVehicleOrCourier.text,
              scannedCarton,
              mModeOfTransportId);
        }
      }
    } else {
      CustomToast.showToast(scannedCarton);
    }
  }

  Widget siteNameDialog() {
    if (model.mDeliveryTypeId == "DITM8") {
      return Container(
          child: Column(
            children: <Widget>[
              CustomTextView(
                title: "Address",
                text: "${model.mAddress}" ?? "-",
              ),
              CustomTextView(
                title: "Company",
                text: "${model.mCompany}" ?? "-",
              ),
              SizedBox(
                height: 5,
              ),
              modeOfTransportDialog(),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                title: 'Vehicle/Courier',
                hint: "Vehicle/Courier",
                enable: !mDispatchDetailsAlreadyScanned,
                controller: tecVehicleOrCourier,
                onValidate: (val) {
                  return Utility.isEmpty(val)
                      ? 'Please select a vehicle/courier'
                      : null;
                },
              ),
            ],
          ));
    } else if (model.mDeliveryTypeId == "DITM1") {
      return Container(
        child: Column(
          children: <Widget>[
            Container(
              child: InkWell(
                onTap: () {
                  onSiteNamePopUp("${model.mDevliverTypeDesc}");
                },
                child: CustomTextFormField(
                  hint: 'Select Site Name',
                  enable: false,
                  numbersOnly: true,
                  inputType: TextInputType.text,
                  title: "${model.mDevliverTypeDesc}",
                  isTitleRequired: true,
                  controller: tecSiteName,
                  onValidate: (val) {
                    return Utility.isEmpty(val)
                        ? 'Please select site name'
                        : null;
                  },
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
              //
                //   onSiteNamePopUp("End Customer");
              },
              child:
              CustomTextFormField(
                hint: 'Select Site Name',
                enable: false,
                numbersOnly: true,
                inputType: TextInputType.text,
                title:"${model.mDevliverTypeDesc}",
                isTitleRequired: true,
                controller: tecSiteName,
                onValidate: (val) {
                  return Utility.isEmpty(val)
                      ? 'Please select site name'
                      : null;
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            modeOfTransportDialog(),
            SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              title: 'Vehicle/Courier',
              hint: "Vehicle/Courier",
              enable: !mDispatchDetailsAlreadyScanned,
              controller: tecVehicleOrCourier,
              onValidate: (val) {
                return Utility.isEmpty(val)
                    ? 'Please select a vehicle/courier'
                    : null;
              },
            ),
          ],
        ),
      );
    }
  }

  Widget modeOfTransportDialog() {
    return Container(
      child: InkWell(
        onTap: () {
          if (!mDispatchDetailsAlreadyScanned) onModeOfTransportPopUp();
        },
        child: CustomTextFormField(
          hint: 'Select Mode of Transport',
          enable: false,
          numbersOnly: true,
          inputType: TextInputType.text,
          title: 'Mode of Transport',
          isTitleRequired: true,
          controller: tecModeOfTransport,
          onValidate: (val) {
            return Utility.isEmpty(val)
                ? 'Please select mode of transport'
                : null;
          },
        ),
      ),
    );
  }

  void onSiteNamePopUp(String siteName) async {
    if (await Utility.onCheckNetworkConnection())
      PopUpWindow(
          title: siteName,
          context: context,
          content: SiteNameListingView(this, dispatchBloc.mEndCustomerDetails));
    else
      CustomToast.showToast(BaseConstants.STR_NO_INTERNET);
  }

  void onModeOfTransportPopUp() async {
    if (await Utility.onCheckNetworkConnection())
      PopUpWindow(
          title: 'Mode of Transport',
          context: context,
          content:
          ModeOfTransportListingView(this, dispatchBloc.mModeOfTransport));
    else
      CustomToast.showToast(BaseConstants.STR_NO_INTERNET);
  }

  @override
  void onItemSelect(BuildContext context, EndCustomerDetailModel item) {
    tecSiteName.text = item.mId;
  }

  @override
  void onModeOfTransportItemSelect(BuildContext context,
      GetModeOfTransportModel item) {
    tecModeOfTransport.text = item.mModeDescription;
    mModeOfTransportId = item.mId;
  }

  @override
  setValidationMessage(String validationMessage, bool isSuccess) {
    mValidationMessage = validationMessage;
    mSuccess = isSuccess;
  }

  @override
  setDispatchDetails(DespatchDetailStatus dispatchDetails) {
    this.despatchDetailStatus.mTotalPickedLPN = dispatchDetails.mTotalPickedLPN;
    this.despatchDetailStatus.mTotalScannedLPN = dispatchDetails.mTotalScannedLPN;
    this.despatchDetailStatus.mTotalUnconsolidatedLPN =
        dispatchDetails.mTotalUnconsolidatedLPN;
    this.despatchDetailStatus.mTotalScannedUnconsolidatedLPN =
        dispatchDetails.mTotalScannedUnconsolidatedLPN;
    this.despatchDetailStatus.mTotalDespatchCartons =
        dispatchDetails.mTotalDespatchCartons;
    this.despatchDetailStatus.mScannedDespatchCartons =
        dispatchDetails.mScannedDespatchCartons;
  }

  @override
  setAlreadyScannedDispatchDetails(bool scanned) {
    mDispatchDetailsAlreadyScanned = scanned;
  }

  @override
  getTecCartonOrLPN() {
    return tecCartonOrLPN;
  }

  navigateToDespatchWebView(String htmlData) async {
    var data = NavigationUtils.push(
        context, MyPdfView(title: 'Package Slip', path: htmlData));
    data.whenComplete(() {
      NavigationUtils.pushAndRemoveUntil(context, HomeView());
    });
  }

  void finishDispatch(String vId, String consolidationId) async {
    if (await Utils.onCheckNetworkConnection()) {
      var generatePackingResponse =
      await dispatchBloc.generatePackingSlip(vId, consolidationId,mModeOfTransportId);
      if (generatePackingResponse != null &&
          generatePackingResponse != "ERROR") {
        navigateToDespatchWebView(generatePackingResponse);
      }
    } else {
      CustomAlerts.showToast(StringConstants.NO_INTERNET_CONNECTION);
    }
  }
}
