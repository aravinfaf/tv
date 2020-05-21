import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'scandespatchmodel.jser.dart';

class ScanDespatchModel {
  @Alias("id")
  String mId;
  @Alias("mappingId")
  String mMappingId;
  @Alias("actorType")
  String mActorType;
  @Alias("deliveryTo")
  String mDeliveryTo;
  @Alias("address")
  String mAddress;
  @Alias("company")
  String mCompany;
  @Alias("deliveryTypesMasterId")
  String mDeliveryTypesMasterId;
  @Alias("consolidationId")
  String mConsolidationId;
  @Alias("modeOfTransport")
  String mModeOfTransport;
  @Alias("vehicleNum")
  String mVehicleNum;
  @Alias("courierName")
  String mCourierName;
  @Alias("orderId")
  String mOrderId;
  @Alias("consolidationTypeId")
  int mConsolidationTypeId;
  @Alias("orderIdList")
  List<String> mOrderIdList;
  @Alias("scanNumber")
  String mScanNumber;
  @Alias("userId")
  String mUserId;

  ScanDespatchModel(
      {this.mId,
      this.mMappingId,
      this.mActorType,
      this.mDeliveryTo,
      this.mAddress,
      this.mCompany,
      this.mDeliveryTypesMasterId,
      this.mConsolidationId,
      this.mModeOfTransport,
      this.mVehicleNum,
      this.mCourierName,
      this.mOrderId,
      this.mConsolidationTypeId,
      this.mOrderIdList,
      this.mScanNumber,
      this.mUserId});
}

@GenSerializer()
class ScanDespatchModelSerializer extends Serializer<ScanDespatchModel>
    with _$ScanDespatchModelSerializer {}
