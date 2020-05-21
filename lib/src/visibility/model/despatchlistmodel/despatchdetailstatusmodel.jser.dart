// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'despatchdetailstatusmodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$DespatchDetailStatusSerializer
    implements Serializer<DespatchDetailStatus> {
  @override
  Map<String, dynamic> toMap(DespatchDetailStatus model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'totalDespatchCartons', model.mTotalDespatchCartons);
    setMapValue(ret, 'scannedDespatchCartons', model.mScannedDespatchCartons);
    setMapValue(ret, 'statusCode', model.mStatusCode);
    setMapValue(ret, 'totalPickedLPN', model.mTotalPickedLPN);
    setMapValue(ret, 'totalScannedLPN', model.mTotalScannedLPN);
    setMapValue(ret, 'totalUnconsolidatedLPN', model.mTotalUnconsolidatedLPN);
    setMapValue(ret, 'totalScannedUnconsolidatedLPN',
        model.mTotalScannedUnconsolidatedLPN);
    setMapValue(ret, 'orderList',
        codeIterable(model.mOrderList, (val) => val as String));
    return ret;
  }

  @override
  DespatchDetailStatus fromMap(Map map) {
    if (map == null) return null;
    final obj = DespatchDetailStatus();
    obj.mTotalDespatchCartons = map['totalDespatchCartons'] as int;
    obj.mScannedDespatchCartons = map['scannedDespatchCartons'] as int;
    obj.mStatusCode = map['statusCode'] as int;
    obj.mTotalPickedLPN = map['totalPickedLPN'] as int;
    obj.mTotalScannedLPN = map['totalScannedLPN'] as int;
    obj.mTotalUnconsolidatedLPN = map['totalUnconsolidatedLPN'] as int;
    obj.mTotalScannedUnconsolidatedLPN =
        map['totalScannedUnconsolidatedLPN'] as int;
    obj.mOrderList = codeIterable<String>(
        map['orderList'] as Iterable, (val) => val as String);
    return obj;
  }
}
