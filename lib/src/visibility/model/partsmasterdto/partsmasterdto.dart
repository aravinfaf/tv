import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'partsmasterdto.jser.dart';

@GenSerializer()
class PartsMasterDTOSerializer extends Serializer<PartsMasterDTO>
    with _$PartsMasterDTOSerializer {}

class PartsMasterDTO {
  @Alias("accountGroupMasterId")
  String mAccountGroupMasterId;
  @Alias("accountGroupMasterIdName")
  String mAccountGroupMasterIdName;
  @Alias("accountGrpName")
  String mAccountGrpName;
  @Alias("accountMasterId")
  String mAccountMasterId;
  @Alias("accountMasterIdName")
  String mAccountMasterIdName;
  @Alias("auditFrequency")
  String mAuditFrequency;
  @Alias("batchNo")
  int mBatchNo;
  @Alias("checkCount")
  int mCheckCount;
  @Alias("comments")
  String mComments;
  @Alias("countryMasterId")
  String mCountryMasterId;
  @Alias("countryMasterIdName")
  String mCountryMasterIdName;
  @Alias("currencyCode")
  String mCurrencyCode;
  @Alias("customsCurrencyCode")
  String mCustomsCurrencyCode;
  @Alias("customsValue")
  String mCustomsValue;
  @Alias("description")
  String mDescription;
  @Alias("engineerMasterId")
  String mEngineerMasterId;
  @Alias("engineerMasterIdName")
  String mEngineerMasterIdName;
  @Alias("hazUNClassification")
  String mHazUNClassification;
  @Alias("hazUNNo")
  String mHazUNNo;
  @Alias("hsnCode")
  String mHsnCode;
  @Alias("hsnCodeName")
  String mHsnCodeName;
  @Alias("id")
  String mId;
  @Alias("isCustomerLabel")
  bool mCustomerLabel;
  @Alias("isCustomerLabelName")
  bool mCustomerLabelName;
  @Alias("isHazardous")
  bool mHazardous;
  @Alias("isOversized")
  bool mOverSized;
  @Alias("isoCommodityCodesMasterId")
  String mIsoCommodityCodesMasterId;
  @Alias("isoCommodityCodesMasterIdName")
  String mIsoCommodityCodesMasterIdName;
  @Alias("labelsMasterId")
  String mLabelsMasterId;
  @Alias("labelsMasterIdName")
  String mLabelsMasterIdName;
  @Alias("manufacturedDate")
  String mManufacturedDate;
  @Alias("maxHeight")
  int mMaxHeight;
  @Alias("maxLength")
  int mMaxLength;
  @Alias("maxWidth")
  double mMaxWidth;
  @Alias("originCountry")
  int mOriginCountry;
  @Alias("packQty")
  int mPackQty;
  @Alias("partNumber")
  String mPartNumber;
  @Alias("partTypesMasterId")
  String mPartTypesMasterId;
  @Alias("partTypesMasterIdName")
  String mPartTypesMasterIdName;
  @Alias("pickTypeMasterId")
  String mPickTypeMasterId;
  @Alias("pickTypeMasterIdName")
  String mPickTypeMasterIdName;
  @Alias("returnCodesMasterId")
  String mReturnCodesMasterId;
  @Alias("returnCodesMasterIdName")
  String mReturnCodesMasterIdName;
  @Alias("serialNo")
  String mSerialNo;
  @Alias("specifySerialNoPick")
  String mSpecifySerialNoPick;
  @Alias("unitTrackable")
  bool mUnitTrackable;
  @Alias("uomMasterId")
  String mUomMasterId;
  @Alias("uomMasterIdName")
  String mUomMasterIdName;
  @Alias("weight")
  int mWeight;
  @Alias("actorId")
  String mActorId;

  PartsMasterDTO(
      {this.mAccountGroupMasterId,
        this.mAccountGroupMasterIdName,
        this.mAccountGrpName,
        this.mAccountMasterId,
        this.mAccountMasterIdName,
        this.mAuditFrequency,
        this.mBatchNo,
        this.mCheckCount,
        this.mComments,
        this.mCountryMasterId,
        this.mCountryMasterIdName,
        this.mCurrencyCode,
        this.mCustomsCurrencyCode,
        this.mCustomsValue,
        this.mDescription,
        this.mEngineerMasterId,
        this.mEngineerMasterIdName,
        this.mHazUNClassification,
        this.mHazUNNo,
        this.mHsnCode,
        this.mHsnCodeName,
        this.mId,
        this.mCustomerLabel,
        this.mCustomerLabelName,
        this.mHazardous,
        this.mOverSized,
        this.mIsoCommodityCodesMasterId,
        this.mIsoCommodityCodesMasterIdName,
        this.mLabelsMasterId,
        this.mLabelsMasterIdName,
        this.mManufacturedDate,
        this.mMaxHeight,
        this.mMaxLength,
        this.mMaxWidth,
        this.mOriginCountry,
        this.mPackQty,
        this.mPartNumber,
        this.mPartTypesMasterId,
        this.mPartTypesMasterIdName,
        this.mPickTypeMasterId,
        this.mPickTypeMasterIdName,
        this.mReturnCodesMasterId,
        this.mReturnCodesMasterIdName,
        this.mSerialNo,
        this.mSpecifySerialNoPick,
        this.mUnitTrackable,
        this.mUomMasterId,
        this.mUomMasterIdName,
        this.mWeight});
}
