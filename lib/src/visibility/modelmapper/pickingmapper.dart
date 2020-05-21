import 'package:tvs_visibility/src/visibility/model/picking/CustomPickList.dart';
import 'package:tvs_visibility/src/visibility/model/picking/pickingmodel.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/base/mapper.dart';

class PickingModelMapper extends Mapper<PickingLocationModel, PickLocationDTOList> {
  PickingModelMapper();

  @override
  PickingLocationModel reverse(PickLocationDTOList outer) {
    return new PickingLocationModel(
        orderId: outer.orderId,
        pickLocation: outer.pickLocation,
        accountId: outer.accountId,
        currentBin: outer.currentBin,
        currentBinQuantity: outer.currentBinQuantity,
        partMasterId: outer.partMasterId,
        partNumber: outer.partNumber,
        vPart: outer.vPart,
        refNo: outer.refNo,
        randomPickStatus: outer.randomPickStatus,
        warehouseInboundId: outer.warehouseInboundId,
        status: outer.status,
        requestedQuantity: outer.requestedQuantity,
        stockTypeId: outer.stockTypeId,
        partsInOrderId: outer.partsInOrderId,
        packedQuantity: outer.packedQuantity,
        pickedQuantity: outer.pickedQuantity,
        stockType: outer.stockType,
        pickCreatedDate: outer.pickCreatedDate,
      actorId: outer.actorId,
      siteId: outer.siteId,
      allowedQty: outer.allowedQty
    );
  }

  @override
  PickLocationDTOList transform(PickingLocationModel inner) {
    return null;
  }
}
