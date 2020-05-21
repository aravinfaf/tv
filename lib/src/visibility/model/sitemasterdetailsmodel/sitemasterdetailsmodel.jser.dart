// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sitemasterdetailsmodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$SiteMasterDetailsModelSerializer
    implements Serializer<SiteMasterDetailsModel> {
  @override
  Map<String, dynamic> toMap(SiteMasterDetailsModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'company', model.mCompany);
    return ret;
  }

  @override
  SiteMasterDetailsModel fromMap(Map map) {
    if (map == null) return null;
    final obj = SiteMasterDetailsModel();
    obj.mCompany = map['company'] as String;
    return obj;
  }
}
