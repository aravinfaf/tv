// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partorbinvalidationmodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$PartOrBinValidationModelSerializer
    implements Serializer<PartOrBinValidationModel> {
  @override
  Map<String, dynamic> toMap(PartOrBinValidationModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'binLocation', model.mBinLocation);
    setMapValue(ret, 'binLabel', model.mBinLabel);
    setMapValue(ret, 'binId', model.mBinId);
    setMapValue(ret, 'partMasterId', model.mPartMasterId);
    setMapValue(ret, 'partTypeCode', model.mPartTypeCode);
    setMapValue(ret, 'serialNum', model.mSerialNum);
    setMapValue(ret, 'remainingQty', model.mRemainingQty);
    setMapValue(ret, 'partsinOrderId', model.mPartsInOrderId);
    setMapValue(ret, 'scanText', model.mScanText);
    setMapValue(ret, 'siteMasterId', model.mSiteMasterId);
    setMapValue(ret, 'orderId', model.mOrderId);
    setMapValue(ret, 'partNumber', model.mPartNumber);
    return ret;
  }

  @override
  PartOrBinValidationModel fromMap(Map map) {
    if (map == null) return null;
    final obj = PartOrBinValidationModel();
    obj.mBinLocation = map['binLocation'] as String;
    obj.mBinLabel = map['binLabel'] as String;
    obj.mBinId = map['binId'] as String;
    obj.mPartMasterId = map['partMasterId'] as String;
    obj.mPartTypeCode = map['partTypeCode'] as String;
    obj.mSerialNum = map['serialNum'] as String;
    obj.mRemainingQty = map['remainingQty'] as int;
    obj.mPartsInOrderId = map['partsinOrderId'] as String;
    obj.mScanText = map['scanText'] as String;
    obj.mSiteMasterId = map['siteMasterId'] as String;
    obj.mOrderId = map['orderId'] as String;
    obj.mPartNumber = map['partNumber'] as String;
    return obj;
  }
}
