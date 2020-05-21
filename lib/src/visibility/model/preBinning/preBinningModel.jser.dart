// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preBinningModel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$PreBinningModelSerializer
    implements Serializer<PreBinningModel> {
  @override
  Map<String, dynamic> toMap(PreBinningModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'accName', model.accName);
    setMapValue(ret, 'availableQuantity', model.availableQuantity);
    setMapValue(ret, 'batchNo', model.batchNo);
    setMapValue(ret, 'binnedDate', model.binnedDate);
    setMapValue(ret, 'binnedDateTimeZone', model.binnedDateTimeZone);
    setMapValue(ret, 'cartonNumber', model.cartonNumber);
    setMapValue(ret, 'cartonTypesMasterId', model.cartonTypesMasterId);
    setMapValue(ret, 'custRef', model.custRef);
    setMapValue(ret, 'damagedQuanty', model.damagedQuantity);
    setMapValue(ret, 'deliveryTypesMasterId', model.deliveryTypesMasterId);
    setMapValue(ret, 'expiryDate', model.expiryDate);
    setMapValue(ret, 'expiryDateTimeZone', model.expiryDateTimeZone);
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'invoiceNumber', model.invoiceNumber);
    setMapValue(ret, 'isCustomerLabel', model.isCustomerLabel);
    setMapValue(ret, 'isDiscrepency', model.isDiscrepency);
    setMapValue(ret, 'isExcess', model.isExcess);
    setMapValue(ret, 'manufacturingDate', model.manufacturingDate);
    setMapValue(
        ret, 'manufacturingDateTimeZone', model.manufacturingDateTimeZone);
    setMapValue(ret, 'materialInboundTypesMasterId',
        model.materialInboundTypesMasterId);
    setMapValue(ret, 'materialStatusTypeId', model.materialStatusTypeId);
    setMapValue(ret, 'noOfLabels', model.noOfLabels);
    setMapValue(ret, 'orderId', model.orderId);
    setMapValue(ret, 'partsInOrderId', model.partsInOrderId);
    setMapValue(ret, 'partsMasterId', model.partsMasterId);
    setMapValue(ret, 'partsNumber', model.partsNumber);
    setMapValue(ret, 'pickedQuantity', model.pickedQuantity);
    setMapValue(ret, 'processFlag', model.processFlag);
    setMapValue(ret, 'quantity', model.quantity);
    setMapValue(ret, 'reason', model.reason);
    setMapValue(ret, 'reference', model.reference);
    setMapValue(ret, 'damagedQuanty', model.requestedQuantity);
    setMapValue(ret, 'returnCodesMasterId', model.returnCodesMasterId);
    setMapValue(ret, 'serialNumber', model.serialNumber);
    setMapValue(ret, 'serviceTypesMasterId', model.serviceTypesMasterId);
    setMapValue(ret, 'shortReceived', model.shortReceived);
    setMapValue(ret, 'siteId', model.siteId);
    setMapValue(ret, 'statusCodeMasterId', model.statusCodeMasterId);
    setMapValue(ret, 'stockSerial2', model.stockSerial2);
    setMapValue(ret, 'stockTypesMasterId', model.stockTypesMasterId);
    setMapValue(ret, 'timeZone', model.timeZone);
    setMapValue(ret, 'totalQty', model.totalQty);
    setMapValue(ret, 'wahrehouseInboundId', model.wahrehouseInboundId);
    setMapValue(ret, 'warehouseMatOutboundId', model.warehouseMatOutboundId);
    setMapValue(ret, 'partTypeMasterId', model.partTypeMasterId);
    setMapValue(ret, 'poCreatedDate', model.poCreatedDate);
    return ret;
  }

  @override
  PreBinningModel fromMap(Map map) {
    if (map == null) return null;
    final obj = PreBinningModel();
    obj.accName = map['accName'] as String;
    obj.availableQuantity = map['availableQuantity'] as int;
    obj.batchNo = map['batchNo'] as String;
    obj.binnedDate = map['binnedDate'] as String;
    obj.binnedDateTimeZone = map['binnedDateTimeZone'] as String;
    obj.cartonNumber = map['cartonNumber'] as String;
    obj.cartonTypesMasterId = map['cartonTypesMasterId'] as String;
    obj.custRef = map['custRef'] as String;
    obj.damagedQuantity = map['damagedQuanty'] as int;
    obj.deliveryTypesMasterId = map['deliveryTypesMasterId'] as String;
    obj.expiryDate = map['expiryDate'] as String;
    obj.expiryDateTimeZone = map['expiryDateTimeZone'] as String;
    obj.id = map['id'] as String;
    obj.invoiceNumber = map['invoiceNumber'] as String;
    obj.isCustomerLabel = map['isCustomerLabel'] as bool;
    obj.isDiscrepency = map['isDiscrepency'] as bool;
    obj.isExcess = map['isExcess'] as int;
    obj.manufacturingDate = map['manufacturingDate'] as String;
    obj.manufacturingDateTimeZone = map['manufacturingDateTimeZone'] as String;
    obj.materialInboundTypesMasterId =
        map['materialInboundTypesMasterId'] as String;
    obj.materialStatusTypeId = map['materialStatusTypeId'] as String;
    obj.noOfLabels = map['noOfLabels'] as int;
    obj.orderId = map['orderId'] as String;
    obj.partsInOrderId = map['partsInOrderId'] as String;
    obj.partsMasterId = map['partsMasterId'] as String;
    obj.partsNumber = map['partsNumber'] as String;
    obj.pickedQuantity = map['pickedQuantity'] as int;
    obj.processFlag = map['processFlag'] as int;
    obj.quantity = map['quantity'] as int;
    obj.reason = map['reason'] as String;
    obj.reference = map['reference'] as String;
    obj.requestedQuantity = map['damagedQuanty'] as int;
    obj.returnCodesMasterId = map['returnCodesMasterId'] as String;
    obj.serialNumber = map['serialNumber'] as String;
    obj.serviceTypesMasterId = map['serviceTypesMasterId'] as String;
    obj.shortReceived = map['shortReceived'] as int;
    obj.siteId = map['siteId'] as String;
    obj.statusCodeMasterId = map['statusCodeMasterId'] as String;
    obj.stockSerial2 = map['stockSerial2'] as String;
    obj.stockTypesMasterId = map['stockTypesMasterId'] as String;
    obj.timeZone = map['timeZone'] as String;
    obj.totalQty = map['totalQty'] as int;
    obj.wahrehouseInboundId = map['wahrehouseInboundId'] as String;
    obj.warehouseMatOutboundId = map['warehouseMatOutboundId'] as String;
    obj.partTypeMasterId = map['partTypeMasterId'] as String;
    obj.poCreatedDate = map['poCreatedDate'] as String;
    return obj;
  }
}

abstract class _$PreBinningResponseModelSerializer
    implements Serializer<PreBinningResponseModel> {
  Serializer<PreBinningModel> __preBinningModelSerializer;
  Serializer<PreBinningModel> get _preBinningModelSerializer =>
      __preBinningModelSerializer ??= PreBinningModelSerializer();
  @override
  Map<String, dynamic> toMap(PreBinningResponseModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'column', model.column);
    setMapValue(ret, 'search', model.search);
    setMapValue(ret, 'taskkey', model.taskkey);
    setMapValue(
        ret,
        'genericDTOList',
        codeIterable(model.genericDTOList,
            (val) => _preBinningModelSerializer.toMap(val as PreBinningModel)));
    setMapValue(ret, 'totalPages', model.totalPages);
    setMapValue(ret, 'totalElements', model.totalElements);
    setMapValue(ret, 'pageSize', model.pageSize);
    setMapValue(ret, 'pageNumber', model.pageNumber);
    setMapValue(ret, 'customerreference', model.customerreference);
    setMapValue(ret, 'serialNumber', model.serialNumber);
    setMapValue(ret, 'status', model.status);
    setMapValue(ret, 'error', model.error);
    setMapValue(ret, 'message', model.message);
    return ret;
  }

  @override
  PreBinningResponseModel fromMap(Map map) {
    if (map == null) return null;
    final obj = PreBinningResponseModel();
    obj.column = map['column'] as String;
    obj.search = map['search'] as String;
    obj.taskkey = map['taskkey'] as String;
    obj.genericDTOList = codeIterable<PreBinningModel>(
        map['genericDTOList'] as Iterable,
        (val) => _preBinningModelSerializer.fromMap(val as Map));
    obj.totalPages = map['totalPages'] as int;
    obj.totalElements = map['totalElements'] as int;
    obj.pageSize = map['pageSize'] as int;
    obj.pageNumber = map['pageNumber'] as int;
    obj.customerreference = map['customerreference'] as String;
    obj.serialNumber = map['serialNumber'] as String;
    obj.status = map['status'] as int;
    obj.error = map['error'] as String;
    obj.message = map['message'] as String;
    return obj;
  }
}
