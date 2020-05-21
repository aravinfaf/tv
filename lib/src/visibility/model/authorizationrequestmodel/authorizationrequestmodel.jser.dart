// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorizationrequestmodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$AuthorizationRequestModelSerializer
    implements Serializer<AuthorizationRequestModel> {
  @override
  Map<String, dynamic> toMap(AuthorizationRequestModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'deviceId', model.deviceId);
    setMapValue(ret, 'fcmToken', model.fcmToken);
    setMapValue(ret, 'username', model.username);
    return ret;
  }

  @override
  AuthorizationRequestModel fromMap(Map map) {
    if (map == null) return null;
    final obj = AuthorizationRequestModel();
    obj.deviceId = map['deviceId'] as String;
    obj.fcmToken = map['fcmToken'] as String;
    obj.username = map['username'] as String;
    return obj;
  }
}
