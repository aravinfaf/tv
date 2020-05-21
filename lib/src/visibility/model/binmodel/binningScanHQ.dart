import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:tvs_visibility/src/visibility/model/binsmasterdto/binsmasterdto.dart';
part 'binningScanHQ.jser.dart';




class BinningScanHQ{
  @Alias("binTypeId")
  String mBinTypeId;
  @Alias("binsMasterDTO")
  BinsMasterDTO mBinsMasterDTO;
  @Alias("binsMasterId")
  String mBinsMasterId;
  @Alias("isQuantityReq")
  bool mQuantityReq;
  @Alias("isVpart")
  bool mVPart;
  @Alias("orderMasterId")
  String mOrderMasterId;
  @Alias("partsConvertable")
  bool mPartsConvertable;
  @Alias("partsInOrderId")
  String mPartsInOrderId;
  @Alias("partsMasterId")
  String mPartsMasterId;
  @Alias("serialNumber")
  String mSerialNumber;
  @Alias("siteMasterId")
  String mSiteMasterId;
  @Alias("statusCode")
  int mStatusCode;
  @Alias("stockTypeMasterId")
  String mStockTypeMasterId;
  @Alias("vpartsExistQty")
  int mVPartsExistQty;
  @Alias("taskInstanceId")
  String mTaskInstanceId;
  @Alias("accountsMasterId")
  String mAccountsMasterId;


  BinningScanHQ({this.mBinTypeId, this.mBinsMasterDTO, this.mBinsMasterId,
      this.mQuantityReq, this.mVPart, this.mOrderMasterId,
      this.mPartsConvertable, this.mPartsInOrderId, this.mPartsMasterId,
      this.mSerialNumber, this.mSiteMasterId, this.mStatusCode,
      this.mStockTypeMasterId, this.mVPartsExistQty,this.mTaskInstanceId, this.mAccountsMasterId});


}

@GenSerializer()
class BinningScanHQSerializer extends Serializer<BinningScanHQ> with _$BinningScanHQSerializer {}