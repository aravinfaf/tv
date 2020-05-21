// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loginresponsemodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$LoginResponseModelSerializer
    implements Serializer<LoginResponseModel> {
  @override
  Map<String, dynamic> toMap(LoginResponseModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'userName', model.userName);
    setMapValue(ret, 'password', model.password);
    setMapValue(ret, 'tocken', model.tocken);
    return ret;
  }

  @override
  LoginResponseModel fromMap(Map map) {
    if (map == null) return null;
    final obj = LoginResponseModel();
    obj.userName = map['userName'] as String;
    obj.password = map['password'] as String;
    obj.tocken = map['tocken'] as String;
    return obj;
  }
}
