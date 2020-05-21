import 'package:tvs_visibility/src/visibility/dataprovider/sharedprefs.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/model/binlocationmodel/binScanningRequest.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/model/binlocationmodel/binScanningResponse.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/model/binlocationmodel/binlocationmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/model/partorbinvalidationmodel/partorbinvalidationmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/model/postbindetailsmodel/postbindetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/netprovider/binnetprovider.dart';
import 'package:tvs_visibility/src/visibilitydealer/bintobintransfer/model/binmasterdetailsmodel/binmasterdetailsmodel.dart';

class BinRepository{
  BinNetProvider mBinNetProvider;
  CustomSharedPrefs mSharedPrefs;

  BinRepository(this.mBinNetProvider,this.mSharedPrefs);

  Future<List<BinLocationModel>> getBinLocationSearchList(String binLocation) async => await mBinNetProvider.onBinLocationList(binLocation);

  Future<PostBinDetailsModel> postBinDetails(PostBinDetailsModel model) async =>await mBinNetProvider.partBinning(model);

  Future<PartOrBinValidationModel> validatePartOrBin(String binOrPart,String orderId,String partNumber) async =>  mBinNetProvider.onValidatePartOrBin(binOrPart,orderId,partNumber);

  Future<BinMasterDetailsModel> singleBinToBinTransfer(String binOrPart,String binId) async =>  mBinNetProvider.onSingleBinToBinTransfer(binOrPart,binId);

  Future<BinScanningResponse> validatePartOrBin1(BinScanningRequest request) async =>  mBinNetProvider.onValidatePartOrBin1(request);

  Future<BinScanningResponse> vPartBinning(BinScanningRequest request) async =>  mBinNetProvider.vPartBinning(request);

}