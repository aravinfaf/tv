import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:tvs_visibility/src/visibility/model/endcustomerdetailmodel/endcustomerdetailmodel.dart';

part 'getdispatchdetailsmodel.jser.dart';


class GetDispatchDetailsModel{
  @Alias("endCustomerDTOList")
  List<EndCustomerDetailModel> mEndCustomerList;
  @Alias("engineerMasterDTOList")
  List<EndCustomerDetailModel> mEngineerMasterDTOList;
  @Alias("siteMasterDTOList")
  List<EndCustomerDetailModel>mSiteMasterDetailsModel;
}

@GenSerializer()
class GetDispatchDetailsModelSerializer extends Serializer<GetDispatchDetailsModel> with _$GetDispatchDetailsModelSerializer{}
