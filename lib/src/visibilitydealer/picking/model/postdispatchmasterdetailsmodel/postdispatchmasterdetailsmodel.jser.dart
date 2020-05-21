// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postdispatchmasterdetailsmodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$PostDispatchMasterDetailsModelSerializer
    implements Serializer<PostDispatchMasterDetailsModel> {
  @override
  Map<String, dynamic> toMap(PostDispatchMasterDetailsModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'binLabel', model.mBinLabel);
    setMapValue(ret, 'delivaryTypeMasterId', model.mDeliveryTypeMasterId);
    setMapValue(ret, 'despatchMobile', model.mDespatchMobile);
    setMapValue(ret, 'despatchName', model.mDespatchName);
    setMapValue(ret, 'orderId', model.mOrderId);
    setMapValue(ret, 'partMasterId', model.mPartMasterId);
    setMapValue(ret, 'partSerialNo', model.mPartSerialNo);
    setMapValue(ret, 'partNumber', model.mPartNumber);
    setMapValue(ret, 'pickQty', model.mPickQty);
    setMapValue(ret, 'siteMasterId', model.mSiteMasterId);
    return ret;
  }

  @override
  PostDispatchMasterDetailsModel fromMap(Map map) {
    if (map == null) return null;
    final obj = PostDispatchMasterDetailsModel();
    obj.mBinLabel = map['binLabel'] as String;
    obj.mDeliveryTypeMasterId = map['delivaryTypeMasterId'] as String;
    obj.mDespatchMobile = map['despatchMobile'] as String;
    obj.mDespatchName = map['despatchName'] as String;
    obj.mOrderId = map['orderId'] as String;
    obj.mPartMasterId = map['partMasterId'] as String;
    obj.mPartSerialNo = map['partSerialNo'] as String;
    obj.mPartNumber = map['partNumber'] as String;
    obj.mPickQty = map['pickQty'] as int;
    obj.mSiteMasterId = map['siteMasterId'] as String;
    return obj;
  }
}
