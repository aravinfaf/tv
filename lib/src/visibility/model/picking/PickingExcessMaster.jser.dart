// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PickingExcessMaster.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$ExcessMasterSerializer implements Serializer<ExcessMaster> {
  Serializer<ExcessMasterMapping> __excessMasterMappingSerilizer;
  Serializer<ExcessMasterMapping> get _excessMasterMappingSerilizer =>
      __excessMasterMappingSerilizer ??= ExcessMasterMappingSerilizer();
  @override
  Map<String, dynamic> toMap(ExcessMaster model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'accountsMasterId', model.accountsMasterId);
    setMapValue(
        ret,
        'excessMasterMappings',
        codeIterable(
            model.excessMasterMappings,
            (val) => _excessMasterMappingSerilizer
                .toMap(val as ExcessMasterMapping)));
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'isCustomerLabel', model.isCustomerLabel);
    setMapValue(ret, 'noOfLabel', model.noOfLabel);
    setMapValue(ret, 'notificationMasterId', model.notificationMasterId);
    setMapValue(ret, 'ordersMasterId', model.ordersMasterId);
    setMapValue(ret, 'partsMasterId', model.partsMasterId);
    setMapValue(ret, 'quantity', model.quantity);
    setMapValue(ret, 'siteMasterId', model.siteMasterId);
    setMapValue(ret, 'userId', model.userId);
    setMapValue(ret, 'warehouseInboundId', model.warehouseInboundId);
    return ret;
  }

  @override
  ExcessMaster fromMap(Map map) {
    if (map == null) return null;
    final obj = ExcessMaster();
    obj.accountsMasterId = map['accountsMasterId'] as String;
    obj.excessMasterMappings = codeIterable<ExcessMasterMapping>(
        map['excessMasterMappings'] as Iterable,
        (val) => _excessMasterMappingSerilizer.fromMap(val as Map));
    obj.id = map['id'] as String;
    obj.isCustomerLabel = map['isCustomerLabel'] as String;
    obj.noOfLabel = map['noOfLabel'] as int;
    obj.notificationMasterId = map['notificationMasterId'] as String;
    obj.ordersMasterId = map['ordersMasterId'] as String;
    obj.partsMasterId = map['partsMasterId'] as String;
    obj.quantity = map['quantity'] as int;
    obj.siteMasterId = map['siteMasterId'] as String;
    obj.userId = map['userId'] as String;
    obj.warehouseInboundId = map['warehouseInboundId'] as String;
    return obj;
  }
}
