
import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'notificationDataModel.jser.dart';

class NotificationDataModel{
  String businessKey;
  String heading;
  int id;
  String message;
  String messageId;
  String messageTime;
  int notificationTypeId;
  String userId;
  String workflowProcessKey;
  String workflowTaskKey;
  @Ignore()
  bool error=false;
}

@GenSerializer()
class NotificationDataModelSerializer extends Serializer<NotificationDataModel> with _$NotificationDataModelSerializer{}
