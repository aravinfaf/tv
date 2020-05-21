// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partsmasterdto.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$PartsMasterDTOSerializer
    implements Serializer<PartsMasterDTO> {
  @override
  Map<String, dynamic> toMap(PartsMasterDTO model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'accountGroupMasterId', model.mAccountGroupMasterId);
    setMapValue(
        ret, 'accountGroupMasterIdName', model.mAccountGroupMasterIdName);
    setMapValue(ret, 'accountGrpName', model.mAccountGrpName);
    setMapValue(ret, 'accountMasterId', model.mAccountMasterId);
    setMapValue(ret, 'accountMasterIdName', model.mAccountMasterIdName);
    setMapValue(ret, 'auditFrequency', model.mAuditFrequency);
    setMapValue(ret, 'batchNo', model.mBatchNo);
    setMapValue(ret, 'checkCount', model.mCheckCount);
    setMapValue(ret, 'comments', model.mComments);
    setMapValue(ret, 'countryMasterId', model.mCountryMasterId);
    setMapValue(ret, 'countryMasterIdName', model.mCountryMasterIdName);
    setMapValue(ret, 'currencyCode', model.mCurrencyCode);
    setMapValue(ret, 'customsCurrencyCode', model.mCustomsCurrencyCode);
    setMapValue(ret, 'customsValue', model.mCustomsValue);
    setMapValue(ret, 'description', model.mDescription);
    setMapValue(ret, 'engineerMasterId', model.mEngineerMasterId);
    setMapValue(ret, 'engineerMasterIdName', model.mEngineerMasterIdName);
    setMapValue(ret, 'hazUNClassification', model.mHazUNClassification);
    setMapValue(ret, 'hazUNNo', model.mHazUNNo);
    setMapValue(ret, 'hsnCode', model.mHsnCode);
    setMapValue(ret, 'hsnCodeName', model.mHsnCodeName);
    setMapValue(ret, 'id', model.mId);
    setMapValue(ret, 'isCustomerLabel', model.mCustomerLabel);
    setMapValue(ret, 'isCustomerLabelName', model.mCustomerLabelName);
    setMapValue(ret, 'isHazardous', model.mHazardous);
    setMapValue(ret, 'isOversized', model.mOverSized);
    setMapValue(
        ret, 'isoCommodityCodesMasterId', model.mIsoCommodityCodesMasterId);
    setMapValue(ret, 'isoCommodityCodesMasterIdName',
        model.mIsoCommodityCodesMasterIdName);
    setMapValue(ret, 'labelsMasterId', model.mLabelsMasterId);
    setMapValue(ret, 'labelsMasterIdName', model.mLabelsMasterIdName);
    setMapValue(ret, 'manufacturedDate', model.mManufacturedDate);
    setMapValue(ret, 'maxHeight', model.mMaxHeight);
    setMapValue(ret, 'maxLength', model.mMaxLength);
    setMapValue(ret, 'maxWidth', model.mMaxWidth);
    setMapValue(ret, 'originCountry', model.mOriginCountry);
    setMapValue(ret, 'packQty', model.mPackQty);
    setMapValue(ret, 'partNumber', model.mPartNumber);
    setMapValue(ret, 'partTypesMasterId', model.mPartTypesMasterId);
    setMapValue(ret, 'partTypesMasterIdName', model.mPartTypesMasterIdName);
    setMapValue(ret, 'pickTypeMasterId', model.mPickTypeMasterId);
    setMapValue(ret, 'pickTypeMasterIdName', model.mPickTypeMasterIdName);
    setMapValue(ret, 'returnCodesMasterId', model.mReturnCodesMasterId);
    setMapValue(ret, 'returnCodesMasterIdName', model.mReturnCodesMasterIdName);
    setMapValue(ret, 'serialNo', model.mSerialNo);
    setMapValue(ret, 'specifySerialNoPick', model.mSpecifySerialNoPick);
    setMapValue(ret, 'unitTrackable', model.mUnitTrackable);
    setMapValue(ret, 'uomMasterId', model.mUomMasterId);
    setMapValue(ret, 'uomMasterIdName', model.mUomMasterIdName);
    setMapValue(ret, 'weight', model.mWeight);
    setMapValue(ret, 'actorId', model.mActorId);
    return ret;
  }

  @override
  PartsMasterDTO fromMap(Map map) {
    if (map == null) return null;
    final obj = PartsMasterDTO();
    obj.mAccountGroupMasterId = map['accountGroupMasterId'] as String;
    obj.mAccountGroupMasterIdName = map['accountGroupMasterIdName'] as String;
    obj.mAccountGrpName = map['accountGrpName'] as String;
    obj.mAccountMasterId = map['accountMasterId'] as String;
    obj.mAccountMasterIdName = map['accountMasterIdName'] as String;
    obj.mAuditFrequency = map['auditFrequency'] as String;
    obj.mBatchNo = map['batchNo'] as int;
    obj.mCheckCount = map['checkCount'] as int;
    obj.mComments = map['comments'] as String;
    obj.mCountryMasterId = map['countryMasterId'] as String;
    obj.mCountryMasterIdName = map['countryMasterIdName'] as String;
    obj.mCurrencyCode = map['currencyCode'] as String;
    obj.mCustomsCurrencyCode = map['customsCurrencyCode'] as String;
    obj.mCustomsValue = map['customsValue'] as String;
    obj.mDescription = map['description'] as String;
    obj.mEngineerMasterId = map['engineerMasterId'] as String;
    obj.mEngineerMasterIdName = map['engineerMasterIdName'] as String;
    obj.mHazUNClassification = map['hazUNClassification'] as String;
    obj.mHazUNNo = map['hazUNNo'] as String;
    obj.mHsnCode = map['hsnCode'] as String;
    obj.mHsnCodeName = map['hsnCodeName'] as String;
    obj.mId = map['id'] as String;
    obj.mCustomerLabel = map['isCustomerLabel'] as bool;
    obj.mCustomerLabelName = map['isCustomerLabelName'] as bool;
    obj.mHazardous = map['isHazardous'] as bool;
    obj.mOverSized = map['isOversized'] as bool;
    obj.mIsoCommodityCodesMasterId = map['isoCommodityCodesMasterId'] as String;
    obj.mIsoCommodityCodesMasterIdName =
        map['isoCommodityCodesMasterIdName'] as String;
    obj.mLabelsMasterId = map['labelsMasterId'] as String;
    obj.mLabelsMasterIdName = map['labelsMasterIdName'] as String;
    obj.mManufacturedDate = map['manufacturedDate'] as String;
    obj.mMaxHeight = map['maxHeight'] as int;
    obj.mMaxLength = map['maxLength'] as int;
    obj.mMaxWidth = map['maxWidth'] as double;
    obj.mOriginCountry = map['originCountry'] as int;
    obj.mPackQty = map['packQty'] as int;
    obj.mPartNumber = map['partNumber'] as String;
    obj.mPartTypesMasterId = map['partTypesMasterId'] as String;
    obj.mPartTypesMasterIdName = map['partTypesMasterIdName'] as String;
    obj.mPickTypeMasterId = map['pickTypeMasterId'] as String;
    obj.mPickTypeMasterIdName = map['pickTypeMasterIdName'] as String;
    obj.mReturnCodesMasterId = map['returnCodesMasterId'] as String;
    obj.mReturnCodesMasterIdName = map['returnCodesMasterIdName'] as String;
    obj.mSerialNo = map['serialNo'] as String;
    obj.mSpecifySerialNoPick = map['specifySerialNoPick'] as String;
    obj.mUnitTrackable = map['unitTrackable'] as bool;
    obj.mUomMasterId = map['uomMasterId'] as String;
    obj.mUomMasterIdName = map['uomMasterIdName'] as String;
    obj.mWeight = map['weight'] as int;
    obj.mActorId = map['actorId'] as String;
    return obj;
  }
}
