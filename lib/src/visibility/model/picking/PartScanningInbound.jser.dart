// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PartScanningInbound.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$PartScanningInboundSerializer
    implements Serializer<PartScanningInbound> {
  @override
  Map<String, dynamic> toMap(PartScanningInbound model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'accountId', model.accountId);
    setMapValue(ret, 'currentBin', model.currentBin);
    setMapValue(ret, 'orderId', model.orderId);
    setMapValue(ret, 'partsInOrderId', model.partsInOrderId);
    setMapValue(ret, 'partsMasterId', model.partsMasterId);
    setMapValue(ret, 'pickedQty', model.pickedQty);
    setMapValue(ret, 'randomPickStatus', model.randomPickStatus);
    setMapValue(ret, 'serialNumber', model.serialNumber);
    setMapValue(ret, 'siteMasterId', model.siteMasterId);
    setMapValue(ret, 'warehouseInboundId', model.warehouseInboundId);
    setMapValue(ret, 'binLabel', model.binLabel);
    setMapValue(ret, 'warehouseManagerId', model.warehouseManagerId);
    setMapValue(ret, 'ordersMasterId', model.ordersMasterId);
    setMapValue(ret, 'partMasterId', model.partMasterId);
    setMapValue(ret, 'actorId', model.actorId);
    return ret;
  }

  @override
  PartScanningInbound fromMap(Map map) {
    if (map == null) return null;
    final obj = PartScanningInbound();
    obj.accountId = map['accountId'] as String;
    obj.currentBin = map['currentBin'] as String;
    obj.orderId = map['orderId'] as String;
    obj.partsInOrderId = map['partsInOrderId'] as String;
    obj.partsMasterId = map['partsMasterId'] as String;
    obj.pickedQty = map['pickedQty'] as int;
    obj.randomPickStatus = map['randomPickStatus'] as int;
    obj.serialNumber = map['serialNumber'] as String;
    obj.siteMasterId = map['siteMasterId'] as String;
    obj.warehouseInboundId = map['warehouseInboundId'] as String;
    obj.binLabel = map['binLabel'] as String;
    obj.warehouseManagerId = map['warehouseManagerId'] as String;
    obj.ordersMasterId = map['ordersMasterId'] as String;
    obj.partMasterId = map['partMasterId'] as String;
    obj.actorId = map['actorId'] as String;
    return obj;
  }
}
