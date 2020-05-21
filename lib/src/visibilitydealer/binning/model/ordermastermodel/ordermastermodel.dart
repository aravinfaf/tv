import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'ordermastermodel.jser.dart';

class OrderMasterModel {
  @Alias("id")
  String mId;
  @Alias("customerReference")
  String mCustomerRef;
  @Alias("totalPartQuantity")
  int mTotalOrderQuantity;
  @Alias("totalBinnedQuantity")
  int mTotalBinnedQuantity;
  @Alias("partNumber")
  String mPartNumber;
  @Alias("partsInOrderId")
  String mPartsInOrderId;
  @Alias("partTypeCode")
  String mPartTypeCode;
  @Ignore()
  bool mError=false;

}

@GenSerializer()
class OrderMasterModelSerializer extends Serializer<OrderMasterModel> with _$OrderMasterModelSerializer{}

