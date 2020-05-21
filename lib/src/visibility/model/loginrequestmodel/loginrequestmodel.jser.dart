// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loginrequestmodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$LoginRequestModelSerializer
    implements Serializer<LoginRequestModel> {
  @override
  Map<String, dynamic> toMap(LoginRequestModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'userName', model.userName);
    setMapValue(ret, 'password', model.password);
    return ret;
  }

  @override
  LoginRequestModel fromMap(Map map) {
    if (map == null) return null;
    final obj = LoginRequestModel();
    obj.userName = map['userName'] as String;
    obj.password = map['password'] as String;
    return obj;
  }
}
