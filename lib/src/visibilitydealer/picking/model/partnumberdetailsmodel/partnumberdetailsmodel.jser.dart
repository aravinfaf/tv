// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partnumberdetailsmodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$PartNumberDetailsModelSerializer
    implements Serializer<PartNumberDetailsModel> {
  @override
  Map<String, dynamic> toMap(PartNumberDetailsModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'id', model.mId);
    setMapValue(ret, 'partNumber', model.mPartNumber);
    setMapValue(ret, 'partTypesMasterIdName', model.mPartTypeMaster);
    return ret;
  }

  @override
  PartNumberDetailsModel fromMap(Map map) {
    if (map == null) return null;
    final obj = PartNumberDetailsModel();
    obj.mId = map['id'] as String;
    obj.mPartNumber = map['partNumber'] as String;
    obj.mPartTypeMaster = map['partTypesMasterIdName'] as String;
    return obj;
  }
}
