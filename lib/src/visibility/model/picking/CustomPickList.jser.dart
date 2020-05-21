// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CustomPickList.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$CustomPickListSerilizer implements Serializer<CustomPickList> {
  Serializer<PickLocationDTOList> __pickLocationDTOListSerilizer;
  Serializer<PickLocationDTOList> get _pickLocationDTOListSerilizer =>
      __pickLocationDTOListSerilizer ??= PickLocationDTOListSerilizer();
  @override
  Map<String, dynamic> toMap(CustomPickList model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'column', model.column);
    setMapValue(ret, 'pageNumber', model.pageNumber);
    setMapValue(ret, 'pageSize', model.pageSize);
    setMapValue(ret, 'search', model.search);
    setMapValue(ret, 'siteId', model.siteId);
    setMapValue(ret, 'totalElements', model.totalElements);
    setMapValue(ret, 'totalPages', model.totalPages);
    setMapValue(ret, 'userId', model.userId);
    setMapValue(
        ret,
        'pickLocationDTOList',
        codeIterable(
            model.pickLocationDTOList,
            (val) => _pickLocationDTOListSerilizer
                .toMap(val as PickLocationDTOList)));
    return ret;
  }

  @override
  CustomPickList fromMap(Map map) {
    if (map == null) return null;
    final obj = CustomPickList();
    obj.column = map['column'] as String;
    obj.pageNumber = map['pageNumber'] as int;
    obj.pageSize = map['pageSize'] as int;
    obj.search = map['search'] as String;
    obj.siteId = map['siteId'] as String;
    obj.totalElements = map['totalElements'] as int;
    obj.totalPages = map['totalPages'] as int;
    obj.userId = map['userId'] as String;
    obj.pickLocationDTOList = codeIterable<PickLocationDTOList>(
        map['pickLocationDTOList'] as Iterable,
        (val) => _pickLocationDTOListSerilizer.fromMap(val as Map));
    return obj;
  }
}

abstract class _$PickLocationDTOListSerilizer
    implements Serializer<PickLocationDTOList> {
  @override
  Map<String, dynamic> toMap(PickLocationDTOList model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'accountId', model.accountId);
    setMapValue(ret, 'currentBin', model.currentBin);
    setMapValue(ret, 'currentBinQuantity', model.currentBinQuantity);
    setMapValue(ret, 'orderId', model.orderId);
    setMapValue(ret, 'packedQuantity', model.packedQuantity);
    setMapValue(ret, 'partMasterId', model.partMasterId);
    setMapValue(ret, 'partNumber', model.partNumber);
    setMapValue(ret, 'partsInOrderId', model.partsInOrderId);
    setMapValue(ret, 'pickCreatedDate', model.pickCreatedDate);
    setMapValue(ret, 'pickLocation', model.pickLocation);
    setMapValue(ret, 'pickedQuantity', model.pickedQuantity);
    setMapValue(ret, 'randomPickStatus', model.randomPickStatus);
    setMapValue(ret, 'refNo', model.refNo);
    setMapValue(ret, 'requestedQuantity', model.requestedQuantity);
    setMapValue(ret, 'status', model.status);
    setMapValue(ret, 'stockType', model.stockType);
    setMapValue(ret, 'stockTypeId', model.stockTypeId);
    setMapValue(ret, 'vPart', model.vPart);
    setMapValue(ret, 'warehouseInboundId', model.warehouseInboundId);
    setMapValue(ret, 'actorId', model.actorId);
    setMapValue(ret, 'siteId', model.siteId);
    setMapValue(
        ret, 'allowedQty', codeIterable(model.allowedQty, (val) => val as int));
    return ret;
  }

  @override
  PickLocationDTOList fromMap(Map map) {
    if (map == null) return null;
    final obj = PickLocationDTOList();
    obj.accountId = map['accountId'] as String;
    obj.currentBin = map['currentBin'] as String;
    obj.currentBinQuantity = map['currentBinQuantity'] as int;
    obj.orderId = map['orderId'] as String;
    obj.packedQuantity = map['packedQuantity'] as int;
    obj.partMasterId = map['partMasterId'] as String;
    obj.partNumber = map['partNumber'] as String;
    obj.partsInOrderId = map['partsInOrderId'] as String;
    obj.pickCreatedDate = map['pickCreatedDate'] as String;
    obj.pickLocation = map['pickLocation'] as String;
    obj.pickedQuantity = map['pickedQuantity'] as int;
    obj.randomPickStatus = map['randomPickStatus'] as int;
    obj.refNo = map['refNo'] as String;
    obj.requestedQuantity = map['requestedQuantity'] as int;
    obj.status = map['status'] as int;
    obj.stockType = map['stockType'] as String;
    obj.stockTypeId = map['stockTypeId'] as String;
    obj.vPart = map['vPart'] as bool;
    obj.warehouseInboundId = map['warehouseInboundId'] as String;
    obj.actorId = map['actorId'] as String;
    obj.siteId = map['siteId'] as String;
    obj.allowedQty =
        codeIterable<int>(map['allowedQty'] as Iterable, (val) => val as int);
    return obj;
  }
}
