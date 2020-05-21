

import 'package:tvs_visibility/src/visibility/model/preBinning/PreBinningScanRequestModel.dart';
import 'package:tvs_visibility/src/visibility/model/preBinning/preBinningModel.dart';
import 'package:tvs_visibility/src/visibility/model/preBinning/preBinningRequestModel.dart';
import 'package:tvs_visibility/src/visibility/model/preBinning/preBinningScanResponseModel.dart';

import '../../apiinterface/apiinterface.dart';
import '../../dataprovider/sharedprefs.dart';
import 'package:jaguar_resty/response/response.dart';

import '../../exceptionHandler/FetchDataException.dart';


class PreBinningNetProvider{

  ApiInterface mApiInterface;

  CustomSharedPrefs mCustomSharedPrefs;


  PreBinningNetProvider(this.mApiInterface, this.mCustomSharedPrefs);


  Future<PreBinningResponseModel> getPreBinningList(PreBinningRequestModel preBinningRequestModel) async {
    String token = await mCustomSharedPrefs.getToken();
    try {
      PreBinningResponseModel data = await mApiInterface.getPreBinningList(token, preBinningRequestModel);
      return data;
    } on Response catch (e) {
      var val = await FetchDataException(mCustomSharedPrefs, mApiInterface, e)
          .exceptionHandling();
      return val == FetchDataException.SUCCESS ? getPreBinningList(preBinningRequestModel) : null;
    }
  }


  Future<int> postPreBinningScan(PreBinningScanRequestModel preBinningScanModel) async {

    String token = await mCustomSharedPrefs.getToken();
    try {
      int data = await mApiInterface.postPreBinningScan(token, preBinningScanModel);
      return data;
    } on Response catch (e) {
      var val = await FetchDataException(mCustomSharedPrefs, mApiInterface, e)
          .exceptionHandling();
      return val == FetchDataException.SUCCESS ? postPreBinningScan(preBinningScanModel) : null;
    }
  }

}