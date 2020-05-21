// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'binningScanHQ.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$BinningScanHQSerializer implements Serializer<BinningScanHQ> {
  Serializer<BinsMasterDTO> __binsMasterDTOSerializer;
  Serializer<BinsMasterDTO> get _binsMasterDTOSerializer =>
      __binsMasterDTOSerializer ??= BinsMasterDTOSerializer();
  @override
  Map<String, dynamic> toMap(BinningScanHQ model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'binTypeId', model.mBinTypeId);
    setMapValue(ret, 'binsMasterDTO',
        _binsMasterDTOSerializer.toMap(model.mBinsMasterDTO));
    setMapValue(ret, 'binsMasterId', model.mBinsMasterId);
    setMapValue(ret, 'isQuantityReq', model.mQuantityReq);
    setMapValue(ret, 'isVpart', model.mVPart);
    setMapValue(ret, 'orderMasterId', model.mOrderMasterId);
    setMapValue(ret, 'partsConvertable', model.mPartsConvertable);
    setMapValue(ret, 'partsInOrderId', model.mPartsInOrderId);
    setMapValue(ret, 'partsMasterId', model.mPartsMasterId);
    setMapValue(ret, 'serialNumber', model.mSerialNumber);
    setMapValue(ret, 'siteMasterId', model.mSiteMasterId);
    setMapValue(ret, 'statusCode', model.mStatusCode);
    setMapValue(ret, 'stockTypeMasterId', model.mStockTypeMasterId);
    setMapValue(ret, 'vpartsExistQty', model.mVPartsExistQty);
    setMapValue(ret, 'taskInstanceId', model.mTaskInstanceId);
    setMapValue(ret, 'accountsMasterId', model.mAccountsMasterId);
    return ret;
  }

  @override
  BinningScanHQ fromMap(Map map) {
    if (map == null) return null;
    final obj = BinningScanHQ();
    obj.mBinTypeId = map['binTypeId'] as String;
    obj.mBinsMasterDTO =
        _binsMasterDTOSerializer.fromMap(map['binsMasterDTO'] as Map);
    obj.mBinsMasterId = map['binsMasterId'] as String;
    obj.mQuantityReq = map['isQuantityReq'] as bool;
    obj.mVPart = map['isVpart'] as bool;
    obj.mOrderMasterId = map['orderMasterId'] as String;
    obj.mPartsConvertable = map['partsConvertable'] as bool;
    obj.mPartsInOrderId = map['partsInOrderId'] as String;
    obj.mPartsMasterId = map['partsMasterId'] as String;
    obj.mSerialNumber = map['serialNumber'] as String;
    obj.mSiteMasterId = map['siteMasterId'] as String;
    obj.mStatusCode = map['statusCode'] as int;
    obj.mStockTypeMasterId = map['stockTypeMasterId'] as String;
    obj.mVPartsExistQty = map['vpartsExistQty'] as int;
    obj.mTaskInstanceId = map['taskInstanceId'] as String;
    obj.mAccountsMasterId = map['accountsMasterId'] as String;
    return obj;
  }
}
