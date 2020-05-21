// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkpodbybusinesskeymodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$CheckPODByBusinessKeyModelSerializer
    implements Serializer<CheckPODByBusinessKeyModel> {
  @override
  Map<String, dynamic> toMap(CheckPODByBusinessKeyModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'taskdefenitionId', model.mTaskDefinitionId);
    return ret;
  }

  @override
  CheckPODByBusinessKeyModel fromMap(Map map) {
    if (map == null) return null;
    final obj = CheckPODByBusinessKeyModel();
    obj.mTaskDefinitionId = map['taskdefenitionId'] as String;
    return obj;
  }
}
