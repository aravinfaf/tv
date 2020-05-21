// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notificationDataModel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$NotificationDataModelSerializer
    implements Serializer<NotificationDataModel> {
  @override
  Map<String, dynamic> toMap(NotificationDataModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'businessKey', model.businessKey);
    setMapValue(ret, 'heading', model.heading);
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'message', model.message);
    setMapValue(ret, 'messageId', model.messageId);
    setMapValue(ret, 'messageTime', model.messageTime);
    setMapValue(ret, 'notificationTypeId', model.notificationTypeId);
    setMapValue(ret, 'userId', model.userId);
    setMapValue(ret, 'workflowProcessKey', model.workflowProcessKey);
    setMapValue(ret, 'workflowTaskKey', model.workflowTaskKey);
    return ret;
  }

  @override
  NotificationDataModel fromMap(Map map) {
    if (map == null) return null;
    final obj = NotificationDataModel();
    obj.businessKey = map['businessKey'] as String;
    obj.heading = map['heading'] as String;
    obj.id = map['id'] as int;
    obj.message = map['message'] as String;
    obj.messageId = map['messageId'] as String;
    obj.messageTime = map['messageTime'] as String;
    obj.notificationTypeId = map['notificationTypeId'] as int;
    obj.userId = map['userId'] as String;
    obj.workflowProcessKey = map['workflowProcessKey'] as String;
    obj.workflowTaskKey = map['workflowTaskKey'] as String;
    return obj;
  }
}
