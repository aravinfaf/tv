import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'PickingResult.jser.dart';

@GenSerializer()
class PickScanningResultSerializer extends Serializer<PickScanningResult>
    with _$PickScanningResultSerializer {}

class PickScanningResult {
  int status;
  int remainingQuantity;
  int alteredQauntity;
  int missingQuantity;
  String currentBin;
  int currentBinQuantity;
  List<int> allowedQty;

  PickScanningResult(
      {this.currentBinQuantity,
      this.currentBin,
      this.status,
      this.alteredQauntity,
      this.missingQuantity,
      this.remainingQuantity,
        this.allowedQty});
}
