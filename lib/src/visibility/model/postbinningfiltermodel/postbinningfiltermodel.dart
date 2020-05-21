import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:tvs_visibility/src/visibility/model/binninglistmodel/binninglistmodel.dart';

part 'postbinningfiltermodel.jser.dart';

@GenSerializer()
class PostBinningFilterModelSerializer extends Serializer<PostBinningFilterModel>
    with _$PostBinningFilterModelSerializer {}

class PostBinningFilterModel {
  @Alias("column")
  String mColumn;
  @Alias("search")
  String mSearch;
  @Alias("siteId")
  String mSiteId;
  @Alias("statusMasterId")
  String mStatusMasterId;
  @Alias("totalPages")
  int mTotalPages;
  @Alias("genericDTOList")
  List<BinningListModel> mBinningListModel;
  @Alias("totalElements")
  int mTotalElements;
  @Alias("pageSize")
  int mPageSize;
  @Alias("pageNumber")
  int mPageNumber;
  @Alias("userid")
  String mUserid;
  @Alias("pickerId")
  String mPickerId;
  @Alias("customerref")
  String mCustomerref;
  @Alias("paged")
  bool mPaged;

  PostBinningFilterModel(
      {this.mColumn,
        this.mSearch,
        this.mSiteId,
        this.mStatusMasterId,
        this.mTotalPages,
        this.mTotalElements,
        this.mPageSize,
        this.mPageNumber,
        this.mUserid,
        this.mPickerId,
        this.mCustomerref,
        this.mPaged});
}