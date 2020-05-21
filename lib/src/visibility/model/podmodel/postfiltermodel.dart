import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'postfiltermodel.jser.dart';

@GenSerializer()
class PostFilterModelSerilizer extends Serializer<PostFilterModel>
    with _$PostFilterModelSerilizer {}

@GenSerializer()
class GenericDtoListSerilizer extends Serializer<GenericDtoList>
    with _$GenericDtoListSerilizer {}

class PostFilterModel {
  String column;
  String search;
  String siteId;
  String statusMasterId;
  List<GenericDtoList> genericDTOList;
  int totalPages;
  int totalElements;
  int pageSize;
  int pageNumber;
  String userid;
  String pickerId;
  String customerref;
  bool paged;

  PostFilterModel(
      {this.column,
      this.search,
      this.siteId,
      this.statusMasterId,
      this.genericDTOList,
      this.totalPages,
      this.totalElements,
      this.pageSize,
      this.pageNumber,
      this.userid,
      this.pickerId,
      this.customerref,
      this.paged});
}

class GenericDtoList {
  String id;
  String driverName;
  String inOutTime;
  String vehNumber;
  String vehicleInTime;
  String vehicleOutTime;
  String gateInTime;
  String vehicleReleaseTime;
  int ordersMasterId;
  int pickListId;
  int vehicleInOutTypesMasterId;
  int phonenumber;
  String vehicleStatus;
  String vehicleTime;
  String podUserId;
  String supervisorUserId;
  String siteMasterId;
  String statusCodeMasterId;
  String invoiceNumber;
  String partNumber;
  int quantity;
  String partType;
  String partMasterId;
  String partsMasterId;
  String serailNumber;
  String orderMasterId;
  String partsInOrderId;
  int balanceQty;
  int balanceToBin;
  String stockTypeCode;
  String accountsMasterId;
  String refNo;
  String orderId;
  int requestedQuantity;
  int pickedQuantity;
  String pickLocation;
  String stockType;
  bool vPart;
  int status;
  int randomPickStatus;
  int currentPickQuantity;
  String stockTypeId;
  String warehouseInboundId;
  int packedQuantity;
  String accountId;
  String currentBin;
  int currentBinQuantity;
  String pickCreatedDate;
  String orderCreatedDate;
  String vehicleCreatedDate;
  bool gateOut;
  String actorTypeId;
  String actorTypeName;
  bool isLabelGen;

  GenericDtoList(
      {this.id,
      this.driverName,
      this.inOutTime,
      this.vehNumber,
      this.vehicleInTime,
        this.gateInTime,
      this.vehicleOutTime,
      this.vehicleReleaseTime,
      this.ordersMasterId,
      this.pickListId,
      this.vehicleInOutTypesMasterId,
      this.phonenumber,
      this.vehicleStatus,
      this.vehicleTime,
      this.podUserId,
      this.supervisorUserId,
      this.siteMasterId,
      this.statusCodeMasterId,
      this.invoiceNumber,
      this.partNumber,
      this.quantity,
      this.partType,
      this.partMasterId,
      this.partsMasterId,
      this.serailNumber,
      this.orderMasterId,
      this.partsInOrderId,
      this.balanceQty,
      this.balanceToBin,
      this.stockTypeCode,
      this.accountsMasterId,
      this.refNo,
      this.orderId,
      this.pickedQuantity,
      this.pickLocation,
      this.stockType,
      this.stockTypeId,
      this.status,
      this.requestedQuantity,
      this.currentPickQuantity,
      this.randomPickStatus,
      this.vPart,
      this.warehouseInboundId,
      this.packedQuantity,
      this.accountId,
      this.currentBin,
      this.currentBinQuantity,
      this.pickCreatedDate,
      this.orderCreatedDate,
      this.vehicleCreatedDate,
      this.gateOut,
      this.actorTypeId,
      this.actorTypeName,
      this.isLabelGen});
}
