// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activetaskresponsemodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$ActiveTaskConsolidationModelSerializer
    implements Serializer<ActiveTaskConsolidationModel> {
  @override
  Map<String, dynamic> toMap(ActiveTaskConsolidationModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'businessKey', model.mBusinessKey);
    setMapValue(ret, 'orderReference', model.mOrderReference);
    setMapValue(ret, 'processDefenitionId', model.mProcessDefenitionId);
    setMapValue(ret, 'processInstanceId', model.mProcessInstanceId);
    setMapValue(ret, 'taskInstanceId', model.mTaskInstanceId);
    setMapValue(ret, 'taskdefenitionId', model.mTaskdefenitionId);
    return ret;
  }

  @override
  ActiveTaskConsolidationModel fromMap(Map map) {
    if (map == null) return null;
    final obj = ActiveTaskConsolidationModel(
        getJserDefault('mBusinessKey'),
        getJserDefault('mOrderReference'),
        getJserDefault('mProcessDefenitionId'),
        getJserDefault('mProcessInstanceId'),
        getJserDefault('mTaskInstanceId'),
        getJserDefault('mTaskdefenitionId'));
    obj.mBusinessKey = map['businessKey'] as String;
    obj.mOrderReference = map['orderReference'] as String;
    obj.mProcessDefenitionId = map['processDefenitionId'] as String;
    obj.mProcessInstanceId = map['processInstanceId'] as String;
    obj.mTaskInstanceId = map['taskInstanceId'] as String;
    obj.mTaskdefenitionId = map['taskdefenitionId'] as String;
    return obj;
  }
}
