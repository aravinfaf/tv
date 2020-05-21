import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'checkpodbybusinesskeymodel.jser.dart';

class CheckPODByBusinessKeyModel{
  @Alias("taskdefenitionId")
  String mTaskDefinitionId;
  @Ignore()
  bool mError=false;

  CheckPODByBusinessKeyModel({this.mTaskDefinitionId});
}

@GenSerializer()
class CheckPODByBusinessKeyModelSerializer extends Serializer<CheckPODByBusinessKeyModel> with _$CheckPODByBusinessKeyModelSerializer{}

