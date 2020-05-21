class PickingLocationModel {
  String partNumber;
  String partMasterId;
  String pickLocation;
  int requestedQuantity;
  int pickedQuantity;
  int packedQuantity;
  String orderId;
  String warehouseInboundId;
  String refNo;
  bool vPart;
  String stockType;
  String stockTypeId;
  String partsInOrderId;
  int status;
  String accountId;
  String currentBin;
  int currentBinQuantity;
  int randomPickStatus;
  String pickCreatedDate;
  String actorId;
  String siteId;
  List<int> allowedQty;

  PickingLocationModel(
      {this.partNumber,
      this.partMasterId,
      this.pickLocation,
      this.requestedQuantity,
      this.pickedQuantity,
      this.packedQuantity,
      this.orderId,
      this.warehouseInboundId,
      this.refNo,
      this.vPart,
      this.stockType,
      this.stockTypeId,
      this.partsInOrderId,
      this.status,
      this.accountId,
      this.currentBin,
      this.currentBinQuantity,
      this.randomPickStatus,
      this.pickCreatedDate,
      this.actorId,
      this.siteId,
        this.allowedQty});
}
