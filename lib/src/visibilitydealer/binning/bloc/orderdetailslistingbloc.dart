import 'package:rxdart/subjects.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/model/ordermastermodel/ordermastermodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/model/postfilterdetailsmodel/postfilterdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/repository/ordermasterrepository.dart';

class OrderDetailsListingBloc{
  var mOrderMasterDetails = BehaviorSubject<List<OrderMasterModel>>();
  OrderMasterRepository mOrderMasterRepository;
  List<OrderMasterModel> lists = [];

  dispose(){
    mOrderMasterDetails.close();
  }

  OrderDetailsListingBloc(this.mOrderMasterRepository);

  Future<List<OrderMasterModel>> getOrderDetails(PostFilterDetailsModel postFilterModel) async {
    lists = await mOrderMasterRepository.getOrderMasterDetails(postFilterModel);
    if (lists.length!=0 && lists[0].mError)
      lists=null;
    return lists;
  }

}