import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:tvs_visibility/src/visibility/model/binsmasterdto/binsmasterdto.dart';
import 'package:tvs_visibility/src/visibility/model/partsmasterdto/partsmasterdto.dart';

part 'binvalidationresult.jser.dart';

class BinValidationResult {
  @Alias("binTypeId")
  int mBinTypeId;
  @Alias("binsMasterDTO")
  BinsMasterDTO mBinsMasterDTO;
  @Alias("partsMasterDTO")
  PartsMasterDTO mPartsMasterDTO;
  @Alias("serialNumber")
  String mSerialNumber;
  @Alias("statusCode")
  int mStatusCode;
  @Alias("vpartsExistQty")
  int mVPartsExistQty;
  @Alias("wareHouseMatId")
  String mWareHouseMatId;
  @Alias("partsInorderId")
  String mPartsInorderId;
  @Alias("orderId")
  String mOrderId;
  @Alias("partId")
  String mPartId;
  @Alias("totalQuantity")
  int mTotalQuantity;
  @Alias("customerReference")
  String mCustomerReference;
  @Alias("partNumber")
  String mPartNumber;
  @Alias("binnedQuantity")
  int mBinnedQuantity;

  BinValidationResult(
      {this.mBinTypeId,
      this.mBinsMasterDTO,
      this.mPartsMasterDTO,
      this.mSerialNumber,
      this.mStatusCode,
      this.mVPartsExistQty,
      this.mWareHouseMatId});
}

@GenSerializer()
class BinValidationResultSerializer extends Serializer<BinValidationResult>
    with _$BinValidationResultSerializer {}

