import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'loginrequestmodel.jser.dart';

class LoginRequestModel{
  String userName;
  String password;

  LoginRequestModel({this.userName,this.password});
}

@GenSerializer()
class LoginRequestModelSerializer extends Serializer<LoginRequestModel> with _$LoginRequestModelSerializer{}
