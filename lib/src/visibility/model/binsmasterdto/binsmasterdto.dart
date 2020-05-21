import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'binsmasterdto.jser.dart';

class BinsMasterDTO {
  @Alias("accountMasterId")
  String mAccountMasterId;
  @Alias("accountMasterName")
  String mAccountMasterName;
  @Alias("binHeight")
  int mBinHeight;
  @Alias("binLabel")
  String mBinLabel;
  @Alias("binLength")
  int mBinLength;
  @Alias("binLocation")
  String mBinLocation;
  @Alias("binTypesMasterId")
  String mBinTypesMasterId;
  @Alias("binTypesMasterName")
  String mBinTypesMasterName;
  @Alias("binWidth")
  int mBinWidth;
  @Alias("capacity")
  int mCapacity;
  @Alias("id")
  String mId;
  @Alias("siteMasterId")
  String mSiteMasterId;
  @Alias("siteMasterName")
  String mSiteMasterName;

  BinsMasterDTO(
      {this.mAccountMasterId,
        this.mAccountMasterName,
        this.mBinHeight,
        this.mBinLabel,
        this.mBinLength,
        this.mBinLocation,
        this.mBinTypesMasterId,
        this.mBinTypesMasterName,
        this.mBinWidth,
        this.mCapacity,
        this.mId,
        this.mSiteMasterId,
        this.mSiteMasterName});
}

@GenSerializer()
class BinsMasterDTOSerializer extends Serializer<BinsMasterDTO>
    with _$BinsMasterDTOSerializer {}
