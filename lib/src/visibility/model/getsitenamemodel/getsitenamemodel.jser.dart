// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getsitenamemodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$GetSiteNameModelSerializer
    implements Serializer<GetSiteNameModel> {
  Serializer<SiteMasterDetailsModel> __siteMasterDetailsModelSerializer;
  Serializer<SiteMasterDetailsModel> get _siteMasterDetailsModelSerializer =>
      __siteMasterDetailsModelSerializer ??= SiteMasterDetailsModelSerializer();
  @override
  Map<String, dynamic> toMap(GetSiteNameModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(
        ret,
        'siteMasterDTOList',
        codeIterable(
            model.siteMasterDetails,
            (val) => _siteMasterDetailsModelSerializer
                .toMap(val as SiteMasterDetailsModel)));
    return ret;
  }

  @override
  GetSiteNameModel fromMap(Map map) {
    if (map == null) return null;
    final obj = GetSiteNameModel();
    obj.siteMasterDetails = codeIterable<SiteMasterDetailsModel>(
        map['siteMasterDTOList'] as Iterable,
        (val) => _siteMasterDetailsModelSerializer.fromMap(val as Map));
    return obj;
  }
}
