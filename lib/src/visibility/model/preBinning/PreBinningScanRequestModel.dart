import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'PreBinningScanRequestModel.jser.dart';

class PreBinningScanRequestModel{

  String userId;

  String statusCodeMasterId;

  String serialNo;

  String matinbound;

  String siteId;

  String taskKey;

  PreBinningScanRequestModel({this.userId, this.statusCodeMasterId, this.serialNo,
      this.matinbound, this.siteId, this.taskKey});


}

@GenSerializer()
class PreBinningScanRequestModelSerializer extends Serializer<PreBinningScanRequestModel> with _$PreBinningScanRequestModelSerializer{

}