// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'binvalidationresult.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$BinValidationResultSerializer
    implements Serializer<BinValidationResult> {
  Serializer<BinsMasterDTO> __binsMasterDTOSerializer;
  Serializer<BinsMasterDTO> get _binsMasterDTOSerializer =>
      __binsMasterDTOSerializer ??= BinsMasterDTOSerializer();
  Serializer<PartsMasterDTO> __partsMasterDTOSerializer;
  Serializer<PartsMasterDTO> get _partsMasterDTOSerializer =>
      __partsMasterDTOSerializer ??= PartsMasterDTOSerializer();
  @override
  Map<String, dynamic> toMap(BinValidationResult model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'binTypeId', model.mBinTypeId);
    setMapValue(ret, 'binsMasterDTO',
        _binsMasterDTOSerializer.toMap(model.mBinsMasterDTO));
    setMapValue(ret, 'partsMasterDTO',
        _partsMasterDTOSerializer.toMap(model.mPartsMasterDTO));
    setMapValue(ret, 'serialNumber', model.mSerialNumber);
    setMapValue(ret, 'statusCode', model.mStatusCode);
    setMapValue(ret, 'vpartsExistQty', model.mVPartsExistQty);
    setMapValue(ret, 'wareHouseMatId', model.mWareHouseMatId);
    setMapValue(ret, 'partsInorderId', model.mPartsInorderId);
    setMapValue(ret, 'orderId', model.mOrderId);
    setMapValue(ret, 'partId', model.mPartId);
    setMapValue(ret, 'totalQuantity', model.mTotalQuantity);
    setMapValue(ret, 'customerReference', model.mCustomerReference);
    setMapValue(ret, 'partNumber', model.mPartNumber);
    setMapValue(ret, 'binnedQuantity', model.mBinnedQuantity);
    return ret;
  }

  @override
  BinValidationResult fromMap(Map map) {
    if (map == null) return null;
    final obj = BinValidationResult();
    obj.mBinTypeId = map['binTypeId'] as int;
    obj.mBinsMasterDTO =
        _binsMasterDTOSerializer.fromMap(map['binsMasterDTO'] as Map);
    obj.mPartsMasterDTO =
        _partsMasterDTOSerializer.fromMap(map['partsMasterDTO'] as Map);
    obj.mSerialNumber = map['serialNumber'] as String;
    obj.mStatusCode = map['statusCode'] as int;
    obj.mVPartsExistQty = map['vpartsExistQty'] as int;
    obj.mWareHouseMatId = map['wareHouseMatId'] as String;
    obj.mPartsInorderId = map['partsInorderId'] as String;
    obj.mOrderId = map['orderId'] as String;
    obj.mPartId = map['partId'] as String;
    obj.mTotalQuantity = map['totalQuantity'] as int;
    obj.mCustomerReference = map['customerReference'] as String;
    obj.mPartNumber = map['partNumber'] as String;
    obj.mBinnedQuantity = map['binnedQuantity'] as int;
    return obj;
  }
}
