import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'despatchdetailstatusmodel.jser.dart';

@GenSerializer()
class DespatchDetailStatusSerializer extends Serializer<DespatchDetailStatus>
    with _$DespatchDetailStatusSerializer {}

class DespatchDetailStatus {
  @Alias("totalDespatchCartons")
  int mTotalDespatchCartons;
  @Alias("scannedDespatchCartons")
  int mScannedDespatchCartons;
  @Alias("statusCode")
  int mStatusCode;
  @Alias("totalPickedLPN")
  int mTotalPickedLPN;
  @Alias("totalScannedLPN")
  int mTotalScannedLPN;
  @Alias("totalUnconsolidatedLPN")
  int mTotalUnconsolidatedLPN;
  @Alias("totalScannedUnconsolidatedLPN")
  int mTotalScannedUnconsolidatedLPN;
  @Alias("orderList")
  List<String> mOrderList=[];

  DespatchDetailStatus({this.mTotalDespatchCartons, this.mScannedDespatchCartons,
      this.mStatusCode, this.mTotalPickedLPN, this.mTotalScannedLPN,
      this.mTotalUnconsolidatedLPN, this.mTotalScannedUnconsolidatedLPN,
      this.mOrderList});


}
