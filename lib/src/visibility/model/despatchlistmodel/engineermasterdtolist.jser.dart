// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'engineermasterdtolist.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$EngineerMasterDetailsModelSerializer
    implements Serializer<EngineerMasterDetailsModel> {
  @override
  Map<String, dynamic> toMap(EngineerMasterDetailsModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'id', model.id);
    return ret;
  }

  @override
  EngineerMasterDetailsModel fromMap(Map map) {
    if (map == null) return null;
    final obj = EngineerMasterDetailsModel();
    obj.id = map['id'] as String;
    return obj;
  }
}
