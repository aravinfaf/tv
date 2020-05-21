import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'sitemasterdetailsmodel.jser.dart';

class SiteMasterDetailsModel{
  @Alias("company")
  String mCompany;

}

@GenSerializer()
class SiteMasterDetailsModelSerializer extends Serializer<SiteMasterDetailsModel> with _$SiteMasterDetailsModelSerializer{}
