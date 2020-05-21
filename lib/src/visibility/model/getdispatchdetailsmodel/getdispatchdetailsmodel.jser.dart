// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getdispatchdetailsmodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$GetDispatchDetailsModelSerializer
    implements Serializer<GetDispatchDetailsModel> {
  Serializer<EndCustomerDetailModel> __endCustomerDetailModelSerializer;
  Serializer<EndCustomerDetailModel> get _endCustomerDetailModelSerializer =>
      __endCustomerDetailModelSerializer ??= EndCustomerDetailModelSerializer();
  @override
  Map<String, dynamic> toMap(GetDispatchDetailsModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(
        ret,
        'endCustomerDTOList',
        codeIterable(
            model.mEndCustomerList,
            (val) => _endCustomerDetailModelSerializer
                .toMap(val as EndCustomerDetailModel)));
    setMapValue(
        ret,
        'engineerMasterDTOList',
        codeIterable(
            model.mEngineerMasterDTOList,
            (val) => _endCustomerDetailModelSerializer
                .toMap(val as EndCustomerDetailModel)));
    setMapValue(
        ret,
        'siteMasterDTOList',
        codeIterable(
            model.mSiteMasterDetailsModel,
            (val) => _endCustomerDetailModelSerializer
                .toMap(val as EndCustomerDetailModel)));
    return ret;
  }

  @override
  GetDispatchDetailsModel fromMap(Map map) {
    if (map == null) return null;
    final obj = GetDispatchDetailsModel();
    obj.mEndCustomerList = codeIterable<EndCustomerDetailModel>(
        map['endCustomerDTOList'] as Iterable,
        (val) => _endCustomerDetailModelSerializer.fromMap(val as Map));
    obj.mEngineerMasterDTOList = codeIterable<EndCustomerDetailModel>(
        map['engineerMasterDTOList'] as Iterable,
        (val) => _endCustomerDetailModelSerializer.fromMap(val as Map));
    obj.mSiteMasterDetailsModel = codeIterable<EndCustomerDetailModel>(
        map['siteMasterDTOList'] as Iterable,
        (val) => _endCustomerDetailModelSerializer.fromMap(val as Map));
    return obj;
  }
}
