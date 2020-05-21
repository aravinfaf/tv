// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorizesprintrequestmodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$AuthorizeSprintRequestModelSerializer
    implements Serializer<AuthorizeSprintRequestModel> {
  @override
  Map<String, dynamic> toMap(AuthorizeSprintRequestModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'username', model.mUsername);
    return ret;
  }

  @override
  AuthorizeSprintRequestModel fromMap(Map map) {
    if (map == null) return null;
    final obj = AuthorizeSprintRequestModel(getJserDefault('mUsername'));
    obj.mUsername = map['username'] as String;
    return obj;
  }
}
