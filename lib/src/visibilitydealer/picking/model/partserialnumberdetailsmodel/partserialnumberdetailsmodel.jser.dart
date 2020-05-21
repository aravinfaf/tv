// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partserialnumberdetailsmodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$PartSerialNumberDetailsModelSerializer
    implements Serializer<PartSerialNumberDetailsModel> {
  @override
  Map<String, dynamic> toMap(PartSerialNumberDetailsModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'binLabel', model.mBinLabel);
    setMapValue(ret, 'partMasterId', model.mPartMasterId);
    setMapValue(ret, 'partNumber', model.mPartNumber);
    setMapValue(ret, 'partSerialNo', model.mPartSerialNo);
    setMapValue(ret, 'partTypeCode', model.mPartTypeCode);
    setMapValue(ret, 'partTypeId', model.mPartTypeId);
    setMapValue(ret, 'pickQty', model.mPickQty);
    setMapValue(ret, 'pickStatus', model.mPickStatus);
    setMapValue(ret, 'randomPickStatus', model.mRandomPickStatus);
    setMapValue(ret, 'siteMasterId', model.mSiteMasterId);
    setMapValue(ret, 'serialNumber', model.mScanText);
    setMapValue(ret, 'quantity', model.mQuantity);
    return ret;
  }

  @override
  PartSerialNumberDetailsModel fromMap(Map map) {
    if (map == null) return null;
    final obj = PartSerialNumberDetailsModel();
    obj.mBinLabel = map['binLabel'] as String;
    obj.mPartMasterId = map['partMasterId'] as String;
    obj.mPartNumber = map['partNumber'] as String;
    obj.mPartSerialNo = map['partSerialNo'] as String;
    obj.mPartTypeCode = map['partTypeCode'] as String;
    obj.mPartTypeId = map['partTypeId'] as String;
    obj.mPickQty = map['pickQty'] as int;
    obj.mPickStatus = map['pickStatus'] as int;
    obj.mRandomPickStatus = map['randomPickStatus'] as int;
    obj.mSiteMasterId = map['siteMasterId'] as String;
    obj.mScanText = map['serialNumber'] as String;
    obj.mQuantity = map['quantity'] as int;
    return obj;
  }
}
