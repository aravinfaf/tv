import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'binmasterdetailsrequestmodel.jser.dart';

class BinMasterDetailsRequestModel{
  @Alias("scanText")
  String mScanText;
  @Alias("binsMasterId")
  String mBinsMasterId;
  @Alias("siteMasterId")
  String mSiteMasterId;
  @Ignore()
  bool mError=false;

}

@GenSerializer()
class BinMasterDetailsRequestModelSerializer extends Serializer<BinMasterDetailsRequestModel>
    with _$BinMasterDetailsRequestModelSerializer {}