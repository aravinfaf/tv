// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'binninglistmodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$BinningListModelSerializer
    implements Serializer<BinningListModel> {
  @override
  Map<String, dynamic> toMap(BinningListModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'partType', model.mPartType);
    setMapValue(ret, 'actorTypeId', model.mActorTypeId);
    setMapValue(ret, 'quantity', model.mQuantity);
    setMapValue(ret, 'balanceToBin', model.mBalanceToBin);
    setMapValue(ret, 'invoiceNumber', model.mInvoiceNumber);
    setMapValue(ret, 'isLabelGen', model.mLabelGen);
    setMapValue(ret, 'accountsMasterId', model.mAccountsMasterId);
    setMapValue(ret, 'orderMasterId', model.mOrderMasterId);
    setMapValue(ret, 'partsInOrderId', model.mPartsInOrderId);
    setMapValue(ret, 'partsMasterId', model.mPartsMasterId);
    setMapValue(ret, 'partNumber', model.mPartNumber);
    setMapValue(ret, 'stockTypeCode', model.mStockTypeCode);
    setMapValue(ret, 'orderCreatedDate', model.mOrderCreatedDate);
    setMapValue(ret, 'orderSerialNo', model.mOrderSerialNo);
    return ret;
  }

  @override
  BinningListModel fromMap(Map map) {
    if (map == null) return null;
    final obj = BinningListModel();
    obj.mPartType = map['partType'] as String;
    obj.mActorTypeId = map['actorTypeId'] as String;
    obj.mQuantity = map['quantity'] as int;
    obj.mBalanceToBin = map['balanceToBin'] as int;
    obj.mInvoiceNumber = map['invoiceNumber'] as String;
    obj.mLabelGen = map['isLabelGen'] as bool;
    obj.mAccountsMasterId = map['accountsMasterId'] as String;
    obj.mOrderMasterId = map['orderMasterId'] as String;
    obj.mPartsInOrderId = map['partsInOrderId'] as String;
    obj.mPartsMasterId = map['partsMasterId'] as String;
    obj.mPartNumber = map['partNumber'] as String;
    obj.mStockTypeCode = map['stockTypeCode'] as String;
    obj.mOrderCreatedDate = map['orderCreatedDate'] as String;
    obj.mOrderSerialNo = map['orderSerialNo'] as String;
    return obj;
  }
}
