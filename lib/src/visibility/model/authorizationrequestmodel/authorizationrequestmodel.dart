import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'authorizationrequestmodel.jser.dart';

class AuthorizationRequestModel{
  String deviceId;
  String fcmToken;
  String username;

  AuthorizationRequestModel({this.deviceId,this.fcmToken,this.username});
}

@GenSerializer()
class AuthorizationRequestModelSerializer extends Serializer<AuthorizationRequestModel> with _$AuthorizationRequestModelSerializer{}
