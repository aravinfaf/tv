// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postbinningfiltermodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$PostBinningFilterModelSerializer
    implements Serializer<PostBinningFilterModel> {
  Serializer<BinningListModel> __binningListModelSerializer;
  Serializer<BinningListModel> get _binningListModelSerializer =>
      __binningListModelSerializer ??= BinningListModelSerializer();
  @override
  Map<String, dynamic> toMap(PostBinningFilterModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'column', model.mColumn);
    setMapValue(ret, 'search', model.mSearch);
    setMapValue(ret, 'siteId', model.mSiteId);
    setMapValue(ret, 'statusMasterId', model.mStatusMasterId);
    setMapValue(ret, 'totalPages', model.mTotalPages);
    setMapValue(
        ret,
        'genericDTOList',
        codeIterable(
            model.mBinningListModel,
            (val) =>
                _binningListModelSerializer.toMap(val as BinningListModel)));
    setMapValue(ret, 'totalElements', model.mTotalElements);
    setMapValue(ret, 'pageSize', model.mPageSize);
    setMapValue(ret, 'pageNumber', model.mPageNumber);
    setMapValue(ret, 'userid', model.mUserid);
    setMapValue(ret, 'pickerId', model.mPickerId);
    setMapValue(ret, 'customerref', model.mCustomerref);
    setMapValue(ret, 'paged', model.mPaged);
    return ret;
  }

  @override
  PostBinningFilterModel fromMap(Map map) {
    if (map == null) return null;
    final obj = PostBinningFilterModel();
    obj.mColumn = map['column'] as String;
    obj.mSearch = map['search'] as String;
    obj.mSiteId = map['siteId'] as String;
    obj.mStatusMasterId = map['statusMasterId'] as String;
    obj.mTotalPages = map['totalPages'] as int;
    obj.mBinningListModel = codeIterable<BinningListModel>(
        map['genericDTOList'] as Iterable,
        (val) => _binningListModelSerializer.fromMap(val as Map));
    obj.mTotalElements = map['totalElements'] as int;
    obj.mPageSize = map['pageSize'] as int;
    obj.mPageNumber = map['pageNumber'] as int;
    obj.mUserid = map['userid'] as String;
    obj.mPickerId = map['pickerId'] as String;
    obj.mCustomerref = map['customerref'] as String;
    obj.mPaged = map['paged'] as bool;
    return obj;
  }
}
