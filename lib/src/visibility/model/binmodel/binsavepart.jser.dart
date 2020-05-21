// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'binsavepart.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$BinSavePartSerializer implements Serializer<BinSavePart> {
  @override
  Map<String, dynamic> toMap(BinSavePart model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'accountsMasterId', model.mAccountsMasterId);
    setMapValue(ret, 'binMasterId', model.mBinMasterId);
    setMapValue(ret, 'binsMasterId', model.mBinsMasterId);
    setMapValue(ret, 'binTypeId', model.mBinTypeId);
    setMapValue(ret, 'damagedQty', model.mDamagedQty);
    setMapValue(ret, 'isFirstScan', model.mFirstScan);
    setMapValue(ret, 'isGoodBin', model.mGoodBin);
    setMapValue(ret, 'ordersMasterId', model.mOrdersMasterId);
    setMapValue(ret, 'partsInOrderId', model.mPartsInOrderId);
    setMapValue(ret, 'partsMasterId', model.mPartsMasterId);
    setMapValue(ret, 'scanNumber', model.mScanNumber);
    setMapValue(ret, 'shortReceived', model.mShortReceived);
    setMapValue(ret, 'siteMasterId', model.mSiteMasterId);
    setMapValue(ret, 'taskInstanceId', model.mTaskInstanceId);
    setMapValue(ret, 'vPartQuantity', model.mVPartQuantity);
    setMapValue(ret, 'vTypeQuantity', model.mVTypeQuantity);
    setMapValue(ret, 'vpartsExistQty', model.mVPartsExistQty);
    setMapValue(ret, 'warehouseMatInboundId', model.mWarehouseMatInboundId);
    setMapValue(ret, 'binnedDate', model.mBinnedDate);
    setMapValue(
        ret, 'clientExcessOrShortStatus', model.mClientExcessOrShortStatus);
    setMapValue(ret, 'requestorUserId', model.mRequestorUserId);
    setMapValue(ret, 'userId', model.mUserId);
    setMapValue(ret, 'tenantId', model.mTenantId);
    setMapValue(ret, 'siteId', model.mSiteId);
    return ret;
  }

  @override
  BinSavePart fromMap(Map map) {
    if (map == null) return null;
    final obj = BinSavePart();
    obj.mAccountsMasterId = map['accountsMasterId'] as String;
    obj.mBinMasterId = map['binMasterId'] as String;
    obj.mBinsMasterId = map['binsMasterId'] as String;
    obj.mBinTypeId = map['binTypeId'] as int;
    obj.mDamagedQty = map['damagedQty'] as int;
    obj.mFirstScan = map['isFirstScan'] as bool;
    obj.mGoodBin = map['isGoodBin'] as bool;
    obj.mOrdersMasterId = map['ordersMasterId'] as String;
    obj.mPartsInOrderId = map['partsInOrderId'] as String;
    obj.mPartsMasterId = map['partsMasterId'] as String;
    obj.mScanNumber = map['scanNumber'] as String;
    obj.mShortReceived = map['shortReceived'] as int;
    obj.mSiteMasterId = map['siteMasterId'] as String;
    obj.mTaskInstanceId = map['taskInstanceId'] as String;
    obj.mVPartQuantity = map['vPartQuantity'] as String;
    obj.mVTypeQuantity = map['vTypeQuantity'] as int;
    obj.mVPartsExistQty = map['vpartsExistQty'] as int;
    obj.mWarehouseMatInboundId = map['warehouseMatInboundId'] as String;
    obj.mBinnedDate = map['binnedDate'] as String;
    obj.mClientExcessOrShortStatus = map['clientExcessOrShortStatus'] as int;
    obj.mRequestorUserId = map['requestorUserId'] as String;
    obj.mUserId = map['userId'] as String;
    obj.mTenantId = map['tenantId'] as String;
    obj.mSiteId = map['siteId'] as String;
    return obj;
  }
}
