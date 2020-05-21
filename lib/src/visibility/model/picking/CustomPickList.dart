import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'CustomPickList.jser.dart';

@GenSerializer()
class CustomPickListSerilizer extends Serializer<CustomPickList>
    with _$CustomPickListSerilizer {}

@GenSerializer()
class PickLocationDTOListSerilizer extends Serializer<PickLocationDTOList>
    with _$PickLocationDTOListSerilizer {}

class CustomPickList {
  String column;
  int pageNumber;
  int pageSize;
  String search;
  String siteId;
  int totalElements;
  int totalPages;
  String userId;
  List<PickLocationDTOList> pickLocationDTOList;

  CustomPickList({
    this.column,
    this.search,
    this.siteId,
    this.pickLocationDTOList,
    this.totalPages,
    this.totalElements,
    this.pageSize,
    this.pageNumber,
    this.userId,
  });
}

class PickLocationDTOList {
  String accountId;
  String currentBin;
  int currentBinQuantity;
  String orderId;
  int packedQuantity;
  String partMasterId;
  String partNumber;
  String partsInOrderId;
  String pickCreatedDate;
  String pickLocation;
  int pickedQuantity;
  int randomPickStatus;
  String refNo;
  int requestedQuantity;
  int status;
  String stockType;
  String stockTypeId;
  bool vPart;
  String warehouseInboundId;
  String actorId;
  String siteId;
  List<int> allowedQty;

  PickLocationDTOList(
      {this.partNumber,
      this.partMasterId,
      this.partsInOrderId,
      this.refNo,
      this.orderId,
      this.pickedQuantity,
      this.pickLocation,
      this.stockType,
      this.stockTypeId,
      this.status,
      this.requestedQuantity,
      this.randomPickStatus,
      this.vPart,
      this.warehouseInboundId,
      this.packedQuantity,
      this.accountId,
      this.currentBin,
      this.currentBinQuantity,
      this.pickCreatedDate,
      this.actorId,
      this.siteId,this.allowedQty});
}
