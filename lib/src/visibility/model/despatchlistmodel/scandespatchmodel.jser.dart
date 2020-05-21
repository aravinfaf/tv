// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scandespatchmodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$ScanDespatchModelSerializer
    implements Serializer<ScanDespatchModel> {
  @override
  Map<String, dynamic> toMap(ScanDespatchModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'id', model.mId);
    setMapValue(ret, 'mappingId', model.mMappingId);
    setMapValue(ret, 'actorType', model.mActorType);
    setMapValue(ret, 'deliveryTo', model.mDeliveryTo);
    setMapValue(ret, 'address', model.mAddress);
    setMapValue(ret, 'company', model.mCompany);
    setMapValue(ret, 'deliveryTypesMasterId', model.mDeliveryTypesMasterId);
    setMapValue(ret, 'consolidationId', model.mConsolidationId);
    setMapValue(ret, 'modeOfTransport', model.mModeOfTransport);
    setMapValue(ret, 'vehicleNum', model.mVehicleNum);
    setMapValue(ret, 'courierName', model.mCourierName);
    setMapValue(ret, 'orderId', model.mOrderId);
    setMapValue(ret, 'consolidationTypeId', model.mConsolidationTypeId);
    setMapValue(ret, 'orderIdList',
        codeIterable(model.mOrderIdList, (val) => val as String));
    setMapValue(ret, 'scanNumber', model.mScanNumber);
    setMapValue(ret, 'userId', model.mUserId);
    return ret;
  }

  @override
  ScanDespatchModel fromMap(Map map) {
    if (map == null) return null;
    final obj = ScanDespatchModel();
    obj.mId = map['id'] as String;
    obj.mMappingId = map['mappingId'] as String;
    obj.mActorType = map['actorType'] as String;
    obj.mDeliveryTo = map['deliveryTo'] as String;
    obj.mAddress = map['address'] as String;
    obj.mCompany = map['company'] as String;
    obj.mDeliveryTypesMasterId = map['deliveryTypesMasterId'] as String;
    obj.mConsolidationId = map['consolidationId'] as String;
    obj.mModeOfTransport = map['modeOfTransport'] as String;
    obj.mVehicleNum = map['vehicleNum'] as String;
    obj.mCourierName = map['courierName'] as String;
    obj.mOrderId = map['orderId'] as String;
    obj.mConsolidationTypeId = map['consolidationTypeId'] as int;
    obj.mOrderIdList = codeIterable<String>(
        map['orderIdList'] as Iterable, (val) => val as String);
    obj.mScanNumber = map['scanNumber'] as String;
    obj.mUserId = map['userId'] as String;
    return obj;
  }
}
