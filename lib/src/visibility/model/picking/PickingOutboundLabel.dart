import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'PickingOutboundLabel.jser.dart';

@GenSerializer()
class OutboundLabelSerializer extends Serializer<OutboundLabel>
    with _$OutboundLabelSerializer {}

class OutboundLabel {
  int noOfLabels;
  String ordersMasterId;
  String partsInOrderId;
  String partsMasterId;
  String siteMasterId;
  String stockTypeId;
  String wareHouseInboundId;

  OutboundLabel(
      {this.siteMasterId,
      this.ordersMasterId,
      this.partsMasterId,
      this.partsInOrderId,
      this.noOfLabels,
      this.stockTypeId,
      this.wareHouseInboundId});
}
