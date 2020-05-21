// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bininfodetailsmodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$BinInfoDetailsModelSerializer
    implements Serializer<BinInfoDetailsModel> {
  @override
  Map<String, dynamic> toMap(BinInfoDetailsModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'binMasterLabel', model.mBinMasterLabel);
    setMapValue(ret, 'lpnNo', model.mLPNNo);
    setMapValue(ret, 'quantity', model.mQuantity);
    setMapValue(ret, 'statusCodeId', model.mStatus);
    return ret;
  }

  @override
  BinInfoDetailsModel fromMap(Map map) {
    if (map == null) return null;
    final obj = BinInfoDetailsModel();
    obj.mBinMasterLabel = map['binMasterLabel'] as String;
    obj.mLPNNo = map['lpnNo'] as String;
    obj.mQuantity = map['quantity'] as int;
    obj.mStatus = map['statusCodeId'] as String;
    return obj;
  }
}
