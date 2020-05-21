// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkpodkeymodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$CheckPodKeySerializer implements Serializer<CheckPodKeyModel> {
  @override
  Map<String, dynamic> toMap(CheckPodKeyModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'businessKey', model.businessKey);
    setMapValue(ret, 'orderReference', model.orderReference);
    setMapValue(ret, 'processDefenitionId', model.processDefenitionId);
    setMapValue(ret, 'processInstanceId', model.processInstanceId);
    setMapValue(ret, 'taskInstanceId', model.taskInstanceId);
    setMapValue(ret, 'taskdefenitionId', model.taskdefenitionId);
    return ret;
  }

  @override
  CheckPodKeyModel fromMap(Map map) {
    if (map == null) return null;
    final obj = CheckPodKeyModel();
    obj.businessKey = map['businessKey'] as String;
    obj.orderReference = map['orderReference'] as String;
    obj.processDefenitionId = map['processDefenitionId'] as String;
    obj.processInstanceId = map['processInstanceId'] as String;
    obj.taskInstanceId = map['taskInstanceId'] as String;
    obj.taskdefenitionId = map['taskdefenitionId'] as String;
    return obj;
  }
}
