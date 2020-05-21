import 'dart:async';
import 'package:tvs_visibility/src/visibilitydealer/binning/model/partorbinvalidationmodel/partorbinvalidationmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/model/postbindetailsmodel/postbindetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/repository/binrepository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class PostBinDetailsBloc{
  var mProgressBar=BehaviorSubject<bool>();
  BinRepository mBinRepository;

  dispose(){
    mProgressBar.close();
  }

  PostBinDetailsBloc(this.mBinRepository);

  Function(bool) get showProgress => mProgressBar.sink.add;

  Observable<bool> get isLoading => mProgressBar.stream;

  Future<PartOrBinValidationModel> validatePartOrBin(String binOrPart,String orderId,String partNumber) async{
    showProgress(true);
    PartOrBinValidationModel partOrBinModel=PartOrBinValidationModel();
    partOrBinModel=await mBinRepository.validatePartOrBin(binOrPart, orderId,partNumber);
    print(partOrBinModel.mBinLocation);
    if(partOrBinModel.mError)
      mProgressBar.addError("Something went wrong!");
    else
      showProgress(false);
    return partOrBinModel;
  }

  Future<PostBinDetailsModel> postBinningDetailsModel(PostBinDetailsModel binDetails)async{
    showProgress(true);
    PostBinDetailsModel binResponse=PostBinDetailsModel();
    binResponse=await mBinRepository.postBinDetails(binDetails);
    if(binResponse.mError)
      mProgressBar.addError("Something went wrong!");
    return binResponse;
  }

}