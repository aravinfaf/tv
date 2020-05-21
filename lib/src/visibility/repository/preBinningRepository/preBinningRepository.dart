

import 'package:tvs_visibility/src/visibility/model/preBinning/PreBinningScanRequestModel.dart';
import 'package:tvs_visibility/src/visibility/model/preBinning/preBinningModel.dart';
import 'package:tvs_visibility/src/visibility/model/preBinning/preBinningRequestModel.dart';
import 'package:tvs_visibility/src/visibility/model/preBinning/preBinningScanResponseModel.dart';
import 'package:tvs_visibility/src/visibility/networkprovider/preBinningProvider/preBinningProvider.dart';

class PreBinningRepository{

  PreBinningNetProvider provider;


  PreBinningRepository(this.provider);


  Future<PreBinningResponseModel> getPreBinning(PreBinningRequestModel preBinningRequestModel) async {
    return await provider.getPreBinningList(preBinningRequestModel);
  }

  Future<int> postPreBinningScan(PreBinningScanRequestModel scanModel) async {
    return await provider.postPreBinningScan(scanModel);
  }


}