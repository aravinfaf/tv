// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postpoddetailsmodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$PostPodDetailsModelSerializer
    implements Serializer<PostPodDetailsModel> {
  @override
  Map<String, dynamic> toMap(PostPodDetailsModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'comments', model.comments);
    setMapValue(ret, 'damagedQty', model.damagedQty);
    setMapValue(ret, 'expectedQty', model.expectedQty);
    setMapValue(
        ret,
        'partsInOrderStatusesDtOs',
        codeIterable(model.partsInOrderStatusesDtOs,
            (val) => passProcessor.serialize(val)));
    setMapValue(ret, 'receivedQty', model.receivedQty);
    setMapValue(ret, 'siteMasterId', model.siteMasterId);
    setMapValue(ret, 'taskInstanceId', model.taskInstanceId);
    setMapValue(ret, 'userId', model.userId);
    setMapValue(ret, 'vehicleInOutId', model.vehicleInOutId);
    setMapValue(ret, 'podIssueDate', model.podIssueDate);
    return ret;
  }

  @override
  PostPodDetailsModel fromMap(Map map) {
    if (map == null) return null;
    final obj = PostPodDetailsModel();
    obj.comments = map['comments'] as String;
    obj.damagedQty = map['damagedQty'] as int;
    obj.expectedQty = map['expectedQty'] as int;
    obj.partsInOrderStatusesDtOs = codeIterable<dynamic>(
        map['partsInOrderStatusesDtOs'] as Iterable,
        (val) => passProcessor.deserialize(val));
    obj.receivedQty = map['receivedQty'] as int;
    obj.siteMasterId = map['siteMasterId'] as String;
    obj.taskInstanceId = map['taskInstanceId'] as String;
    obj.userId = map['userId'] as String;
    obj.vehicleInOutId = map['vehicleInOutId'] as String;
    obj.podIssueDate = map['podIssueDate'] as String;
    return obj;
  }
}
