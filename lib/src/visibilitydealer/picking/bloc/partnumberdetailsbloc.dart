import 'dart:async';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/partnumberdetailsmodel/partnumberdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/postpartmasterdetailsmodel/postpartmasterdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/repository/partnorepository.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/repository/partseachrepository.dart';
import 'package:rxdart/rxdart.dart';

class PartNumberDetailsBloc{
  var mProgressBar=BehaviorSubject<bool>();
  PartNoRepository mPartNoRepository;
  PartSearchRepository mPartSearchRepository;
  List<PartNumberDetailsModel> lists = [];

  dispose(){
    mProgressBar.close();
  }

  PartNumberDetailsBloc(this.mPartSearchRepository,this.mPartNoRepository);

  Function(bool) get showProgress => mProgressBar.sink.add;

  Observable<bool> get isLoad => mProgressBar.stream;

  Future<List<PartNumberDetailsModel>> searchPart(String serialNumber,int pageNumber,int pageSize) async {
      lists = await mPartSearchRepository.onPartSearchResponse(serialNumber,pageNumber,pageSize);
    return lists;
  }

  Future<List<PostPartMasterDetailsModel>> validatePartAvailableBin(List<PostPartMasterDetailsModel> model) async{
    showProgress(true);
    List<PostPartMasterDetailsModel> partDetails=[];
    partDetails=await mPartNoRepository.getPartAvailableBin(model);
    if(partDetails.length!=0 && partDetails[0].mError)
      mProgressBar.addError('Something went wrong!');
    else
      showProgress(false);
    return partDetails;
  }


}