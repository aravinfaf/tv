import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'binsavepart.jser.dart';

class BinSavePart {
  @Alias("accountsMasterId")
  String mAccountsMasterId;
  @Alias("binMasterId")
  String mBinMasterId;
  @Alias("binsMasterId")
  String mBinsMasterId;
  @Alias("binTypeId")
  int mBinTypeId;
  @Alias("damagedQty")
  int mDamagedQty;
  @Alias("isFirstScan")
  bool mFirstScan;
  @Alias("isGoodBin")
  bool mGoodBin;
  @Alias("ordersMasterId")
  String mOrdersMasterId;
  @Alias("partsInOrderId")
  String mPartsInOrderId;
  @Alias("partsMasterId")
  String mPartsMasterId;
  @Alias("scanNumber")
  String mScanNumber;
  @Alias("shortReceived")
  int mShortReceived;
  @Alias("siteMasterId")
  String mSiteMasterId;
  @Alias("taskInstanceId")
  String mTaskInstanceId;
  @Alias("vPartQuantity")
  String mVPartQuantity;
  @Alias("vTypeQuantity")
  int mVTypeQuantity;
  @Alias("vpartsExistQty")
  int mVPartsExistQty;
  @Alias("warehouseMatInboundId")
  String mWarehouseMatInboundId;
  @Alias("binnedDate")
  String mBinnedDate;
  @Alias("clientExcessOrShortStatus")
  int mClientExcessOrShortStatus;
  @Alias("requestorUserId")
  String mRequestorUserId;
  @Alias("userId")
  String mUserId;
  @Alias("tenantId")
  String mTenantId;
  @Alias("siteId")
  String mSiteId;

  BinSavePart(
      {this.mAccountsMasterId,
        this.mBinMasterId,
        this.mBinsMasterId,
        this.mBinTypeId,
        this.mDamagedQty,
        this.mFirstScan,
        this.mGoodBin,
        this.mOrdersMasterId,
        this.mPartsInOrderId,
        this.mPartsMasterId,
        this.mScanNumber,
        this.mShortReceived,
        this.mSiteMasterId,
        this.mTaskInstanceId,
        this.mVPartQuantity,
        this.mVTypeQuantity,
        this.mVPartsExistQty,
        this.mWarehouseMatInboundId,
        this.mClientExcessOrShortStatus,
        this.mRequestorUserId,
        this.mUserId,
        this.mSiteId,
        this.mBinnedDate});

}

@GenSerializer()
class BinSavePartSerializer extends Serializer<BinSavePart> with _$BinSavePartSerializer {}
