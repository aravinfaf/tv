import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'postbindetailsmodel.jser.dart';

class PostBinDetailsModel{
  @Alias("scanText")
  String scanText;
  @Alias("binLabel")
  String binLabel;
  @Alias("partSerialNo")
  String partSerialNo;
  @Alias("quantity")
  int quantity;
  @Alias("orderId")
  String orderId;
  @Alias("binStatus")
  int binStatus;
  @Alias("remainingQty")
  int remainingQty;
  @Alias("proceedExcessOrShort")
  int proceedExcessOrShort;
  @Alias("siteMasterId")
  String mSiteMasterId;
  @Alias("partsinOrderId")
  String mPartsInOrderId;
  @Ignore()
  bool mError=false;

  PostBinDetailsModel({this.scanText, this.binLabel,
      this.partSerialNo, this.quantity, this.orderId, this.binStatus,
      this.remainingQty, this.proceedExcessOrShort,this.mPartsInOrderId});


}

@GenSerializer()
class PostBinDetailsModelSerializer extends Serializer<PostBinDetailsModel> with _$PostBinDetailsModelSerializer{}
