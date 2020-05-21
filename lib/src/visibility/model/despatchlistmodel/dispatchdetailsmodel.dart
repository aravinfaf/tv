import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'dispatchdetailsmodel.jser.dart';

@GenSerializer()
class DispatchDetailsDtoSerializer extends Serializer<DispatchDetailsDto>
    with _$DispatchDetailsDtoSerializer {}

@GenSerializer()
class DispatchListDTOSerializer extends Serializer<DispatchListDTO>
    with _$DispatchListDTOSerializer {}

@GenSerializer()
class DispatchDetailsWrapperDTOSerializer
    extends Serializer<DispatchDetailsWrapperDTO>
    with _$DispatchDetailsWrapperDTOSerializer {}

class DispatchDetailsDto {
  @Alias("column")
  String mColumn;
  @Alias("search")
  String mSearch;
  @Alias("siteId")
  String mSiteId;
  @Alias("genericDTOList")
  List<DispatchListDTO> mGenericDTOList;
  @Alias("totalPages")
  int mTotalPages;
  @Alias("totalElements")
  int mTotalElements;
  @Alias("pageSize")
  int mPageSize;
  @Alias("pageNumber")
  int mPageNumber;
  @Alias("userId")
  String mUserId;

  DispatchDetailsDto({this.mColumn, this.mSearch, this.mSiteId,
    this.mGenericDTOList, this.mTotalPages, this.mTotalElements,
    this.mPageSize, this.mPageNumber, this.mUserId});
}
class DispatchListDTO {
  @Alias("packingRef")
  String mPackingRef;
  @Alias("destination")
  String mDestination;
  @Alias("serviceType")
  String mServiceType;
  @Alias("consolidationId")
  String mConsolidationId;
  @Alias("custRef")
  List<String> mCustRef;
  @Alias("orderMasterIdList")
  List<String> mOrderMasterIdList;
  @Alias("orderMasterId")
  String mOrderMasterId;
  @Alias("actorId")
  String mActorId;
  @Alias("actorName")
  String mActorName;
  @Alias("destinationId")
  String mDestinationId;
  @Alias("deliveryTypesMasterId")
  String mDeliveryTypesMasterId;
  @Alias("deliveryId")
  String mDeliveryId;
  @Alias("deliveryName")
  String mDeliveryName;
  @Alias("courierMasterId")
  String mCourierMasterId;
  @Alias("vehicleMasterId")
  String mVehicleMasterId;
  @Alias("vehicleNumber")
  String mVehicleNumber;
  @Alias("courierName")
  String mCourierName;
  @Alias("modeOfTransportMasterId")
  String mModeOfTransportMasterId;
  @Alias("address")
  String mAddress;
  @Alias("consolidationType")
  int mConsolidationType;
  @Alias("dispatchId")
  String mDispatchId;
  @Alias("dispatchMappingId")
  String mDispatchMappingId;
  @Alias("totalElements")
  int mTotalElements;
  @Alias("totalPages")
  int mTotalPages;
  @Alias("company")
  String mCompany;
  @Alias("dispatchDetailsWrapperDTO")
  List<DispatchDetailsWrapperDTO> mDispatchDetailsWrapperDTO;
  @Alias("deliveryTypeId")
  String mDeliveryTypeId;
  @Alias("devliverTypeDesc")
  String mDevliverTypeDesc;
  @Alias("orderSerialNos")
  List<String> mOrderSerialNos;
  bool finish;

  DispatchListDTO(this.mPackingRef, this.mDestination, this.mServiceType,
      this.mConsolidationId, this.mCustRef, this.mOrderMasterIdList,
      this.mOrderMasterId, this.mActorId, this.mActorName,
      this.mDestinationId, this.mDeliveryTypesMasterId, this.mDeliveryId,
      this.mDeliveryName, this.mCourierMasterId, this.mVehicleMasterId,
      this.mVehicleNumber, this.mCourierName, this.mModeOfTransportMasterId,
      this.mAddress, this.mConsolidationType, this.mDispatchId,
      this.mDispatchMappingId, this.mTotalElements, this.mTotalPages,
      this.mCompany, this.mDispatchDetailsWrapperDTO, this.mDeliveryTypeId,
      this.mDevliverTypeDesc, this.finish);
}

class DispatchDetailsWrapperDTO {
  @Alias("id")
  int mId;
  @Alias("soNo")
  String mSoNo;
  @Alias("customerName")
  String mCustomerName;
  @Alias("orderConsolidationId")
  String mOrderConsolidationId;
  @Alias("orderMasterId")
  int mOrderMasterId;

  DispatchDetailsWrapperDTO(this.mId, this.mSoNo, this.mCustomerName,
      this.mOrderConsolidationId, this.mOrderMasterId);
}
