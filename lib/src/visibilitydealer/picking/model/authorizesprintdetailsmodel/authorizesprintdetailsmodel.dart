import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'authorizesprintdetailsmodel.jser.dart';

class AuthorizeSprintDetailsModel{
  @Alias("siteId")
  String mSiteId;
  @Alias("tenantId")
  String mTenantId;
  @Alias("userId")
  String mUserId;
  @Alias("userName")
  String mUserName;
  @Alias("appVersion")
  String mAppVersion;
  @Ignore()
  bool mError=false;

}

@GenSerializer()
class AuthorizeSprintDetailsModelSerializer extends Serializer<AuthorizeSprintDetailsModel> with _$AuthorizeSprintDetailsModelSerializer{}
