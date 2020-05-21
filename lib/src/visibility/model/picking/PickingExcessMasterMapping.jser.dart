// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PickingExcessMasterMapping.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$ExcessMasterMappingSerilizer
    implements Serializer<ExcessMasterMapping> {
  @override
  Map<String, dynamic> toMap(ExcessMasterMapping model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'excessMasterId', model.excessMasterId);
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'serialNumber', model.serialNumber);
    return ret;
  }

  @override
  ExcessMasterMapping fromMap(Map map) {
    if (map == null) return null;
    final obj = ExcessMasterMapping();
    obj.excessMasterId = map['excessMasterId'] as String;
    obj.id = map['id'] as String;
    obj.serialNumber = map['serialNumber'] as String;
    return obj;
  }
}
