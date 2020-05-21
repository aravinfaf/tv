import 'package:tvs_visibility/src/visibilitydealer/helper/base/baseautocompleteItem.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'partnumberdetailsmodel.jser.dart';

class PartNumberDetailsModel implements BaseAutoCompleteItem {
  @Alias("id")
  String mId;
  @Alias("partNumber")
  String mPartNumber;
  @Alias("partTypesMasterIdName")
  String mPartTypeMaster;
  @Ignore()
  bool mError=false;

  @override
  getData() {
    return this;
  }

  @override
  String getText() {
    return mPartNumber;
  }

  @override
  String getID() {
    return null;
  }
}

@GenSerializer()
class PartNumberDetailsModelSerializer extends Serializer<PartNumberDetailsModel> with _$PartNumberDetailsModelSerializer{}

