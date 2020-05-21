// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'binScanningRequest.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$BinScanningRequestSerializer
    implements Serializer<BinScanningRequest> {
  @override
  Map<String, dynamic> toMap(BinScanningRequest model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'binLabel', model.mBinLabel);
    setMapValue(ret, 'binStatus', model.mBinStatus);
    setMapValue(ret, 'binId', model.mBinId);
    setMapValue(ret, 'orderId', model.mOrderId);
    setMapValue(ret, 'partNumber', model.mPartNumber);
    setMapValue(ret, 'partSerialNo', model.mPartSerialNo);
    setMapValue(ret, 'partsinOrderId', model.mPartsInOrderId);
    setMapValue(ret, 'proceedExcessOrShort', model.mProceedExcessOrShort);
    setMapValue(ret, 'quantity', model.mQuantity);
    setMapValue(ret, 'remainingQty', model.mRemainingQty);
    setMapValue(ret, 'scanText', model.mScanText);
    setMapValue(ret, 'siteMasterId', model.mSiteMasterId);
    setMapValue(ret, 'wareHouseMatInboundId', model.mWareHouseMatInboundId);
    return ret;
  }

  @override
  BinScanningRequest fromMap(Map map) {
    if (map == null) return null;
    final obj = BinScanningRequest();
    obj.mBinLabel = map['binLabel'] as String;
    obj.mBinStatus = map['binStatus'] as int;
    obj.mBinId = map['binId'] as String;
    obj.mOrderId = map['orderId'] as String;
    obj.mPartNumber = map['partNumber'] as String;
    obj.mPartSerialNo = map['partSerialNo'] as String;
    obj.mPartsInOrderId = map['partsinOrderId'] as String;
    obj.mProceedExcessOrShort = map['proceedExcessOrShort'] as int;
    obj.mQuantity = map['quantity'] as int;
    obj.mRemainingQty = map['remainingQty'] as int;
    obj.mScanText = map['scanText'] as String;
    obj.mSiteMasterId = map['siteMasterId'] as String;
    obj.mWareHouseMatInboundId = map['wareHouseMatInboundId'] as String;
    return obj;
  }
}
