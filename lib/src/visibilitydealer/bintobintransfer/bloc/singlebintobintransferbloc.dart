import 'dart:async';

import 'package:tvs_visibility/src/visibility/constants/baseconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/repository/binrepository.dart';
import 'package:tvs_visibility/src/visibilitydealer/bintobintransfer/model/binmasterdetailsmodel/binmasterdetailsmodel.dart';
import 'package:rxdart/rxdart.dart';

class SingleBinToBinTransferBloc{
  var mProgressBar=BehaviorSubject<bool>();
  BinRepository mBinRepository;

  dispose(){
    mProgressBar.close();
  }

  SingleBinToBinTransferBloc(this.mBinRepository);

  Function(bool) get showProgress => mProgressBar.sink.add;

  Observable<bool> get isLoading => mProgressBar.stream;

  Future<BinMasterDetailsModel> singleBinToBinTransfer(String binOrPart,String binId) async{
    showProgress(true);
    BinMasterDetailsModel binMasterDetails=BinMasterDetailsModel();
    binMasterDetails=await mBinRepository.singleBinToBinTransfer(binOrPart,binId);
    if(binMasterDetails.mError)
      mProgressBar.addError('Something went wrong!');
    else
      showProgress(false);
    return binMasterDetails;
  }

}