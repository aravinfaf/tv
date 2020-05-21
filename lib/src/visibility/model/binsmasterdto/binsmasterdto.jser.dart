// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'binsmasterdto.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$BinsMasterDTOSerializer implements Serializer<BinsMasterDTO> {
  @override
  Map<String, dynamic> toMap(BinsMasterDTO model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'accountMasterId', model.mAccountMasterId);
    setMapValue(ret, 'accountMasterName', model.mAccountMasterName);
    setMapValue(ret, 'binHeight', model.mBinHeight);
    setMapValue(ret, 'binLabel', model.mBinLabel);
    setMapValue(ret, 'binLength', model.mBinLength);
    setMapValue(ret, 'binLocation', model.mBinLocation);
    setMapValue(ret, 'binTypesMasterId', model.mBinTypesMasterId);
    setMapValue(ret, 'binTypesMasterName', model.mBinTypesMasterName);
    setMapValue(ret, 'binWidth', model.mBinWidth);
    setMapValue(ret, 'capacity', model.mCapacity);
    setMapValue(ret, 'id', model.mId);
    setMapValue(ret, 'siteMasterId', model.mSiteMasterId);
    setMapValue(ret, 'siteMasterName', model.mSiteMasterName);
    return ret;
  }

  @override
  BinsMasterDTO fromMap(Map map) {
    if (map == null) return null;
    final obj = BinsMasterDTO();
    obj.mAccountMasterId = map['accountMasterId'] as String;
    obj.mAccountMasterName = map['accountMasterName'] as String;
    obj.mBinHeight = map['binHeight'] as int;
    obj.mBinLabel = map['binLabel'] as String;
    obj.mBinLength = map['binLength'] as int;
    obj.mBinLocation = map['binLocation'] as String;
    obj.mBinTypesMasterId = map['binTypesMasterId'] as String;
    obj.mBinTypesMasterName = map['binTypesMasterName'] as String;
    obj.mBinWidth = map['binWidth'] as int;
    obj.mCapacity = map['capacity'] as int;
    obj.mId = map['id'] as String;
    obj.mSiteMasterId = map['siteMasterId'] as String;
    obj.mSiteMasterName = map['siteMasterName'] as String;
    return obj;
  }
}
