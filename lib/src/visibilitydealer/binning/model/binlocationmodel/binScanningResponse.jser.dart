// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'binScanningResponse.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$BinScanningResponseSerializer
    implements Serializer<BinScanningResponse> {
  @override
  Map<String, dynamic> toMap(BinScanningResponse model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'binLocation', model.mBinLocation);
    setMapValue(ret, 'binLabel', model.mBinLabel);
    setMapValue(ret, 'binId', model.mBinId);
    setMapValue(ret, 'orderId', model.mOrderId);
    setMapValue(ret, 'partsinOrderId', model.mPartsInOrderId);
    setMapValue(ret, 'partMasterId', model.mPartMasterId);
    setMapValue(ret, 'partTypeCode', model.mPartTypeCode);
    setMapValue(ret, 'serialNum', model.mSerialNum);
    setMapValue(ret, 'wareHouseMatInboundId', model.mWareHouseMatInboundId);
    setMapValue(ret, 'remainingQty', model.mRemainingQty);
    setMapValue(ret, 'customerLabel', model.mCustomerLabel);
    setMapValue(ret, 'message', model.mMessage);
    setMapValue(ret, 'customerRef', model.mCustomerRef);
    setMapValue(ret, 'partNumber', model.mPartNumber);
    setMapValue(ret, 'binnedQty', model.mBinnedQty);
    setMapValue(ret, 'partsTotalQty', model.mPartsTotalQty);
    setMapValue(ret, 'binStatus', model.mBinStatus);
    return ret;
  }

  @override
  BinScanningResponse fromMap(Map map) {
    if (map == null) return null;
    final obj = BinScanningResponse();
    obj.mBinLocation = map['binLocation'] as String;
    obj.mBinLabel = map['binLabel'] as String;
    obj.mBinId = map['binId'] as String;
    obj.mOrderId = map['orderId'] as String;
    obj.mPartsInOrderId = map['partsinOrderId'] as String;
    obj.mPartMasterId = map['partMasterId'] as String;
    obj.mPartTypeCode = map['partTypeCode'] as String;
    obj.mSerialNum = map['serialNum'] as String;
    obj.mWareHouseMatInboundId = map['wareHouseMatInboundId'] as String;
    obj.mRemainingQty = map['remainingQty'] as int;
    obj.mCustomerLabel = map['customerLabel'] as bool;
    obj.mMessage = map['message'] as String;
    obj.mCustomerRef = map['customerRef'] as String;
    obj.mPartNumber = map['partNumber'] as String;
    obj.mBinnedQty = map['binnedQty'] as int;
    obj.mPartsTotalQty = map['partsTotalQty'] as int;
    obj.mBinStatus = map['binStatus'] as int;
    return obj;
  }
}
