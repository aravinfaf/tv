import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'engineermasterdtolist.jser.dart';

@GenSerializer()
class EngineerMasterDetailsModelSerializer  extends Serializer<EngineerMasterDetailsModel>
    with _$EngineerMasterDetailsModelSerializer {}

class EngineerMasterDetailsModel {
  String id;

  EngineerMasterDetailsModel({this.id});
}
