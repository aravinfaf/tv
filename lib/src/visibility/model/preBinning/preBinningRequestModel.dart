

import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'preBinningRequestModel.jser.dart';

class PreBinningRequestModel{

  String column;

  String search;

  int pageSize;

  int pageNumber;

  String taskkey;

  PreBinningRequestModel({this.column, this.search, this.pageSize,
      this.pageNumber, this.taskkey});

}


@GenSerializer()
class PreBinningRequestModelSerializer extends Serializer<PreBinningRequestModel> with

_$PreBinningRequestModelSerializer{}