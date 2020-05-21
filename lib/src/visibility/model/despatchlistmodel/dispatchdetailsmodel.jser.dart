// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dispatchdetailsmodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$DispatchDetailsDtoSerializer
    implements Serializer<DispatchDetailsDto> {
  Serializer<DispatchListDTO> __dispatchListDTOSerializer;
  Serializer<DispatchListDTO> get _dispatchListDTOSerializer =>
      __dispatchListDTOSerializer ??= DispatchListDTOSerializer();
  @override
  Map<String, dynamic> toMap(DispatchDetailsDto model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'column', model.mColumn);
    setMapValue(ret, 'search', model.mSearch);
    setMapValue(ret, 'siteId', model.mSiteId);
    setMapValue(
        ret,
        'genericDTOList',
        codeIterable(model.mGenericDTOList,
            (val) => _dispatchListDTOSerializer.toMap(val as DispatchListDTO)));
    setMapValue(ret, 'totalPages', model.mTotalPages);
    setMapValue(ret, 'totalElements', model.mTotalElements);
    setMapValue(ret, 'pageSize', model.mPageSize);
    setMapValue(ret, 'pageNumber', model.mPageNumber);
    setMapValue(ret, 'userId', model.mUserId);
    return ret;
  }

  @override
  DispatchDetailsDto fromMap(Map map) {
    if (map == null) return null;
    final obj = DispatchDetailsDto();
    obj.mColumn = map['column'] as String;
    obj.mSearch = map['search'] as String;
    obj.mSiteId = map['siteId'] as String;
    obj.mGenericDTOList = codeIterable<DispatchListDTO>(
        map['genericDTOList'] as Iterable,
        (val) => _dispatchListDTOSerializer.fromMap(val as Map));
    obj.mTotalPages = map['totalPages'] as int;
    obj.mTotalElements = map['totalElements'] as int;
    obj.mPageSize = map['pageSize'] as int;
    obj.mPageNumber = map['pageNumber'] as int;
    obj.mUserId = map['userId'] as String;
    return obj;
  }
}

abstract class _$DispatchListDTOSerializer
    implements Serializer<DispatchListDTO> {
  Serializer<DispatchDetailsWrapperDTO> __dispatchDetailsWrapperDTOSerializer;
  Serializer<DispatchDetailsWrapperDTO>
      get _dispatchDetailsWrapperDTOSerializer =>
          __dispatchDetailsWrapperDTOSerializer ??=
              DispatchDetailsWrapperDTOSerializer();
  @override
  Map<String, dynamic> toMap(DispatchListDTO model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'packingRef', model.mPackingRef);
    setMapValue(ret, 'destination', model.mDestination);
    setMapValue(ret, 'serviceType', model.mServiceType);
    setMapValue(ret, 'consolidationId', model.mConsolidationId);
    setMapValue(
        ret, 'custRef', codeIterable(model.mCustRef, (val) => val as String));
    setMapValue(ret, 'orderMasterIdList',
        codeIterable(model.mOrderMasterIdList, (val) => val as String));
    setMapValue(ret, 'orderMasterId', model.mOrderMasterId);
    setMapValue(ret, 'actorId', model.mActorId);
    setMapValue(ret, 'actorName', model.mActorName);
    setMapValue(ret, 'destinationId', model.mDestinationId);
    setMapValue(ret, 'deliveryTypesMasterId', model.mDeliveryTypesMasterId);
    setMapValue(ret, 'deliveryId', model.mDeliveryId);
    setMapValue(ret, 'deliveryName', model.mDeliveryName);
    setMapValue(ret, 'courierMasterId', model.mCourierMasterId);
    setMapValue(ret, 'vehicleMasterId', model.mVehicleMasterId);
    setMapValue(ret, 'vehicleNumber', model.mVehicleNumber);
    setMapValue(ret, 'courierName', model.mCourierName);
    setMapValue(ret, 'modeOfTransportMasterId', model.mModeOfTransportMasterId);
    setMapValue(ret, 'address', model.mAddress);
    setMapValue(ret, 'consolidationType', model.mConsolidationType);
    setMapValue(ret, 'dispatchId', model.mDispatchId);
    setMapValue(ret, 'dispatchMappingId', model.mDispatchMappingId);
    setMapValue(ret, 'totalElements', model.mTotalElements);
    setMapValue(ret, 'totalPages', model.mTotalPages);
    setMapValue(ret, 'company', model.mCompany);
    setMapValue(
        ret,
        'dispatchDetailsWrapperDTO',
        codeIterable(
            model.mDispatchDetailsWrapperDTO,
            (val) => _dispatchDetailsWrapperDTOSerializer
                .toMap(val as DispatchDetailsWrapperDTO)));
    setMapValue(ret, 'deliveryTypeId', model.mDeliveryTypeId);
    setMapValue(ret, 'devliverTypeDesc', model.mDevliverTypeDesc);
    setMapValue(ret, 'orderSerialNos',
        codeIterable(model.mOrderSerialNos, (val) => val as String));
    setMapValue(ret, 'finish', model.finish);
    return ret;
  }

  @override
  DispatchListDTO fromMap(Map map) {
    if (map == null) return null;
    final obj = DispatchListDTO(
        getJserDefault('mPackingRef'),
        getJserDefault('mDestination'),
        getJserDefault('mServiceType'),
        getJserDefault('mConsolidationId'),
        getJserDefault('mCustRef'),
        getJserDefault('mOrderMasterIdList'),
        getJserDefault('mOrderMasterId'),
        getJserDefault('mActorId'),
        getJserDefault('mActorName'),
        getJserDefault('mDestinationId'),
        getJserDefault('mDeliveryTypesMasterId'),
        getJserDefault('mDeliveryId'),
        getJserDefault('mDeliveryName'),
        getJserDefault('mCourierMasterId'),
        getJserDefault('mVehicleMasterId'),
        getJserDefault('mVehicleNumber'),
        getJserDefault('mCourierName'),
        getJserDefault('mModeOfTransportMasterId'),
        getJserDefault('mAddress'),
        getJserDefault('mConsolidationType'),
        getJserDefault('mDispatchId'),
        getJserDefault('mDispatchMappingId'),
        getJserDefault('mTotalElements'),
        getJserDefault('mTotalPages'),
        getJserDefault('mCompany'),
        getJserDefault('mDispatchDetailsWrapperDTO'),
        getJserDefault('mDeliveryTypeId'),
        getJserDefault('mDevliverTypeDesc'),
        getJserDefault('finish'));
    obj.mPackingRef = map['packingRef'] as String;
    obj.mDestination = map['destination'] as String;
    obj.mServiceType = map['serviceType'] as String;
    obj.mConsolidationId = map['consolidationId'] as String;
    obj.mCustRef = codeIterable<String>(
        map['custRef'] as Iterable, (val) => val as String);
    obj.mOrderMasterIdList = codeIterable<String>(
        map['orderMasterIdList'] as Iterable, (val) => val as String);
    obj.mOrderMasterId = map['orderMasterId'] as String;
    obj.mActorId = map['actorId'] as String;
    obj.mActorName = map['actorName'] as String;
    obj.mDestinationId = map['destinationId'] as String;
    obj.mDeliveryTypesMasterId = map['deliveryTypesMasterId'] as String;
    obj.mDeliveryId = map['deliveryId'] as String;
    obj.mDeliveryName = map['deliveryName'] as String;
    obj.mCourierMasterId = map['courierMasterId'] as String;
    obj.mVehicleMasterId = map['vehicleMasterId'] as String;
    obj.mVehicleNumber = map['vehicleNumber'] as String;
    obj.mCourierName = map['courierName'] as String;
    obj.mModeOfTransportMasterId = map['modeOfTransportMasterId'] as String;
    obj.mAddress = map['address'] as String;
    obj.mConsolidationType = map['consolidationType'] as int;
    obj.mDispatchId = map['dispatchId'] as String;
    obj.mDispatchMappingId = map['dispatchMappingId'] as String;
    obj.mTotalElements = map['totalElements'] as int;
    obj.mTotalPages = map['totalPages'] as int;
    obj.mCompany = map['company'] as String;
    obj.mDispatchDetailsWrapperDTO = codeIterable<DispatchDetailsWrapperDTO>(
        map['dispatchDetailsWrapperDTO'] as Iterable,
        (val) => _dispatchDetailsWrapperDTOSerializer.fromMap(val as Map));
    obj.mDeliveryTypeId = map['deliveryTypeId'] as String;
    obj.mDevliverTypeDesc = map['devliverTypeDesc'] as String;
    obj.mOrderSerialNos = codeIterable<String>(
        map['orderSerialNos'] as Iterable, (val) => val as String);
    obj.finish = map['finish'] as bool;
    return obj;
  }
}

abstract class _$DispatchDetailsWrapperDTOSerializer
    implements Serializer<DispatchDetailsWrapperDTO> {
  @override
  Map<String, dynamic> toMap(DispatchDetailsWrapperDTO model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'id', model.mId);
    setMapValue(ret, 'soNo', model.mSoNo);
    setMapValue(ret, 'customerName', model.mCustomerName);
    setMapValue(ret, 'orderConsolidationId', model.mOrderConsolidationId);
    setMapValue(ret, 'orderMasterId', model.mOrderMasterId);
    return ret;
  }

  @override
  DispatchDetailsWrapperDTO fromMap(Map map) {
    if (map == null) return null;
    final obj = DispatchDetailsWrapperDTO(
        getJserDefault('mId'),
        getJserDefault('mSoNo'),
        getJserDefault('mCustomerName'),
        getJserDefault('mOrderConsolidationId'),
        getJserDefault('mOrderMasterId'));
    obj.mId = map['id'] as int;
    obj.mSoNo = map['soNo'] as String;
    obj.mCustomerName = map['customerName'] as String;
    obj.mOrderConsolidationId = map['orderConsolidationId'] as String;
    obj.mOrderMasterId = map['orderMasterId'] as int;
    return obj;
  }
}
