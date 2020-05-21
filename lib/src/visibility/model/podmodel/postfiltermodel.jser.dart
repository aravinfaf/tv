// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postfiltermodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$PostFilterModelSerilizer
    implements Serializer<PostFilterModel> {
  Serializer<GenericDtoList> __genericDtoListSerilizer;
  Serializer<GenericDtoList> get _genericDtoListSerilizer =>
      __genericDtoListSerilizer ??= GenericDtoListSerilizer();
  @override
  Map<String, dynamic> toMap(PostFilterModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'column', model.column);
    setMapValue(ret, 'search', model.search);
    setMapValue(ret, 'siteId', model.siteId);
    setMapValue(ret, 'statusMasterId', model.statusMasterId);
    setMapValue(
        ret,
        'genericDTOList',
        codeIterable(model.genericDTOList,
            (val) => _genericDtoListSerilizer.toMap(val as GenericDtoList)));
    setMapValue(ret, 'totalPages', model.totalPages);
    setMapValue(ret, 'totalElements', model.totalElements);
    setMapValue(ret, 'pageSize', model.pageSize);
    setMapValue(ret, 'pageNumber', model.pageNumber);
    setMapValue(ret, 'userid', model.userid);
    setMapValue(ret, 'pickerId', model.pickerId);
    setMapValue(ret, 'customerref', model.customerref);
    setMapValue(ret, 'paged', model.paged);
    return ret;
  }

  @override
  PostFilterModel fromMap(Map map) {
    if (map == null) return null;
    final obj = PostFilterModel();
    obj.column = map['column'] as String;
    obj.search = map['search'] as String;
    obj.siteId = map['siteId'] as String;
    obj.statusMasterId = map['statusMasterId'] as String;
    obj.genericDTOList = codeIterable<GenericDtoList>(
        map['genericDTOList'] as Iterable,
        (val) => _genericDtoListSerilizer.fromMap(val as Map));
    obj.totalPages = map['totalPages'] as int;
    obj.totalElements = map['totalElements'] as int;
    obj.pageSize = map['pageSize'] as int;
    obj.pageNumber = map['pageNumber'] as int;
    obj.userid = map['userid'] as String;
    obj.pickerId = map['pickerId'] as String;
    obj.customerref = map['customerref'] as String;
    obj.paged = map['paged'] as bool;
    return obj;
  }
}

abstract class _$GenericDtoListSerilizer implements Serializer<GenericDtoList> {
  @override
  Map<String, dynamic> toMap(GenericDtoList model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'driverName', model.driverName);
    setMapValue(ret, 'inOutTime', model.inOutTime);
    setMapValue(ret, 'vehNumber', model.vehNumber);
    setMapValue(ret, 'vehicleInTime', model.vehicleInTime);
    setMapValue(ret, 'vehicleOutTime', model.vehicleOutTime);
    setMapValue(ret, 'gateInTime', model.gateInTime);
    setMapValue(ret, 'vehicleReleaseTime', model.vehicleReleaseTime);
    setMapValue(ret, 'ordersMasterId', model.ordersMasterId);
    setMapValue(ret, 'pickListId', model.pickListId);
    setMapValue(
        ret, 'vehicleInOutTypesMasterId', model.vehicleInOutTypesMasterId);
    setMapValue(ret, 'phonenumber', model.phonenumber);
    setMapValue(ret, 'vehicleStatus', model.vehicleStatus);
    setMapValue(ret, 'vehicleTime', model.vehicleTime);
    setMapValue(ret, 'podUserId', model.podUserId);
    setMapValue(ret, 'supervisorUserId', model.supervisorUserId);
    setMapValue(ret, 'siteMasterId', model.siteMasterId);
    setMapValue(ret, 'statusCodeMasterId', model.statusCodeMasterId);
    setMapValue(ret, 'invoiceNumber', model.invoiceNumber);
    setMapValue(ret, 'partNumber', model.partNumber);
    setMapValue(ret, 'quantity', model.quantity);
    setMapValue(ret, 'partType', model.partType);
    setMapValue(ret, 'partMasterId', model.partMasterId);
    setMapValue(ret, 'partsMasterId', model.partsMasterId);
    setMapValue(ret, 'serailNumber', model.serailNumber);
    setMapValue(ret, 'orderMasterId', model.orderMasterId);
    setMapValue(ret, 'partsInOrderId', model.partsInOrderId);
    setMapValue(ret, 'balanceQty', model.balanceQty);
    setMapValue(ret, 'balanceToBin', model.balanceToBin);
    setMapValue(ret, 'stockTypeCode', model.stockTypeCode);
    setMapValue(ret, 'accountsMasterId', model.accountsMasterId);
    setMapValue(ret, 'refNo', model.refNo);
    setMapValue(ret, 'orderId', model.orderId);
    setMapValue(ret, 'requestedQuantity', model.requestedQuantity);
    setMapValue(ret, 'pickedQuantity', model.pickedQuantity);
    setMapValue(ret, 'pickLocation', model.pickLocation);
    setMapValue(ret, 'stockType', model.stockType);
    setMapValue(ret, 'vPart', model.vPart);
    setMapValue(ret, 'status', model.status);
    setMapValue(ret, 'randomPickStatus', model.randomPickStatus);
    setMapValue(ret, 'currentPickQuantity', model.currentPickQuantity);
    setMapValue(ret, 'stockTypeId', model.stockTypeId);
    setMapValue(ret, 'warehouseInboundId', model.warehouseInboundId);
    setMapValue(ret, 'packedQuantity', model.packedQuantity);
    setMapValue(ret, 'accountId', model.accountId);
    setMapValue(ret, 'currentBin', model.currentBin);
    setMapValue(ret, 'currentBinQuantity', model.currentBinQuantity);
    setMapValue(ret, 'pickCreatedDate', model.pickCreatedDate);
    setMapValue(ret, 'orderCreatedDate', model.orderCreatedDate);
    setMapValue(ret, 'vehicleCreatedDate', model.vehicleCreatedDate);
    setMapValue(ret, 'gateOut', model.gateOut);
    setMapValue(ret, 'actorTypeId', model.actorTypeId);
    setMapValue(ret, 'actorTypeName', model.actorTypeName);
    setMapValue(ret, 'isLabelGen', model.isLabelGen);
    return ret;
  }

  @override
  GenericDtoList fromMap(Map map) {
    if (map == null) return null;
    final obj = GenericDtoList();
    obj.id = map['id'] as String;
    obj.driverName = map['driverName'] as String;
    obj.inOutTime = map['inOutTime'] as String;
    obj.vehNumber = map['vehNumber'] as String;
    obj.vehicleInTime = map['vehicleInTime'] as String;
    obj.vehicleOutTime = map['vehicleOutTime'] as String;
    obj.gateInTime = map['gateInTime'] as String;
    obj.vehicleReleaseTime = map['vehicleReleaseTime'] as String;
    obj.ordersMasterId = map['ordersMasterId'] as int;
    obj.pickListId = map['pickListId'] as int;
    obj.vehicleInOutTypesMasterId = map['vehicleInOutTypesMasterId'] as int;
    obj.phonenumber = map['phonenumber'] as int;
    obj.vehicleStatus = map['vehicleStatus'] as String;
    obj.vehicleTime = map['vehicleTime'] as String;
    obj.podUserId = map['podUserId'] as String;
    obj.supervisorUserId = map['supervisorUserId'] as String;
    obj.siteMasterId = map['siteMasterId'] as String;
    obj.statusCodeMasterId = map['statusCodeMasterId'] as String;
    obj.invoiceNumber = map['invoiceNumber'] as String;
    obj.partNumber = map['partNumber'] as String;
    obj.quantity = map['quantity'] as int;
    obj.partType = map['partType'] as String;
    obj.partMasterId = map['partMasterId'] as String;
    obj.partsMasterId = map['partsMasterId'] as String;
    obj.serailNumber = map['serailNumber'] as String;
    obj.orderMasterId = map['orderMasterId'] as String;
    obj.partsInOrderId = map['partsInOrderId'] as String;
    obj.balanceQty = map['balanceQty'] as int;
    obj.balanceToBin = map['balanceToBin'] as int;
    obj.stockTypeCode = map['stockTypeCode'] as String;
    obj.accountsMasterId = map['accountsMasterId'] as String;
    obj.refNo = map['refNo'] as String;
    obj.orderId = map['orderId'] as String;
    obj.requestedQuantity = map['requestedQuantity'] as int;
    obj.pickedQuantity = map['pickedQuantity'] as int;
    obj.pickLocation = map['pickLocation'] as String;
    obj.stockType = map['stockType'] as String;
    obj.vPart = map['vPart'] as bool;
    obj.status = map['status'] as int;
    obj.randomPickStatus = map['randomPickStatus'] as int;
    obj.currentPickQuantity = map['currentPickQuantity'] as int;
    obj.stockTypeId = map['stockTypeId'] as String;
    obj.warehouseInboundId = map['warehouseInboundId'] as String;
    obj.packedQuantity = map['packedQuantity'] as int;
    obj.accountId = map['accountId'] as String;
    obj.currentBin = map['currentBin'] as String;
    obj.currentBinQuantity = map['currentBinQuantity'] as int;
    obj.pickCreatedDate = map['pickCreatedDate'] as String;
    obj.orderCreatedDate = map['orderCreatedDate'] as String;
    obj.vehicleCreatedDate = map['vehicleCreatedDate'] as String;
    obj.gateOut = map['gateOut'] as bool;
    obj.actorTypeId = map['actorTypeId'] as String;
    obj.actorTypeName = map['actorTypeName'] as String;
    obj.isLabelGen = map['isLabelGen'] as bool;
    return obj;
  }
}
