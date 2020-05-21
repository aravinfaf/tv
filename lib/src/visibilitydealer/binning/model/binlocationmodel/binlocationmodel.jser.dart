// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'binlocationmodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$BinLocationModelSerializer
    implements Serializer<BinLocationModel> {
  @override
  Map<String, dynamic> toMap(BinLocationModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'id', model.mId);
    setMapValue(ret, 'binLabel', model.mBinLabel);
    setMapValue(ret, 'binLocation', model.mBinLocation);
    setMapValue(ret, 'scanStatus', model.mAllowPicking);
    return ret;
  }

  @override
  BinLocationModel fromMap(Map map) {
    if (map == null) return null;
    final obj = BinLocationModel();
    obj.mId = map['id'] as String;
    obj.mBinLabel = map['binLabel'] as String;
    obj.mBinLocation = map['binLocation'] as String;
    obj.mAllowPicking = map['scanStatus'] as String;
    return obj;
  }
}
