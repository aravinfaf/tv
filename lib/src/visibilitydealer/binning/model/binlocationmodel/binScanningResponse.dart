

import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'binScanningResponse.jser.dart';

class BinScanningResponse{

  @Alias("binLocation")
  String mBinLocation;

  @Alias("binLabel")
  String mBinLabel;

  @Alias("binId")
  String mBinId;

  @Alias("orderId")
  String mOrderId;

  @Alias("partsinOrderId")
  String mPartsInOrderId;

  @Alias("partMasterId")
  String mPartMasterId;

  @Alias("partTypeCode")
  String mPartTypeCode;

  @Alias("serialNum")
  String mSerialNum;

  @Alias("wareHouseMatInboundId")
  String mWareHouseMatInboundId;

  @Alias("remainingQty")
  int mRemainingQty;

  @Alias("customerLabel")
  bool mCustomerLabel;

  @Alias("message")
  String mMessage;

  @Alias("customerRef")
  String mCustomerRef;

  @Alias("partNumber")
  String mPartNumber;

  @Alias("binnedQty")
  int mBinnedQty;

  @Alias("partsTotalQty")
  int mPartsTotalQty;

  @Alias("binStatus")
  int mBinStatus;

  BinScanningResponse({this.mBinLocation, this.mBinLabel, this.mBinId,
      this.mOrderId, this.mPartsInOrderId, this.mPartMasterId,
      this.mPartTypeCode, this.mSerialNum, this.mWareHouseMatInboundId,
      this.mRemainingQty, this.mCustomerLabel, this.mMessage, this.mCustomerRef,
      this.mPartNumber, this.mBinnedQty, this.mPartsTotalQty, this.mBinStatus});

}

@GenSerializer()
class BinScanningResponseSerializer extends Serializer<BinScanningResponse> with

_$BinScanningResponseSerializer{}


