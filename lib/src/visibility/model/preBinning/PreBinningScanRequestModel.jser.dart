// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PreBinningScanRequestModel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$PreBinningScanRequestModelSerializer
    implements Serializer<PreBinningScanRequestModel> {
  @override
  Map<String, dynamic> toMap(PreBinningScanRequestModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'userId', model.userId);
    setMapValue(ret, 'statusCodeMasterId', model.statusCodeMasterId);
    setMapValue(ret, 'serialNo', model.serialNo);
    setMapValue(ret, 'matinbound', model.matinbound);
    setMapValue(ret, 'siteId', model.siteId);
    setMapValue(ret, 'taskKey', model.taskKey);
    return ret;
  }

  @override
  PreBinningScanRequestModel fromMap(Map map) {
    if (map == null) return null;
    final obj = PreBinningScanRequestModel();
    obj.userId = map['userId'] as String;
    obj.statusCodeMasterId = map['statusCodeMasterId'] as String;
    obj.serialNo = map['serialNo'] as String;
    obj.matinbound = map['matinbound'] as String;
    obj.siteId = map['siteId'] as String;
    obj.taskKey = map['taskKey'] as String;
    return obj;
  }
}
