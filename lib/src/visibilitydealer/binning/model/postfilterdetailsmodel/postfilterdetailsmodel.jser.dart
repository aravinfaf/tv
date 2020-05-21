// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postfilterdetailsmodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$PostFilterDetailsModelSerializer
    implements Serializer<PostFilterDetailsModel> {
  @override
  Map<String, dynamic> toMap(PostFilterDetailsModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'searchText', model.mSearchText);
    setMapValue(ret, 'searchColumn', model.mSearchColumn);
    setMapValue(ret, 'siteId', model.mSiteId);
    setMapValue(ret, 'userId', model.mUserId);
    setMapValue(ret, 'search', model.mSearch);
    setMapValue(ret, 'pageNumber', model.mPageNumber);
    setMapValue(ret, 'pageSize', model.mPageSize);
    return ret;
  }

  @override
  PostFilterDetailsModel fromMap(Map map) {
    if (map == null) return null;
    final obj = PostFilterDetailsModel();
    obj.mSearchText = map['searchText'] as String;
    obj.mSearchColumn = map['searchColumn'] as String;
    obj.mSiteId = map['siteId'] as String;
    obj.mUserId = map['userId'] as String;
    obj.mSearch = map['search'] as bool;
    obj.mPageNumber = map['pageNumber'] as String;
    obj.mPageSize = map['pageSize'] as String;
    return obj;
  }
}
