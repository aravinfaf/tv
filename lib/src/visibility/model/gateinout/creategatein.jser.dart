// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creategatein.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$CreateGateInModelSerilizer
    implements Serializer<CreateGateInModel> {
  @override
  Map<String, dynamic> toMap(CreateGateInModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'driverName', model.driverName);
    setMapValue(ret, 'phonenumber', model.phonenumber);
    setMapValue(ret, 'siteMasterId', model.siteMasterId);
    setMapValue(ret, 'vehNumber', model.vehNumber);
    setMapValue(ret, 'vehicleInTime', model.vehicleInTime);
    setMapValue(ret, 'workFlowTenantId', model.workFlowTenantId);
    return ret;
  }

  @override
  CreateGateInModel fromMap(Map map) {
    if (map == null) return null;
    final obj = CreateGateInModel();
    obj.driverName = map['driverName'] as String;
    obj.phonenumber = map['phonenumber'] as int;
    obj.siteMasterId = map['siteMasterId'] as String;
    obj.vehNumber = map['vehNumber'] as String;
    obj.vehicleInTime = map['vehicleInTime'] as String;
    obj.workFlowTenantId = map['workFlowTenantId'] as String;
    return obj;
  }
}
