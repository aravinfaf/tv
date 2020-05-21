
import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'PartScanningInbound.jser.dart';

@GenSerializer()
class PartScanningInboundSerializer extends Serializer<PartScanningInbound>
    with _$PartScanningInboundSerializer {}

class PartScanningInbound {

  String accountId;
  String currentBin;
  String orderId;
  String partsInOrderId;
  String partsMasterId;
  int pickedQty;
  int randomPickStatus;
  String serialNumber;
  String siteMasterId;
  String warehouseInboundId;



  String binLabel;
  String warehouseManagerId;

  String ordersMasterId;
  String partMasterId;

  String actorId;

  PartScanningInbound({
    this.accountId,
    this.currentBin,
    this.orderId,
    this.partsInOrderId,
    this.partsMasterId,
    this.pickedQty,
    this.randomPickStatus,
    this.serialNumber,
    this.siteMasterId,
    this.warehouseInboundId,



    this.binLabel,
    this.warehouseManagerId,

    this.ordersMasterId,
    this.partMasterId,
    this.actorId
  });
}
