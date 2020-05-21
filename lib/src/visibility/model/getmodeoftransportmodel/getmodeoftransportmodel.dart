import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'getmodeoftransportmodel.jser.dart';


class GetModeOfTransportModel{
  @Alias("id")
  String mId;
  @Alias("modeDesc")
  String mModeDescription;

}

@GenSerializer()
class GetModeOfTransportModelSerializer extends Serializer<GetModeOfTransportModel> with _$GetModeOfTransportModelSerializer{}
