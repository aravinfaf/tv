import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'postfilterdetailsmodel.jser.dart';

class PostFilterDetailsModel{
  @Alias("searchText")
  String mSearchText;
  @Alias("searchColumn")
  String mSearchColumn;
  @Alias("siteId")
  String mSiteId;
  @Alias("userId")
  String mUserId;
  @Alias("search")
  bool mSearch;
  @Alias("pageNumber")
  String mPageNumber;
  @Alias("pageSize")
  String mPageSize;

  PostFilterDetailsModel({this.mSearchText,this.mSiteId,this.mUserId,this.mSearchColumn,this.mSearch,this.mPageNumber,this.mPageSize});
}

@GenSerializer()
class PostFilterDetailsModelSerializer extends Serializer<PostFilterDetailsModel>
    with _$PostFilterDetailsModelSerializer {}
