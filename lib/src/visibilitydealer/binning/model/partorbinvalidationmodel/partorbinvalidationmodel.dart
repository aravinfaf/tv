import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'partorbinvalidationmodel.jser.dart';

class PartOrBinValidationModel{
  @Alias('binLocation')
  String mBinLocation;
  @Alias('binLabel')
  String mBinLabel;
  @Alias('binId')
  String mBinId;
  @Alias('partMasterId')
  String mPartMasterId;
  @Alias('partTypeCode')
  String mPartTypeCode;
  @Alias('serialNum')
  String mSerialNum;
  @Alias('remainingQty')
  int mRemainingQty;
  @Alias('partsinOrderId')
  String mPartsInOrderId;
  @Alias('scanText')
  String mScanText;
  @Alias('siteMasterId')
  String mSiteMasterId;
  @Alias('orderId')
  String mOrderId;
  @Alias('partNumber')
  String mPartNumber;
  @Ignore()
  bool mError=false;

}

@GenSerializer()
class PartOrBinValidationModelSerializer extends Serializer<PartOrBinValidationModel> with _$PartOrBinValidationModelSerializer{}
