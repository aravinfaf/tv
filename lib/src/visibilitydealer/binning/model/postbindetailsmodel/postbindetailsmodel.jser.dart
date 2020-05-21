// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postbindetailsmodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$PostBinDetailsModelSerializer
    implements Serializer<PostBinDetailsModel> {
  @override
  Map<String, dynamic> toMap(PostBinDetailsModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'scanText', model.scanText);
    setMapValue(ret, 'binLabel', model.binLabel);
    setMapValue(ret, 'partSerialNo', model.partSerialNo);
    setMapValue(ret, 'quantity', model.quantity);
    setMapValue(ret, 'orderId', model.orderId);
    setMapValue(ret, 'binStatus', model.binStatus);
    setMapValue(ret, 'remainingQty', model.remainingQty);
    setMapValue(ret, 'proceedExcessOrShort', model.proceedExcessOrShort);
    setMapValue(ret, 'siteMasterId', model.mSiteMasterId);
    setMapValue(ret, 'partsinOrderId', model.mPartsInOrderId);
    return ret;
  }

  @override
  PostBinDetailsModel fromMap(Map map) {
    if (map == null) return null;
    final obj = PostBinDetailsModel();
    obj.scanText = map['scanText'] as String;
    obj.binLabel = map['binLabel'] as String;
    obj.partSerialNo = map['partSerialNo'] as String;
    obj.quantity = map['quantity'] as int;
    obj.orderId = map['orderId'] as String;
    obj.binStatus = map['binStatus'] as int;
    obj.remainingQty = map['remainingQty'] as int;
    obj.proceedExcessOrShort = map['proceedExcessOrShort'] as int;
    obj.mSiteMasterId = map['siteMasterId'] as String;
    obj.mPartsInOrderId = map['partsinOrderId'] as String;
    return obj;
  }
}
