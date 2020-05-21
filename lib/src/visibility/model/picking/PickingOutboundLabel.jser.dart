// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PickingOutboundLabel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$OutboundLabelSerializer implements Serializer<OutboundLabel> {
  @override
  Map<String, dynamic> toMap(OutboundLabel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'noOfLabels', model.noOfLabels);
    setMapValue(ret, 'ordersMasterId', model.ordersMasterId);
    setMapValue(ret, 'partsInOrderId', model.partsInOrderId);
    setMapValue(ret, 'partsMasterId', model.partsMasterId);
    setMapValue(ret, 'siteMasterId', model.siteMasterId);
    setMapValue(ret, 'stockTypeId', model.stockTypeId);
    setMapValue(ret, 'wareHouseInboundId', model.wareHouseInboundId);
    return ret;
  }

  @override
  OutboundLabel fromMap(Map map) {
    if (map == null) return null;
    final obj = OutboundLabel();
    obj.noOfLabels = map['noOfLabels'] as int;
    obj.ordersMasterId = map['ordersMasterId'] as String;
    obj.partsInOrderId = map['partsInOrderId'] as String;
    obj.partsMasterId = map['partsMasterId'] as String;
    obj.siteMasterId = map['siteMasterId'] as String;
    obj.stockTypeId = map['stockTypeId'] as String;
    obj.wareHouseInboundId = map['wareHouseInboundId'] as String;
    return obj;
  }
}
