// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'binmasterdetailsmodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$BinMasterDetailsModelSerializer
    implements Serializer<BinMasterDetailsModel> {
  @override
  Map<String, dynamic> toMap(BinMasterDetailsModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'binId', model.mBinId);
    setMapValue(ret, 'binLabel', model.mBinLabel);
    setMapValue(ret, 'binLocation', model.mBinLocation);
    setMapValue(ret, 'partMasterId', model.mPartMasterId);
    setMapValue(ret, 'serialNum', model.mSerialNum);
    setMapValue(ret, 'siteMasterId', model.mSiteMasterId);
    setMapValue(ret, 'statusMasterId', model.mStatusMasterId);
    setMapValue(ret, 'wareHouseMatInboundId', model.mWareHouseMatInboundId);
    return ret;
  }

  @override
  BinMasterDetailsModel fromMap(Map map) {
    if (map == null) return null;
    final obj = BinMasterDetailsModel();
    obj.mBinId = map['binId'] as String;
    obj.mBinLabel = map['binLabel'] as String;
    obj.mBinLocation = map['binLocation'] as String;
    obj.mPartMasterId = map['partMasterId'] as String;
    obj.mSerialNum = map['serialNum'] as String;
    obj.mSiteMasterId = map['siteMasterId'] as String;
    obj.mStatusMasterId = map['statusMasterId'] as int;
    obj.mWareHouseMatInboundId = map['wareHouseMatInboundId'] as String;
    return obj;
  }
}
