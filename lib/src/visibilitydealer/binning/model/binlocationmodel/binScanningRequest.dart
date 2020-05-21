

import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'binScanningRequest.jser.dart';

class BinScanningRequest{

  @Alias("binLabel")
  String mBinLabel;

  @Alias("binStatus")
  int mBinStatus;

  @Alias("binId")
  String mBinId;

  @Alias("orderId")
  String mOrderId;

  @Alias("partNumber")
  String mPartNumber;

  @Alias("partSerialNo")
  String mPartSerialNo;

  @Alias("partsinOrderId")
  String mPartsInOrderId;

  @Alias("proceedExcessOrShort")
  int mProceedExcessOrShort;

  @Alias("quantity")
  int mQuantity;

  @Alias("remainingQty")
  int mRemainingQty;

  @Alias("scanText")
  String mScanText;

  @Alias("siteMasterId")
  String mSiteMasterId;

  @Alias("wareHouseMatInboundId")
  String mWareHouseMatInboundId;

  BinScanningRequest({this.mBinLabel, this.mBinStatus, this.mBinId,
    this.mOrderId, this.mPartNumber, this.mPartSerialNo, this.mPartsInOrderId,
    this.mProceedExcessOrShort, this.mQuantity, this.mRemainingQty,
    this.mScanText, this.mSiteMasterId, this.mWareHouseMatInboundId});

}

@GenSerializer()
class BinScanningRequestSerializer extends Serializer<BinScanningRequest> with

    _$BinScanningRequestSerializer{}