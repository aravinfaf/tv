import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'checkpodkeymodel.jser.dart';

@GenSerializer()
class CheckPodKeySerializer extends Serializer<CheckPodKeyModel>
    with _$CheckPodKeySerializer {}

class CheckPodKeyModel {
  String businessKey;
  String orderReference;
  String processDefenitionId;
  String processInstanceId;
  String taskInstanceId;
  String taskdefenitionId;

  CheckPodKeyModel(
      {this.businessKey,
      this.orderReference,
      this.processDefenitionId,
      this.processInstanceId,
      this.taskInstanceId,
      this.taskdefenitionId});
}
