// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ordermastermodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$OrderMasterModelSerializer
    implements Serializer<OrderMasterModel> {
  @override
  Map<String, dynamic> toMap(OrderMasterModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'id', model.mId);
    setMapValue(ret, 'customerReference', model.mCustomerRef);
    setMapValue(ret, 'totalPartQuantity', model.mTotalOrderQuantity);
    setMapValue(ret, 'totalBinnedQuantity', model.mTotalBinnedQuantity);
    setMapValue(ret, 'partNumber', model.mPartNumber);
    setMapValue(ret, 'partsInOrderId', model.mPartsInOrderId);
    setMapValue(ret, 'partTypeCode', model.mPartTypeCode);
    return ret;
  }

  @override
  OrderMasterModel fromMap(Map map) {
    if (map == null) return null;
    final obj = OrderMasterModel();
    obj.mId = map['id'] as String;
    obj.mCustomerRef = map['customerReference'] as String;
    obj.mTotalOrderQuantity = map['totalPartQuantity'] as int;
    obj.mTotalBinnedQuantity = map['totalBinnedQuantity'] as int;
    obj.mPartNumber = map['partNumber'] as String;
    obj.mPartsInOrderId = map['partsInOrderId'] as String;
    obj.mPartTypeCode = map['partTypeCode'] as String;
    return obj;
  }
}
