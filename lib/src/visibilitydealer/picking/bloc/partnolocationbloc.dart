import 'dart:async';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/partserialnumberdetailsmodel/partserialnumberdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/repository/partnorepository.dart';
import 'package:rxdart/rxdart.dart';

class PartNoLocationBloc {
  var mProgressBar = BehaviorSubject<bool>();
  PartNoRepository mRepository;

  void dispose() {
    mProgressBar.close();
  }

  PartNoLocationBloc(this.mRepository);

  Function(bool) get showProgress => mProgressBar.sink.add;

  Observable<bool> get isLoad => mProgressBar.stream;

  Future<PartSerialNumberDetailsModel> getSerialNumberValidation(String barcode,int quantity) async{
    showProgress(true);
    PartSerialNumberDetailsModel partSerialNumberDetails=PartSerialNumberDetailsModel();
    partSerialNumberDetails=await mRepository.validateSerialNumberDetails(barcode, quantity);
    if(partSerialNumberDetails.mError)
      mProgressBar.addError('Something went wrong!');
    else
      showProgress(false);
    return partSerialNumberDetails;
  }
}
