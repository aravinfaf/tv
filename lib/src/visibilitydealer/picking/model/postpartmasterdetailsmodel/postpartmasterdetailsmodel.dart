import 'package:tvs_visibility/src/visibilitydealer/picking/model/binmasterdetailmodel/binmasterdetailmodel.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'postpartmasterdetailsmodel.jser.dart';

class PostPartMasterDetailsModel  {
  @Alias("siteId")
  String mSiteId;
  @Alias("quantity")
  int mQuantity;
  @Alias("partMasterId")
  String mPartMasterId;
  @Alias("partNumber")
  String mPartMaster;
  @Alias("partSerialNo")
  String mPartSerialNo;
  @Alias("partPickingDto")
  List<BinMasterDetailModel> mBinMasterDetailList;
  @Ignore()
  int mTotalQty;
  @Ignore()
  String mPartTypeMaster;
  @Ignore()
  bool mError=false;

  PostPartMasterDetailsModel({this.mTotalQty,this.mSiteId,this.mPartSerialNo,this.mBinMasterDetailList,this.mQuantity,this.mPartMasterId,this.mPartMaster,this.mPartTypeMaster});
}

@GenSerializer()
class PostPartMasterDetailsModelSerializer extends Serializer<PostPartMasterDetailsModel> with _$PostPartMasterDetailsModelSerializer{}
