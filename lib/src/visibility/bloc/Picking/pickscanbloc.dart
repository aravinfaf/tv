import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:tvs_visibility/src/visibility/model/picking/PartScanningInbound.dart';
import 'package:tvs_visibility/src/visibility/model/picking/PickingAlternateLocationResult.dart';
import 'package:tvs_visibility/src/visibility/model/picking/PickingExcessMaster.dart';
import 'package:tvs_visibility/src/visibility/model/picking/PickingResult.dart';
import 'package:tvs_visibility/src/visibility/repository/Picking/pickingrepos.dart';

class PickScanBloc {
  PickingRespos mPickingRepository;
  var mProgressBar=BehaviorSubject<bool>();

  PickScanBloc(this.mPickingRepository);

  var scan = BehaviorSubject<int>();

  dispose(){
    scan.close();
    mProgressBar.close();
  }

  Function(bool) get showProgress => mProgressBar.sink.add;

  Observable<bool> get isLoad => mProgressBar.stream;

  void setScanCode(int val) {
    scan.sink.add(val);
  }
  Observable<int> get scanCode=>scan.stream;


  Future<PickScanningResult> onpartScanningInbound(PartScanningInbound partScanningInbound) async {
    showProgress(true);
    PickScanningResult result = await mPickingRepository.partScanningInbound(partScanningInbound);
    showProgress(false);
    return result;
  }

  Future<PickScanningResult> onpartScanningOutbound(PartScanningInbound partScanningInbound) async {
    showProgress(true);
    PickScanningResult result = await mPickingRepository.partScanningOutbound(partScanningInbound);
    showProgress(false);
    return result;
  }

  Future<int> onShortPicking(ExcessMaster model) async {
    showProgress(true);
    int data = await mPickingRepository.shortPicking(model);
    showProgress(false);
    return data;
  }

  Future<AlternateLocationResult> onAlternatePicking(PartScanningInbound partScanningInbound) async {
    showProgress(true);
    AlternateLocationResult result = await mPickingRepository.onAlternatePicking(partScanningInbound);
    showProgress(false);
    return result;
  }

  // Future<String> onVpartPickingLabel(OutboundLabel model) async {
  Future<String> onVpartPickingLabel(String siteMasterId, String warehouseInboundId, String binLabel, String partsInOrderId) async {
    showProgress(true);
    var str = await mPickingRepository.onVpartPickingLabel(
        siteMasterId, warehouseInboundId, binLabel, partsInOrderId);
    showProgress(false);
    return str;
  }

  Future<int> getRandomPickRequest(PartScanningInbound partScanningInbound) async {
    showProgress(true);
    int data = await mPickingRepository.onRandomPickRequest(partScanningInbound);
    showProgress(false);
    return data;
  }
}
