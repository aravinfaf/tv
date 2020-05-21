import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'postdispatchmasterdetailsmodel.jser.dart';

class PostDispatchMasterDetailsModel{
  @Alias("binLabel")
  String mBinLabel;
  @Alias("delivaryTypeMasterId")
  String mDeliveryTypeMasterId;
  @Alias("despatchMobile")
  String mDespatchMobile;
  @Alias("despatchName")
  String mDespatchName;
  @Alias("orderId")
  String mOrderId;
  @Alias("partMasterId")
  String mPartMasterId;
  @Alias("partSerialNo")
  String mPartSerialNo;
  @Alias("partNumber")
  String mPartNumber;
  @Alias("pickQty")
  int mPickQty;
  @Alias("siteMasterId")
  String mSiteMasterId;
  @Ignore()
  int mReqQty;
  @Ignore()
  bool mError=false;

  PostDispatchMasterDetailsModel({ this.mBinLabel,this.mPartNumber,
      this.mDeliveryTypeMasterId, this.mDespatchMobile, this.mDespatchName,
      this.mOrderId, this.mPartMasterId, this.mPartSerialNo, this.mPickQty,this.mSiteMasterId,this.mReqQty});

}

@GenSerializer()
class PostDispatchMasterDetailsModelSerializer extends Serializer<PostDispatchMasterDetailsModel> with _$PostDispatchMasterDetailsModelSerializer{}
