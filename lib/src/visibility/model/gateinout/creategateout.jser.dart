// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creategateout.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$CreateGateOutModelSerilizer
    implements Serializer<CreateGateOutModel> {
  @override
  Map<String, dynamic> toMap(CreateGateOutModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'gateInNumber', model.gateInNumber);
    setMapValue(ret, 'gateOutTime', model.gateOutTime);
    return ret;
  }

  @override
  CreateGateOutModel fromMap(Map map) {
    if (map == null) return null;
    final obj = CreateGateOutModel();
    obj.gateInNumber = map['gateInNumber'] as String;
    obj.gateOutTime = map['gateOutTime'] as String;
    return obj;
  }
}
