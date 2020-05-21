// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preBinningRequestModel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$PreBinningRequestModelSerializer
    implements Serializer<PreBinningRequestModel> {
  @override
  Map<String, dynamic> toMap(PreBinningRequestModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'column', model.column);
    setMapValue(ret, 'search', model.search);
    setMapValue(ret, 'pageSize', model.pageSize);
    setMapValue(ret, 'pageNumber', model.pageNumber);
    setMapValue(ret, 'taskkey', model.taskkey);
    return ret;
  }

  @override
  PreBinningRequestModel fromMap(Map map) {
    if (map == null) return null;
    final obj = PreBinningRequestModel();
    obj.column = map['column'] as String;
    obj.search = map['search'] as String;
    obj.pageSize = map['pageSize'] as int;
    obj.pageNumber = map['pageNumber'] as int;
    obj.taskkey = map['taskkey'] as String;
    return obj;
  }
}
