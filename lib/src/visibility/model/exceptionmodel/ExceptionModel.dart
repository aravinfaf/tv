import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'ExceptionModel.jser.dart';

@GenSerializer()
class ExceptionModelSerializer extends Serializer<ExceptionModel> with _$ExceptionModelSerializer
{}


class ExceptionModel {
  String cause;
  String error;
  String type;
  String title;
  String status;
  String detail;
  String message;
  String localizedMessage;

  ExceptionModel(
      {this.cause,
        this.error,
        this.type,
        this.title,
        this.status,
        this.detail,
        this.message,
        this.localizedMessage});



  ExceptionModel.fromJson(Map<String, dynamic> json) {
    this.status = json['status'];
    this.error = json['error'];
    this.message = json['message'];
    this.localizedMessage = json['localizedMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['error'] = this.error;
    data['message'] = this.message;
    data['localizedMessage'] = this.localizedMessage;
    return data;
  }

}