import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'savepodmodel.jser.dart';

@GenSerializer()
class SavePodModSerializer extends Serializer<SavePodModel>
    with _$SavePodModSerializer {}

@GenSerializer()
class PartsInOrderStatusDTOsSerializer
    extends Serializer<PartsInOrderStatusesDTOs>
    with _$PartsInOrderStatusDTOsSerializer {}

class SavePodModel {
  String comments;
  
  int damagedQty;
  int expectedQty;
  String htmlData;
  String id;
  String issueDate;
  String ordersMasterId;
  List<PartsInOrderStatusesDTOs> partsInOrderStatusesDTOs;
  String podIssueDate;
  int receivedQty;
  String siteMasterId;
  String taskInstanceId;
  String userId;
  String vehicleInOutId;
  String warehouseInboundId;

  SavePodModel({this.comments,
    this.damagedQty,
    this.expectedQty,
    this.htmlData,
    this.id,
    this.issueDate,
    this.ordersMasterId,
    this.partsInOrderStatusesDTOs,
    this.podIssueDate,
    this.receivedQty,
    this.siteMasterId,
    this.taskInstanceId,
    this.userId,
    this.vehicleInOutId,
    this.warehouseInboundId});
}

class PartsInOrderStatusesDTOs {
  int damagedQty;
  String id;
  String statusCodeMasterId;
  String vehiclePodId;

  PartsInOrderStatusesDTOs(
      {this.damagedQty, this.id, this.statusCodeMasterId, this.vehiclePodId});


}