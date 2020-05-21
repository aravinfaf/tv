
import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'creategateout.jser.dart';


@GenSerializer()
class CreateGateOutModelSerilizer extends Serializer<CreateGateOutModel>
    with _$CreateGateOutModelSerilizer {}

class CreateGateOutModel {
  String gateInNumber;
  String gateOutTime;

  CreateGateOutModel(
      {this.gateInNumber,
        this.gateOutTime});

  Map<String, dynamic> toJson() => serializer.toMap(this);

  static final serializer =CreateGateOutModelSerilizer();
  static CreateGateOutModel fromMap(Map map) => serializer.fromMap(map);

  String toString() => toJson().toString();
}