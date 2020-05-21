import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'partserialnumberdetailsmodel.jser.dart';

class PartSerialNumberDetailsModel{
  @Alias("binLabel")
  String mBinLabel;
  @Alias("partMasterId")
  String mPartMasterId;
  @Alias("partNumber")
  String mPartNumber;
  @Alias("partSerialNo")
  String mPartSerialNo;
  @Alias("partTypeCode")
  String mPartTypeCode;
  @Alias("partTypeId")
  String mPartTypeId;
  @Alias("pickQty")
  int mPickQty;
  @Alias("pickStatus")
  int mPickStatus;
  @Alias("randomPickStatus")
  int mRandomPickStatus;
  @Alias("siteMasterId")
  String mSiteMasterId;
  @Alias("serialNumber")
  String mScanText;
  @Alias("quantity")
  int mQuantity;
  @Ignore()
  bool mError=false;

}

@GenSerializer()
class PartSerialNumberDetailsModelSerializer extends Serializer<PartSerialNumberDetailsModel> with _$PartSerialNumberDetailsModelSerializer{}


