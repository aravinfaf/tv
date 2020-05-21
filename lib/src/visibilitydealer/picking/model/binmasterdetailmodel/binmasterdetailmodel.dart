import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'binmasterdetailmodel.jser.dart';

class BinMasterDetailModel{
  @Alias("binLable")
  String mBinLabel;
  @Alias("binLocation")
  String mBinLocation;
  @Alias("quantity")
  int mQuantity;
  @Ignore()
  bool mError=false;

}

@GenSerializer()
class BinMasterDetailModelSerializer extends Serializer<BinMasterDetailModel> with _$BinMasterDetailModelSerializer{}


