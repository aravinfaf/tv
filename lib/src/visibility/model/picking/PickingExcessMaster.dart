import 'package:jaguar_serializer/jaguar_serializer.dart';

import 'PickingExcessMasterMapping.dart';
part 'PickingExcessMaster.jser.dart';

@GenSerializer()
class ExcessMasterSerializer extends Serializer<ExcessMaster>
    with _$ExcessMasterSerializer {}

class ExcessMaster {
  String accountsMasterId;
  List<ExcessMasterMapping> excessMasterMappings;
  String id;
  String isCustomerLabel;
  int noOfLabel;
  String notificationMasterId;
  String ordersMasterId;
  String partsMasterId;
  int quantity;
  String siteMasterId;
  String userId;
  String warehouseInboundId;

  ExcessMaster({
    this.quantity,
    this.accountsMasterId,
    this.partsMasterId,
    this.id,
    this.excessMasterMappings,
    this.isCustomerLabel,
    this.noOfLabel,
    this.notificationMasterId,
    this.ordersMasterId,
    this.siteMasterId,
    this.userId,
    this.warehouseInboundId,
  });
}
