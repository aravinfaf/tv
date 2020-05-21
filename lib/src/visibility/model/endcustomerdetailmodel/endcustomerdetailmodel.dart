import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'endcustomerdetailmodel.jser.dart';


class EndCustomerDetailModel{
  @Alias("id")
  String mId;

}

@GenSerializer()
class EndCustomerDetailModelSerializer extends Serializer<EndCustomerDetailModel> with _$EndCustomerDetailModelSerializer{}
