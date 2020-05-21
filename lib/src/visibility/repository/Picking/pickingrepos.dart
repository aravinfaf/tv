import 'package:tvs_visibility/src/visibility/model/picking/CustomPickList.dart';
import 'package:tvs_visibility/src/visibility/model/picking/PartScanningInbound.dart';
import 'package:tvs_visibility/src/visibility/model/picking/PickingAlternateLocationResult.dart';
import 'package:tvs_visibility/src/visibility/model/picking/PickingExcessMaster.dart';
import 'package:tvs_visibility/src/visibility/model/picking/PickingResult.dart';
import 'package:tvs_visibility/src/visibility/networkprovider/picking/pickingnetprovider.dart';

class PickingRespos {
  PickingProvider mPickingNetProvider;

  PickingRespos(this.mPickingNetProvider);

  Future<CustomPickList> getpickingList(CustomPickList model) async {
    return await mPickingNetProvider.onpickingList(model);
  }

  Future<int> shortPicking(ExcessMaster model) async {
    return await mPickingNetProvider.onShortPick(model);
  }

  Future<PickScanningResult> partScanningInbound(PartScanningInbound partScanningInbound) async {
    return await mPickingNetProvider.partScanningInbound(partScanningInbound);
  }

  Future<PickScanningResult> partScanningOutbound(PartScanningInbound partScanningInbound) async {
    return await mPickingNetProvider.partScaningOutbound(partScanningInbound);
  }

  Future<AlternateLocationResult> onAlternatePicking(PartScanningInbound partScanningInbound) async {
    return await mPickingNetProvider.getAlternateLocation(partScanningInbound);
  }

  Future<String> onVpartPickingLabel(String siteMasterId,
      String warehouseInboundId, String binLabel, String partsInOrderId) async {
    return await mPickingNetProvider.getVpartPickingLabel(
        siteMasterId, warehouseInboundId, binLabel, partsInOrderId);
  }

  Future<int> onRandomPickRequest(PartScanningInbound partScanningInbound) async {
    return await mPickingNetProvider.onRandomPickRequest(partScanningInbound);
  }
}
