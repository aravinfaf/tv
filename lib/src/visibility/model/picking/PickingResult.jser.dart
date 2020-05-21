// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PickingResult.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$PickScanningResultSerializer
    implements Serializer<PickScanningResult> {
  @override
  Map<String, dynamic> toMap(PickScanningResult model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'status', model.status);
    setMapValue(ret, 'remainingQuantity', model.remainingQuantity);
    setMapValue(ret, 'alteredQauntity', model.alteredQauntity);
    setMapValue(ret, 'missingQuantity', model.missingQuantity);
    setMapValue(ret, 'currentBin', model.currentBin);
    setMapValue(ret, 'currentBinQuantity', model.currentBinQuantity);
    setMapValue(
        ret, 'allowedQty', codeIterable(model.allowedQty, (val) => val as int));
    return ret;
  }

  @override
  PickScanningResult fromMap(Map map) {
    if (map == null) return null;
    final obj = PickScanningResult();
    obj.status = map['status'] as int;
    obj.remainingQuantity = map['remainingQuantity'] as int;
    obj.alteredQauntity = map['alteredQauntity'] as int;
    obj.missingQuantity = map['missingQuantity'] as int;
    obj.currentBin = map['currentBin'] as String;
    obj.currentBinQuantity = map['currentBinQuantity'] as int;
    obj.allowedQty =
        codeIterable<int>(map['allowedQty'] as Iterable, (val) => val as int);
    return obj;
  }
}
