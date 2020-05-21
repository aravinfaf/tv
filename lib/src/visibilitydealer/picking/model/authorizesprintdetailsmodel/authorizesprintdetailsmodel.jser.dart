// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorizesprintdetailsmodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$AuthorizeSprintDetailsModelSerializer
    implements Serializer<AuthorizeSprintDetailsModel> {
  @override
  Map<String, dynamic> toMap(AuthorizeSprintDetailsModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'siteId', model.mSiteId);
    setMapValue(ret, 'tenantId', model.mTenantId);
    setMapValue(ret, 'userId', model.mUserId);
    setMapValue(ret, 'userName', model.mUserName);
    setMapValue(ret, 'appVersion', model.mAppVersion);
    return ret;
  }

  @override
  AuthorizeSprintDetailsModel fromMap(Map map) {
    if (map == null) return null;
    final obj = AuthorizeSprintDetailsModel();
    obj.mSiteId = map['siteId'] as String;
    obj.mTenantId = map['tenantId'] as String;
    obj.mUserId = map['userId'] as String;
    obj.mUserName = map['userName'] as String;
    obj.mAppVersion = map['appVersion'] as String;
    return obj;
  }
}
