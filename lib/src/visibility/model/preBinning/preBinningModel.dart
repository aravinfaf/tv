import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'preBinningModel.jser.dart';

@GenSerializer()
class PreBinningModelSerializer extends Serializer<PreBinningModel>
    with _$PreBinningModelSerializer{}



class PreBinningModel{

  String accName;

  int availableQuantity;

  String batchNo;

  String binnedDate;

  String binnedDateTimeZone;

  String cartonNumber;

  String cartonTypesMasterId;

  String custRef;

  @Alias("damagedQuanty")
  int damagedQuantity;

  String deliveryTypesMasterId;

  String expiryDate;

  String expiryDateTimeZone;

  String id;

  String invoiceNumber;

  bool isCustomerLabel;

  bool isDiscrepency;

  int isExcess;

  String manufacturingDate;

  String manufacturingDateTimeZone;

  String materialInboundTypesMasterId;

  String materialStatusTypeId;

  int noOfLabels;

  String orderId;

  String partsInOrderId;

  String partsMasterId;

  String partsNumber;

  int pickedQuantity;

  int processFlag;

  int quantity;

  String reason;

  String reference;

  @Alias("damagedQuanty")
  int requestedQuantity;

  String returnCodesMasterId;

  String serialNumber;

  String serviceTypesMasterId;

  int shortReceived;

  String siteId;

  String statusCodeMasterId;

  String stockSerial2;

  String stockTypesMasterId;

  String timeZone;

  int totalQty;

  String wahrehouseInboundId;

  String warehouseMatOutboundId;

  String partTypeMasterId;

  String poCreatedDate;

  PreBinningModel({this.accName, this.availableQuantity, this.batchNo,
      this.binnedDate, this.binnedDateTimeZone, this.cartonNumber,
      this.cartonTypesMasterId, this.custRef, this.damagedQuantity,
      this.deliveryTypesMasterId, this.expiryDate, this.expiryDateTimeZone,
      this.id, this.invoiceNumber, this.isCustomerLabel, this.isDiscrepency,
      this.isExcess, this.manufacturingDate, this.manufacturingDateTimeZone,
      this.materialInboundTypesMasterId, this.materialStatusTypeId,
      this.noOfLabels, this.orderId, this.partsInOrderId, this.partsMasterId,
      this.partsNumber, this.pickedQuantity, this.processFlag, this.quantity,
      this.reason, this.reference, this.requestedQuantity,
      this.returnCodesMasterId, this.serialNumber, this.serviceTypesMasterId,
      this.shortReceived, this.siteId, this.statusCodeMasterId,
      this.stockSerial2, this.stockTypesMasterId, this.timeZone, this.totalQty,
      this.wahrehouseInboundId, this.warehouseMatOutboundId, this.partTypeMasterId, this.poCreatedDate});


}


class PreBinningResponseModel{

  String column;

  String search;

  String taskkey;

  List<PreBinningModel> genericDTOList;

  int totalPages;

  int totalElements;

  int pageSize;

  int pageNumber;

  String customerreference;

  String serialNumber;

  int status;

  String error;

  String message;

}

@GenSerializer()
class PreBinningResponseModelSerializer extends Serializer<PreBinningResponseModel> with
_$PreBinningResponseModelSerializer{}