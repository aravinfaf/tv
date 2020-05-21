import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'bininfodetailsmodel.jser.dart';

class BinInfoDetailsModel{
  @Alias("binMasterLabel")
  String mBinMasterLabel;
  @Alias("lpnNo")
  String mLPNNo;
  @Alias("quantity")
  int mQuantity;
  @Alias("statusCodeId")
  String mStatus;
  @Ignore()
  bool mError=false;

}

@GenSerializer()
class BinInfoDetailsModelSerializer extends Serializer<BinInfoDetailsModel> with _$BinInfoDetailsModelSerializer {}