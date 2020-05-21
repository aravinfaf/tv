import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'binmasterdetailsmodel.jser.dart';

class BinMasterDetailsModel{
  @Alias("binId")
  String mBinId;
  @Alias("binLabel")
  String mBinLabel;
  @Alias("binLocation")
  String mBinLocation;
  @Alias("partMasterId")
  String mPartMasterId;
  @Alias("serialNum")
  String mSerialNum;
  @Alias("siteMasterId")
  String mSiteMasterId;
  @Alias("statusMasterId")
  int mStatusMasterId;
  @Alias("wareHouseMatInboundId")
  String mWareHouseMatInboundId;
  @Ignore()
  bool mError=false;


}

@GenSerializer()
class BinMasterDetailsModelSerializer extends Serializer<BinMasterDetailsModel>
    with _$BinMasterDetailsModelSerializer {}