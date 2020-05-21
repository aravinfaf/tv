// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postpartmasterdetailsmodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$PostPartMasterDetailsModelSerializer
    implements Serializer<PostPartMasterDetailsModel> {
  Serializer<BinMasterDetailModel> __binMasterDetailModelSerializer;
  Serializer<BinMasterDetailModel> get _binMasterDetailModelSerializer =>
      __binMasterDetailModelSerializer ??= BinMasterDetailModelSerializer();
  @override
  Map<String, dynamic> toMap(PostPartMasterDetailsModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'siteId', model.mSiteId);
    setMapValue(ret, 'quantity', model.mQuantity);
    setMapValue(ret, 'partMasterId', model.mPartMasterId);
    setMapValue(ret, 'partNumber', model.mPartMaster);
    setMapValue(ret, 'partSerialNo', model.mPartSerialNo);
    setMapValue(
        ret,
        'partPickingDto',
        codeIterable(
            model.mBinMasterDetailList,
            (val) => _binMasterDetailModelSerializer
                .toMap(val as BinMasterDetailModel)));
    return ret;
  }

  @override
  PostPartMasterDetailsModel fromMap(Map map) {
    if (map == null) return null;
    final obj = PostPartMasterDetailsModel();
    obj.mSiteId = map['siteId'] as String;
    obj.mQuantity = map['quantity'] as int;
    obj.mPartMasterId = map['partMasterId'] as String;
    obj.mPartMaster = map['partNumber'] as String;
    obj.mPartSerialNo = map['partSerialNo'] as String;
    obj.mBinMasterDetailList = codeIterable<BinMasterDetailModel>(
        map['partPickingDto'] as Iterable,
        (val) => _binMasterDetailModelSerializer.fromMap(val as Map));
    return obj;
  }
}
