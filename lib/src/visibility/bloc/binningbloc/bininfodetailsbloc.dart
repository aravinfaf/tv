import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:tvs_visibility/src/visibility/model/bininfodetailsmodel/bininfodetailsmodel.dart';
import 'package:tvs_visibility/src/visibility/repository/binrepository.dart';

class BinInfoDetailsBloc{
  BinRepository mBinRepository;
  var mProgressBar=BehaviorSubject<bool>();

  dispose(){
    mProgressBar.close();
  }

  BinInfoDetailsBloc(this.mBinRepository);

  Function(bool) get showProgress => mProgressBar.sink.add;

  Observable<bool> get isLoad => mProgressBar.stream;

  Future<List<BinInfoDetailsModel>> getBinInfoDetailsModel(String partsInOrderId) async{
    showProgress(true);
    List<BinInfoDetailsModel> infoDetails=[];
    infoDetails=await mBinRepository.getBinInfoDetailsModel(partsInOrderId);
    showProgress(false);
    return infoDetails;
  }
}