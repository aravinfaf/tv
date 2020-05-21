import 'package:tvs_visibility/src/visibilitydealer/helper/base/baseautocompleteItem.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'binlocationmodel.jser.dart';

@GenSerializer()
class BinLocationModelSerializer extends Serializer<BinLocationModel>
    with _$BinLocationModelSerializer {}

class BinLocationModel implements BaseAutoCompleteItem {
  @Alias('id')
  String mId;
  @Alias('binLabel')
  String mBinLabel;
  @Alias('binLocation')
  String mBinLocation;
  @Alias('scanStatus')
  String mAllowPicking;
  @Ignore()
  bool mError=false;

  BinLocationModel({this.mId, this.mBinLabel, this.mBinLocation,this.mAllowPicking});

  @override
  getData() {
    return this;
  }

  @override
  String getID() {
    return mId;
  }

  @override
  String getText() {
    return mBinLabel;
  }
}
