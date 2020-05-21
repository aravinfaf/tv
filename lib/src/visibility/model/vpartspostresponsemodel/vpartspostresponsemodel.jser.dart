// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vpartspostresponsemodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$VPartsPostResponseModelSerializer
    implements Serializer<VPartsPostResponseModel> {
  @override
  Map<String, dynamic> toMap(VPartsPostResponseModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'statusCode', model.mStatusCode);
    setMapValue(ret, 'binnedQuantity', model.mBinnedQuantity);
    setMapValue(ret, 'totalQuantity', model.mTotalQuantity);
    return ret;
  }

  @override
  VPartsPostResponseModel fromMap(Map map) {
    if (map == null) return null;
    final obj = VPartsPostResponseModel();
    obj.mStatusCode = map['statusCode'] as int;
    obj.mBinnedQuantity = map['binnedQuantity'] as int;
    obj.mTotalQuantity = map['totalQuantity'] as int;
    return obj;
  }
}
