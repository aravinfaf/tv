// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'endcustomerdetailmodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$EndCustomerDetailModelSerializer
    implements Serializer<EndCustomerDetailModel> {
  @override
  Map<String, dynamic> toMap(EndCustomerDetailModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'id', model.mId);
    return ret;
  }

  @override
  EndCustomerDetailModel fromMap(Map map) {
    if (map == null) return null;
    final obj = EndCustomerDetailModel();
    obj.mId = map['id'] as String;
    return obj;
  }
}
