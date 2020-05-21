import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'creategatein.jser.dart';

@GenSerializer()
class CreateGateInModelSerilizer extends Serializer<CreateGateInModel>
    with _$CreateGateInModelSerilizer {}

class CreateGateInModel {
  String driverName;
  int phonenumber;
  String siteMasterId;
  String vehNumber;
  String vehicleInTime;
  String workFlowTenantId;  

  CreateGateInModel(
      {this.driverName,
      this.phonenumber,
      this.siteMasterId,
      this.vehNumber,
      this.vehicleInTime,
      this.workFlowTenantId});

  Map<String, dynamic> toJson() => serializer.toMap(this);

  static final serializer = CreateGateInModelSerilizer();
  static CreateGateInModel fromMap(Map map) => serializer.fromMap(map);

  String toString() => toJson().toString();
}
