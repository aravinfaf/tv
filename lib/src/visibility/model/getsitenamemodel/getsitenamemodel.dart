import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:tvs_visibility/src/visibility/model/sitemasterdetailsmodel/sitemasterdetailsmodel.dart';
part 'getsitenamemodel.jser.dart';


class GetSiteNameModel{
  @Alias("siteMasterDTOList")
  List<SiteMasterDetailsModel> siteMasterDetails;

}

@GenSerializer()
class GetSiteNameModelSerializer extends Serializer<GetSiteNameModel> with _$GetSiteNameModelSerializer{}
