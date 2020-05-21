import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'loginresponsemodel.jser.dart';

class LoginResponseModel{
 String userName;
 String password;
 String tocken;
 @Ignore()
 bool error=false;
}

@GenSerializer()
class LoginResponseModelSerializer extends Serializer<LoginResponseModel> with _$LoginResponseModelSerializer{}
