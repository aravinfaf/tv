import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'postpoddetailsmodel.jser.dart';

@GenSerializer()
class PostPodDetailsModelSerializer extends Serializer<PostPodDetailsModel>
    with _$PostPodDetailsModelSerializer {}

class PostPodDetailsModel {
  String comments;
  int damagedQty;
  int expectedQty;
  List<dynamic> partsInOrderStatusesDtOs;
  int receivedQty;
  String siteMasterId;
  String taskInstanceId;
  String userId;
  String vehicleInOutId;
  String podIssueDate;

  PostPodDetailsModel({
    this.comments,
    this.damagedQty,
    this.expectedQty,
    this.partsInOrderStatusesDtOs,
    this.receivedQty,
    this.siteMasterId,
    this.taskInstanceId,
    this.userId,
    this.vehicleInOutId,
    this.podIssueDate
  });

}
