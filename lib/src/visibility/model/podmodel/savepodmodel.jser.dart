// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'savepodmodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$SavePodModSerializer implements Serializer<SavePodModel> {
  Serializer<PartsInOrderStatusesDTOs> __partsInOrderStatusDTOsSerializer;
  Serializer<PartsInOrderStatusesDTOs> get _partsInOrderStatusDTOsSerializer =>
      __partsInOrderStatusDTOsSerializer ??= PartsInOrderStatusDTOsSerializer();
  @override
  Map<String, dynamic> toMap(SavePodModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'comments', model.comments);
    setMapValue(ret, 'damagedQty', model.damagedQty);
    setMapValue(ret, 'expectedQty', model.expectedQty);
    setMapValue(ret, 'htmlData', model.htmlData);
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'issueDate', model.issueDate);
    setMapValue(ret, 'ordersMasterId', model.ordersMasterId);
    setMapValue(
        ret,
        'partsInOrderStatusesDTOs',
        codeIterable(
            model.partsInOrderStatusesDTOs,
            (val) => _partsInOrderStatusDTOsSerializer
                .toMap(val as PartsInOrderStatusesDTOs)));
    setMapValue(ret, 'podIssueDate', model.podIssueDate);
    setMapValue(ret, 'receivedQty', model.receivedQty);
    setMapValue(ret, 'siteMasterId', model.siteMasterId);
    setMapValue(ret, 'taskInstanceId', model.taskInstanceId);
    setMapValue(ret, 'userId', model.userId);
    setMapValue(ret, 'vehicleInOutId', model.vehicleInOutId);
    setMapValue(ret, 'warehouseInboundId', model.warehouseInboundId);
    return ret;
  }

  @override
  SavePodModel fromMap(Map map) {
    if (map == null) return null;
    final obj = SavePodModel();
    obj.comments = map['comments'] as String;
    obj.damagedQty = map['damagedQty'] as int;
    obj.expectedQty = map['expectedQty'] as int;
    obj.htmlData = map['htmlData'] as String;
    obj.id = map['id'] as String;
    obj.issueDate = map['issueDate'] as String;
    obj.ordersMasterId = map['ordersMasterId'] as String;
    obj.partsInOrderStatusesDTOs = codeIterable<PartsInOrderStatusesDTOs>(
        map['partsInOrderStatusesDTOs'] as Iterable,
        (val) => _partsInOrderStatusDTOsSerializer.fromMap(val as Map));
    obj.podIssueDate = map['podIssueDate'] as String;
    obj.receivedQty = map['receivedQty'] as int;
    obj.siteMasterId = map['siteMasterId'] as String;
    obj.taskInstanceId = map['taskInstanceId'] as String;
    obj.userId = map['userId'] as String;
    obj.vehicleInOutId = map['vehicleInOutId'] as String;
    obj.warehouseInboundId = map['warehouseInboundId'] as String;
    return obj;
  }
}

abstract class _$PartsInOrderStatusDTOsSerializer
    implements Serializer<PartsInOrderStatusesDTOs> {
  @override
  Map<String, dynamic> toMap(PartsInOrderStatusesDTOs model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'damagedQty', model.damagedQty);
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'statusCodeMasterId', model.statusCodeMasterId);
    setMapValue(ret, 'vehiclePodId', model.vehiclePodId);
    return ret;
  }

  @override
  PartsInOrderStatusesDTOs fromMap(Map map) {
    if (map == null) return null;
    final obj = PartsInOrderStatusesDTOs();
    obj.damagedQty = map['damagedQty'] as int;
    obj.id = map['id'] as String;
    obj.statusCodeMasterId = map['statusCodeMasterId'] as String;
    obj.vehiclePodId = map['vehiclePodId'] as String;
    return obj;
  }
}
