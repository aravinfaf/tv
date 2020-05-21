import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'authorizesprintrequestmodel.jser.dart';

class AuthorizeSprintRequestModel{
  @Alias("username")
  String mUsername;

  AuthorizeSprintRequestModel(this.mUsername);
}

@GenSerializer()
class AuthorizeSprintRequestModelSerializer extends Serializer<AuthorizeSprintRequestModel> with _$AuthorizeSprintRequestModelSerializer{}
