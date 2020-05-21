// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getmodeoftransportmodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$GetModeOfTransportModelSerializer
    implements Serializer<GetModeOfTransportModel> {
  @override
  Map<String, dynamic> toMap(GetModeOfTransportModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'id', model.mId);
    setMapValue(ret, 'modeDesc', model.mModeDescription);
    return ret;
  }

  @override
  GetModeOfTransportModel fromMap(Map map) {
    if (map == null) return null;
    final obj = GetModeOfTransportModel();
    obj.mId = map['id'] as String;
    obj.mModeDescription = map['modeDesc'] as String;
    return obj;
  }
}
