// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PickingAlternateLocationResult.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$AlternateLocationResultSerializer
    implements Serializer<AlternateLocationResult> {
  @override
  Map<String, dynamic> toMap(AlternateLocationResult model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'status', model.status);
    setMapValue(ret, 'requestedQuantity', model.requestedQuantity);
    setMapValue(ret, 'availableQuantity', model.availableQuantity);
    setMapValue(ret, 'alternateLocation', model.alternateLocation);
    setMapValue(ret, 'currentBin', model.currentBin);
    setMapValue(ret, 'currentBinQuantity', model.currentBinQuantity);
    return ret;
  }

  @override
  AlternateLocationResult fromMap(Map map) {
    if (map == null) return null;
    final obj = AlternateLocationResult();
    obj.status = map['status'] as int;
    obj.requestedQuantity = map['requestedQuantity'] as int;
    obj.availableQuantity = map['availableQuantity'] as int;
    obj.alternateLocation = map['alternateLocation'] as String;
    obj.currentBin = map['currentBin'] as String;
    obj.currentBinQuantity = map['currentBinQuantity'] as int;
    return obj;
  }
}
