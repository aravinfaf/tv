import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'PartScanningInboundMapping.jser.dart';

@GenSerializer()
class PartScanningInboundMappingSerilizer extends Serializer<PartScanningInboundMapping>
    with _$PartScanningInboundMappingSerilizer {}

class PartScanningInboundMapping {
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

  PartScanningInboundMapping({
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
  });
}