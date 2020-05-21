import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/io_client.dart';
import 'package:jaguar_resty/routes/routes.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:kiwi/kiwi.dart';
import 'package:tvs_visibility/src/visibility/apiinterface/apiinterface.dart';
import 'package:tvs_visibility/src/visibility/bloc/Picking/pickingbloc.dart';
import 'package:tvs_visibility/src/visibility/bloc/Picking/pickscanbloc.dart';
import 'package:tvs_visibility/src/visibility/bloc/binningbloc/bininfodetailsbloc.dart';
import 'package:tvs_visibility/src/visibility/bloc/binningbloc/binlistbloc.dart';
import 'package:tvs_visibility/src/visibility/bloc/binningbloc/binscanbloc.dart';
import 'package:tvs_visibility/src/visibility/bloc/dispatchbloc/dispatchlistingbloc.dart';
import 'package:tvs_visibility/src/visibility/bloc/dispatchbloc/dispatchviewbloc.dart';
import 'package:tvs_visibility/src/visibility/bloc/gateinout/gatelistbloc.dart';
import 'package:tvs_visibility/src/visibility/bloc/homebloc.dart';
import 'package:tvs_visibility/src/visibility/bloc/loginbloc.dart';
import 'package:tvs_visibility/src/visibility/bloc/podbloc/podbloc.dart';
import 'package:tvs_visibility/src/visibility/bloc/podbloc/savepodbloc.dart';
import 'package:tvs_visibility/src/visibility/bloc/singlebintobinbloc/singlebintobinbloc.dart';
import 'package:tvs_visibility/src/visibility/bloc/preBinning/preBinningBloc.dart';
import 'package:tvs_visibility/src/visibility/bloc/preBinning/preBinningScanBloc.dart';
import 'package:tvs_visibility/src/visibility/constants/baseconstants.dart';
import 'package:tvs_visibility/src/visibility/dataprovider/sharedprefs.dart';
import 'package:tvs_visibility/src/visibility/model/authorizationrequestmodel/authorizationrequestmodel.dart';
import 'package:tvs_visibility/src/visibility/model/authorizationresponsemodel/authorizationresponsemodel.dart';
import 'package:tvs_visibility/src/visibility/model/bininfodetailsmodel/bininfodetailsmodel.dart';
import 'package:tvs_visibility/src/visibility/model/binmodel/binningScanHQ.dart';
import 'package:tvs_visibility/src/visibility/model/binmodel/binsavepart.dart';
import 'package:tvs_visibility/src/visibility/model/binmodel/binvalidationresult.dart';
import 'package:tvs_visibility/src/visibility/model/binninglistmodel/binninglistmodel.dart';
import 'package:tvs_visibility/src/visibility/model/binsmasterdto/binsmasterdto.dart';
import 'package:tvs_visibility/src/visibility/model/checkpodbybusinesskeymodel/checkpodbybusinesskeymodel.dart';
import 'package:tvs_visibility/src/visibility/model/despatchlistmodel/activetaskresponsemodel.dart';
import 'package:tvs_visibility/src/visibility/model/despatchlistmodel/despatchdetailstatusmodel.dart';
import 'package:tvs_visibility/src/visibility/model/despatchlistmodel/dispatchdetailsmodel.dart';
import 'package:tvs_visibility/src/visibility/model/despatchlistmodel/scandespatchmodel.dart';
import 'package:tvs_visibility/src/visibility/model/endcustomerdetailmodel/endcustomerdetailmodel.dart';
import 'package:tvs_visibility/src/visibility/model/gateinout/creategatein.dart';
import 'package:tvs_visibility/src/visibility/model/gateinout/creategateout.dart';
import 'package:tvs_visibility/src/visibility/model/getdispatchdetailsmodel/getdispatchdetailsmodel.dart';
import 'package:tvs_visibility/src/visibility/model/getmodeoftransportmodel/getmodeoftransportmodel.dart';
import 'package:tvs_visibility/src/visibility/model/loginrequestmodel/loginrequestmodel.dart';
import 'package:tvs_visibility/src/visibility/model/loginresponsemodel/loginresponsemodel.dart';
import 'package:tvs_visibility/src/visibility/model/notificationData/notificationDataModel.dart';
import 'package:tvs_visibility/src/visibility/model/picking/CustomPickList.dart';
import 'package:tvs_visibility/src/visibility/model/picking/PartScanningInbound.dart';
import 'package:tvs_visibility/src/visibility/model/picking/PartScanningInboundMapping.dart';
import 'package:tvs_visibility/src/visibility/model/picking/PickingAlternateLocationResult.dart';
import 'package:tvs_visibility/src/visibility/model/picking/PickingExcessMaster.dart';
import 'package:tvs_visibility/src/visibility/model/picking/PickingExcessMasterMapping.dart';
import 'package:tvs_visibility/src/visibility/model/picking/PickingOutboundLabel.dart';
import 'package:tvs_visibility/src/visibility/model/picking/PickingResult.dart';
import 'package:tvs_visibility/src/visibility/model/podmodel/checkpodkeymodel.dart';
import 'package:tvs_visibility/src/visibility/model/podmodel/postfiltermodel.dart';
import 'package:tvs_visibility/src/visibility/model/podmodel/postpoddetailsmodel.dart';
import 'package:tvs_visibility/src/visibility/model/podmodel/savepodmodel.dart';
import 'package:tvs_visibility/src/visibility/model/postbinningfiltermodel/postbinningfiltermodel.dart';
import 'package:tvs_visibility/src/visibility/model/preBinning/PreBinningScanRequestModel.dart';
import 'package:tvs_visibility/src/visibility/model/preBinning/preBinningModel.dart';
import 'package:tvs_visibility/src/visibility/model/preBinning/preBinningRequestModel.dart';
import 'package:tvs_visibility/src/visibility/model/preBinning/preBinningScanResponseModel.dart';
import 'package:tvs_visibility/src/visibility/model/vpartspostresponsemodel/vpartspostresponsemodel.dart';
import 'package:tvs_visibility/src/visibility/modelmapper/pickingmapper.dart';
import 'package:tvs_visibility/src/visibility/networkprovider/binnetworkprovider.dart';
import 'package:tvs_visibility/src/visibility/networkprovider/dispatchprovider/dispatchprovider.dart';
import 'package:tvs_visibility/src/visibility/networkprovider/gateinout/gatenetprovider.dart';
import 'package:tvs_visibility/src/visibility/networkprovider/loginnetprovider.dart';
import 'package:tvs_visibility/src/visibility/networkprovider/picking/pickingnetprovider.dart';
import 'package:tvs_visibility/src/visibility/networkprovider/podprovider/podnetprovider.dart';
import 'package:tvs_visibility/src/visibility/networkprovider/podprovider/savepodprovider.dart';
import 'package:tvs_visibility/src/visibility/networkprovider/preBinningProvider/preBinningProvider.dart';
import 'package:tvs_visibility/src/visibility/networkprovider/singlebintobinprovider/singlebintobinprovider.dart';
import 'package:tvs_visibility/src/visibility/repository/Picking/pickingrepos.dart';
import 'package:tvs_visibility/src/visibility/repository/binrepository.dart';
import 'package:tvs_visibility/src/visibility/repository/dispatchrepository/dispatchrepository.dart';
import 'package:tvs_visibility/src/visibility/repository/gateinout/gaterepository.dart';
import 'package:tvs_visibility/src/visibility/repository/homerepository.dart';
import 'package:tvs_visibility/src/visibility/repository/loginrepository.dart';
import 'package:tvs_visibility/src/visibility/repository/podrepository/podrepository.dart';
import 'package:tvs_visibility/src/visibility/repository/podrepository/savepodrepository.dart';
import 'package:tvs_visibility/src/visibility/repository/preBinningRepository/preBinningRepository.dart';
import 'package:tvs_visibility/src/visibility/repository/singlebintobinrepository/singlebintobinrepository.dart';
import 'package:tvs_visibility/src/visibility/utililty/utils.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/customview/customtoast.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/bloc/binScanningBloc.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/bloc/orderdetailslistingbloc.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/bloc/postbindetailsbloc.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/model/binlocationmodel/binScanningRequest.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/model/binlocationmodel/binScanningResponse.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/model/binlocationmodel/binlocationmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/model/ordermastermodel/ordermastermodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/model/partorbinvalidationmodel/partorbinvalidationmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/model/postbindetailsmodel/postbindetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/model/postfilterdetailsmodel/postfilterdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/netprovider/binnetprovider.dart'
as vdBinNetProvider;
import 'package:tvs_visibility/src/visibilitydealer/binning/netprovider/ordermasternetprovider.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/repository/binrepository.dart'
as vdBinRepository;
import 'package:tvs_visibility/src/visibilitydealer/binning/repository/ordermasterrepository.dart';
import 'package:tvs_visibility/src/visibilitydealer/bintobintransfer/bloc/singlebintobintransferbloc.dart';
import 'package:tvs_visibility/src/visibilitydealer/bintobintransfer/model/binmasterdetailsmodel/binmasterdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/bintobintransfer/model/binmasterdetailsrequestmodel/binmasterdetailsrequestmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/constants/baseconstants.dart' as prefix0;
import 'package:tvs_visibility/src/visibilitydealer/picking/bloc/partnoactionbloc.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/bloc/partnolocationbloc.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/bloc/partnumberdetailsbloc.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/bloc/partnumberscandetailsbloc.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/authorizesprintdetailsmodel/authorizesprintdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/authorizesprintrequestmodel/authorizesprintrequestmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/partnumberdetailsmodel/partnumberdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/partserialnumberdetailsmodel/partserialnumberdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/postdispatchmasterdetailsmodel/postdispatchmasterdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/postpartmasterdetailsmodel/postpartmasterdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/netprovider/partnoapiprovider.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/netprovider/partnooutwardprovider.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/netprovider/partsearchapiprovider.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/repository/partnooutwardrepository.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/repository/partnorepository.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/repository/partseachrepository.dart';

final Container container = new Container();

diConfig() {
  //BASE CONFIG
  sharedPrefs();
  jaguarRetrofit();
  //VISIBILITY
  //MODULES
  login();
  home();
  gateInOut();
  pod();
  binning();
  picking();

  //VISIBILITY DEALER
  //binning
  orderDetailsListing();
  postBinDetails();
  dealerBinning();

  //binToBinTransfer
  singleBinToBinTransfer();
  singleBinToBin();
  //picking
  partSearch();
  partNumberDetails();
  binLocation();
  partSerialNumberScanDetails();
  partNumberAction();
  partOutwardDetail();
  dispatchList();
  preBinningList();
  preBinningScanView();
}

void jaguarRetrofit() {
  container.registerSingleton((c) => globalClient = IOClient());
  container.registerSingleton((c) => JsonRepo()
    ..add(LoginRequestModelSerializer())
    ..add(LoginResponseModelSerializer())
    ..add(AuthorizationRequestModelSerializer())
    ..add(AuthorizationResponseModelSerializer())
    ..add(NotificationDataModelSerializer())
    ..add(WorkflowProcessMasterListSerializer())
    ..add(WorkflowActivityMasterListSerializer())
    ..add(FormFieldListSerializer())
    ..add(FormFieldPropertySerializer())
    ..add(GenericDtoListSerilizer())
    ..add(PostFilterModelSerilizer())
    ..add(GenericDtoListSerilizer())
    ..add(PostFilterModelSerilizer())
    ..add(CreateGateInModelSerilizer())
    ..add(PostFilterModelSerilizer())
    ..add(GenericDtoListSerilizer())
    ..add(CheckPodKeySerializer())
    ..add(SavePodModSerializer())
    ..add(PartsInOrderStatusDTOsSerializer())
    ..add(PostFilterModelSerilizer())
    ..add(GenericDtoListSerilizer())
    ..add(BinSavePartSerializer())
    ..add(BinValidationResultSerializer())
    ..add(BinsMasterDTOSerializer())
    ..add(PostPodDetailsModelSerializer())
    ..add(CreateGateOutModelSerilizer())
    ..add(BinningScanHQSerializer())
    ..add(PartNumberDetailsModelSerializer())
    ..add(PostDispatchMasterDetailsModelSerializer())
    ..add(OrderMasterModelSerializer())
    ..add(BinMasterDetailsModelSerializer())
    ..add(AuthorizeSprintDetailsModelSerializer())
    ..add(AuthorizeSprintRequestModelSerializer())
    ..add(BinLocationModelSerializer())
    ..add(PartOrBinValidationModelSerializer())
    ..add(PartSerialNumberDetailsModelSerializer())
    ..add(PostBinDetailsModelSerializer())
    ..add(PostPartMasterDetailsModelSerializer())
    ..add(PostFilterDetailsModelSerializer())
    ..add(BinMasterDetailsRequestModelSerializer())
    ..add(BinningListModelSerializer())
    ..add(PostBinningFilterModelSerializer())
    ..add(PickLocationDTOListSerilizer())
    ..add(CustomPickListSerilizer())
    ..add(PickScanningResultSerializer())
    ..add(ExcessMasterSerializer())
    ..add(ExcessMasterMappingSerilizer())
    ..add(PartScanningInboundSerializer())
    ..add(PartScanningInboundMappingSerilizer())
    ..add(OutboundLabelSerializer())
    ..add(AlternateLocationResultSerializer())
    ..add(CheckPODByBusinessKeyModelSerializer())
    ..add(VPartsPostResponseModelSerializer())
    ..add(CheckPODByBusinessKeyModelSerializer())
    ..add(DispatchDetailsDtoSerializer())
    ..add(DispatchListDTOSerializer())
    ..add(DispatchDetailsWrapperDTOSerializer())
    ..add(GetDispatchDetailsModelSerializer())
    ..add(ScanDespatchModelSerializer())
    ..add(EndCustomerDetailModelSerializer())
    ..add(GetModeOfTransportModelSerializer())
    ..add(DespatchDetailStatusSerializer())
    ..add(ActiveTaskConsolidationModelSerializer())
    ..add(BinScanningRequestSerializer())
    ..add(BinScanningResponseSerializer())
    ..add(PreBinningRequestModelSerializer())
    ..add(PreBinningResponseModelSerializer())
    ..add(PreBinningModelSerializer())
    ..add(PreBinningScanRequestModelSerializer())
    ..add(PreBinningScanResponseModelSerializer())
    ..add(BinInfoDetailsModelSerializer())
  );
  container.registerSingleton((c) => ApiInterface(
      Route(prefix0.BaseConstants.BASE_URL_TEST)
        ..before((req) async {
          req.header('content-type', 'application/json');
          req.header('timezone', await Utils.getTimeZone());
          req.header('AppId', '${BaseConstants.APP_ID}');
          req.header('AppDesc', BaseConstants.APP_DESC);
          print(req.getUrl);
          print(req.getHeaders);

          if (req is RouteWithBody) {
            print(req.getBody());
          }
        })
        ..after((res) {
          print(res.request.url);
          print(res.statusCode);
          if (Platform.isAndroid)
            Print.LogPrint(res.body);
          else
            debugPrint(res.body);
        })
        ..getClient = c<IOClient>())
    ..jsonConverter = c<JsonRepo>());
}

void sharedPrefs() {
  container.registerSingleton((c) => CustomSharedPrefs());
}

void login() {
  container.registerFactory((container) => LoginNetProvider(
      container<CustomSharedPrefs>(), container<ApiInterface>()));
  container.registerFactory(
          (container) => LoginRepository(container<LoginNetProvider>()));
  container
      .registerFactory((container) => LoginBloc(container<LoginRepository>()));
}

void home() {
  container.registerFactory(
          (container) => HomeRepository(container<CustomSharedPrefs>()));
  container
      .registerFactory((container) => HomeBloc(container<HomeRepository>()));
}

void gateInOut() {
  container.registerFactory((container) => GateNetProvider(
      container<ApiInterface>(), container<CustomSharedPrefs>()));
  container.registerFactory(
          (container) => GateRepository(container<GateNetProvider>()));
  container.registerFactory((container) => GateListBloc(
      container<GateRepository>(), container<CustomSharedPrefs>()));
}

void pod() {
  container.registerFactory((container) => PodNetProvider(
      container<ApiInterface>(), container<CustomSharedPrefs>()));
  container.registerFactory(
          (container) => PodRepository(container<PodNetProvider>()));
  container.registerFactory((container) => PodBloc(container<PodRepository>()));

  container.registerFactory((container) => SavePodProvider(
      container<CustomSharedPrefs>(), container<ApiInterface>()));
  container.registerFactory(
          (container) => SavePodRepository(container<SavePodProvider>()));
  container.registerFactory(
          (container) => PodDetailBloc(container<SavePodRepository>()));
}

void binning() {
  container.registerFactory((container) => BinNetProvider(
      container<ApiInterface>(), container<CustomSharedPrefs>()));
  container.registerFactory((container) => BinRepository(
      container<BinNetProvider>(), container<CustomSharedPrefs>()));
  container.registerFactory((container) =>
      BinListBloc(container<BinRepository>(), container<CustomSharedPrefs>()));
  container.registerFactory((container) =>
      BinScanBloc(container<BinRepository>(), container<CustomSharedPrefs>()));
  container.registerFactory((container) => BinInfoDetailsBloc(container<BinRepository>()));
}

void picking() {
  container.registerFactory((container) => PickingProvider(
      container<ApiInterface>(), container<CustomSharedPrefs>()));
  container.registerFactory(
          (container) => PickingRespos(container<PickingProvider>()));
  container.registerFactory((container) => PickingModelMapper());
  container.registerFactory((container) => PickBloc(container<PickingRespos>(),
      container<CustomSharedPrefs>(), container<PickingModelMapper>()));
  container
      .registerFactory((container) => PickScanBloc(container<PickingRespos>()));
}

void binLocation() {
  container.registerFactory((container) => PartLocationApiProvider(
      container<ApiInterface>(), container<CustomSharedPrefs>()));
  container.registerFactory(
          (container) => PartNoRepository(container<PartLocationApiProvider>()));
  container.registerFactory(
          (container) => PartNoLocationBloc(container<PartNoRepository>()));
}

void partSearch() {
  container.registerFactory((container) => PartSearchApiProvider(
      container<ApiInterface>(), container<CustomSharedPrefs>()));
  container.registerFactory(
          (container) => PartSearchRepository(container<PartSearchApiProvider>()));
}

void partOutwardDetail() {
  container.registerFactory((c) => PartNumberOutwardProvider(
      container<ApiInterface>(), container<CustomSharedPrefs>()));
  container.registerFactory((c) =>
      PartNumberOutwardRepository(container<PartNumberOutwardProvider>()));
}

void partNumberAction() {
  container.registerFactory(
          (c) => PartNumberActionBloc(container<PartNumberOutwardRepository>()));
}

void orderDetailsListing() {
  container.registerFactory((c) => OrderMasterNetProvider(
      container<ApiInterface>(), container<CustomSharedPrefs>()));
  container.registerFactory(
          (c) => OrderMasterRepository(container<OrderMasterNetProvider>()));
  container.registerFactory((container) =>
      OrderDetailsListingBloc(container<OrderMasterRepository>()));
}

void dispatchList() {
  container.registerFactory((c) => DispatchProvider(
      container<ApiInterface>(), container<CustomSharedPrefs>()));
  container.registerFactory(
          (c) => DispatchRepository(container<DispatchProvider>()));
  container.registerFactory((c) => DispatchListingBloc(container<DispatchRepository>(), container<CustomSharedPrefs>()));
  container.registerFactory((c) => DispatchViewBloc(container<DispatchRepository>(), container<CustomSharedPrefs>()));
}

void partNumberDetails() {
  container.registerFactory((container) => PartNumberDetailsBloc(
      container<PartSearchRepository>(), container<PartNoRepository>()));
}

postBinDetails() {
  container.registerFactory((container) => vdBinNetProvider.BinNetProvider(
      container<ApiInterface>(), container<CustomSharedPrefs>()));
  container.registerFactory((container) => vdBinRepository.BinRepository(
      container<vdBinNetProvider.BinNetProvider>(),
      container<CustomSharedPrefs>()));
  container.registerFactory((container) =>
      PostBinDetailsBloc(container<vdBinRepository.BinRepository>()));
}

partSerialNumberScanDetails() {
  container.registerFactory(
          (container) => PartNumberScanDetailBloc(container<PartNoRepository>()));
}

singleBinToBinTransfer() {
  container.registerFactory((container) =>
      SingleBinToBinTransferBloc(container<vdBinRepository.BinRepository>()));
}

singleBinToBin() {
  container.registerFactory((container)=>SingleBinToBinBloc(container<SingleBinToBinRepository>()));
container.registerFactory((container)=>SingleBinToBinRepository(container<SingleBinToBinProvider>(),container<CustomSharedPrefs>()));
container.registerFactory((container)=>SingleBinToBinProvider(container<CustomSharedPrefs>(),container<ApiInterface>()));
}
void dealerBinning() {
  container.registerFactory((container) =>
      BinScanningBloc(container<vdBinRepository.BinRepository>(), container<CustomSharedPrefs>()));
}

void preBinningList(){
  container.registerFactory((container) => PreBinningNetProvider(container<ApiInterface>(), container<CustomSharedPrefs>()));
  container.registerFactory((container) => PreBinningRepository(container<PreBinningNetProvider>()));
  container.registerFactory((c) => PreBinningBloc(c<PreBinningRepository>(), c<CustomSharedPrefs>()));
}

void preBinningScanView(){
  container.registerFactory((c) => PreBinningScanBloc(c<PreBinningRepository>(), c<CustomSharedPrefs>()));

}
