import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'vpartspostresponsemodel.jser.dart';

@GenSerializer()
class VPartsPostResponseModelSerializer extends Serializer<VPartsPostResponseModel>
    with _$VPartsPostResponseModelSerializer {}

class VPartsPostResponseModel{
  @Alias("statusCode")
  int mStatusCode;
  @Alias("binnedQuantity")
  int mBinnedQuantity;
  @Alias("totalQuantity")
  int mTotalQuantity;

}