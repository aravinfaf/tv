import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'activetaskresponsemodel.jser.dart';

@GenSerializer()
class ActiveTaskConsolidationModelSerializer
    extends Serializer<ActiveTaskConsolidationModel>
    with _$ActiveTaskConsolidationModelSerializer {}

class ActiveTaskConsolidationModel {
  @Alias("businessKey")
  String mBusinessKey;
  @Alias("orderReference")
  String mOrderReference;
  @Alias("processDefenitionId")
  String mProcessDefenitionId;
  @Alias("processInstanceId")
  String mProcessInstanceId;
  @Alias("taskInstanceId")
  String mTaskInstanceId;
  @Alias("taskdefenitionId")
  String mTaskdefenitionId;

  ActiveTaskConsolidationModel(this.mBusinessKey, this.mOrderReference,
      this.mProcessDefenitionId, this.mProcessInstanceId, this.mTaskInstanceId,
      this.mTaskdefenitionId);


}
