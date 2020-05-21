import 'package:tvs_visibility/src/visibilitydealer/picking/model/postdispatchmasterdetailsmodel/postdispatchmasterdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/postpartmasterdetailsmodel/postpartmasterdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/netprovider/partnooutwardprovider.dart';

class PartNumberOutwardRepository{
  PartNumberOutwardProvider mApiProvider;

  PartNumberOutwardRepository(this.mApiProvider);

  Future<List<PostDispatchMasterDetailsModel>> dispatchMaster(String dispatchTypeMasterId, String orderNumber, List<PostDispatchMasterDetailsModel> scanList,String userName,String mobile)async => mApiProvider.onDispatchMaster(dispatchTypeMasterId,orderNumber, scanList,userName,mobile);
}