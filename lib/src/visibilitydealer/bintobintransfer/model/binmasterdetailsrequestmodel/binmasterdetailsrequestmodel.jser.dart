// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'binmasterdetailsrequestmodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$BinMasterDetailsRequestModelSerializer
    implements Serializer<BinMasterDetailsRequestModel> {
  @override
  Map<String, dynamic> toMap(BinMasterDetailsRequestModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'scanText', model.mScanText);
    setMapValue(ret, 'binsMasterId', model.mBinsMasterId);
    setMapValue(ret, 'siteMasterId', model.mSiteMasterId);
    return ret;
  }

  @override
  BinMasterDetailsRequestModel fromMap(Map map) {
    if (map == null) return null;
    final obj = BinMasterDetailsRequestModel();
    obj.mScanText = map['scanText'] as String;
    obj.mBinsMasterId = map['binsMasterId'] as String;
    obj.mSiteMasterId = map['siteMasterId'] as String;
    return obj;
  }
}
