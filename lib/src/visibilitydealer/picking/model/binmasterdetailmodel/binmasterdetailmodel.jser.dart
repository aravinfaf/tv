// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'binmasterdetailmodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$BinMasterDetailModelSerializer
    implements Serializer<BinMasterDetailModel> {
  @override
  Map<String, dynamic> toMap(BinMasterDetailModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'binLable', model.mBinLabel);
    setMapValue(ret, 'binLocation', model.mBinLocation);
    setMapValue(ret, 'quantity', model.mQuantity);
    return ret;
  }

  @override
  BinMasterDetailModel fromMap(Map map) {
    if (map == null) return null;
    final obj = BinMasterDetailModel();
    obj.mBinLabel = map['binLable'] as String;
    obj.mBinLocation = map['binLocation'] as String;
    obj.mQuantity = map['quantity'] as int;
    return obj;
  }
}
