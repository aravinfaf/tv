import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'PickingAlternateLocationResult.jser.dart';
@GenSerializer()
class AlternateLocationResultSerializer extends Serializer<AlternateLocationResult>
    with _$AlternateLocationResultSerializer {}

class AlternateLocationResult {
  int status;
  int requestedQuantity;
  int availableQuantity;
  String alternateLocation;
  String currentBin;
  int currentBinQuantity;


  AlternateLocationResult({
    this.status,
    this.requestedQuantity,
    this.alternateLocation,
    this.availableQuantity,
    this.currentBin,
    this.currentBinQuantity,

});
}