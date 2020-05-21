// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ExceptionModel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$ExceptionModelSerializer
    implements Serializer<ExceptionModel> {
  @override
  Map<String, dynamic> toMap(ExceptionModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'cause', model.cause);
    setMapValue(ret, 'error', model.error);
    setMapValue(ret, 'type', model.type);
    setMapValue(ret, 'title', model.title);
    setMapValue(ret, 'status', model.status);
    setMapValue(ret, 'detail', model.detail);
    setMapValue(ret, 'message', model.message);
    setMapValue(ret, 'localizedMessage', model.localizedMessage);
    return ret;
  }

  @override
  ExceptionModel fromMap(Map map) {
    if (map == null) return null;
    final obj = ExceptionModel();
    obj.cause = map['cause'] as String;
    obj.error = map['error'] as String;
    obj.type = map['type'] as String;
    obj.title = map['title'] as String;
    obj.status = map['status'] as String;
    obj.detail = map['detail'] as String;
    obj.message = map['message'] as String;
    obj.localizedMessage = map['localizedMessage'] as String;
    return obj;
  }
}
