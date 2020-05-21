import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'PickingExcessMasterMapping.jser.dart';

@GenSerializer()
class ExcessMasterMappingSerilizer extends Serializer<ExcessMasterMapping>
    with _$ExcessMasterMappingSerilizer {}

class ExcessMasterMapping {
  String excessMasterId;
  String id;
  String serialNumber;

  ExcessMasterMapping({
    this.id,
    this.serialNumber,
    this.excessMasterId,
  });
}
