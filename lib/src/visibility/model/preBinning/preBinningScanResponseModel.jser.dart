// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preBinningScanResponseModel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$PreBinningScanResponseModelSerializer
    implements Serializer<PreBinningScanResponseModel> {
  @override
  Map<String, dynamic> toMap(PreBinningScanResponseModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'code', model.code);
    return ret;
  }

  @override
  PreBinningScanResponseModel fromMap(Map map) {
    if (map == null) return null;
    final obj = PreBinningScanResponseModel();
    obj.code = map['code'] as String;
    return obj;
  }
}
