import 'package:tvs_visibility/src/visibilitydealer/binning/model/ordermastermodel/ordermastermodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/model/postfilterdetailsmodel/postfilterdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/binning/netprovider/ordermasternetprovider.dart';

class OrderMasterRepository{
  OrderMasterNetProvider mOrderMasterNetProvider;

  OrderMasterRepository(this.mOrderMasterNetProvider);

  Future<List<OrderMasterModel>> getOrderMasterDetails(PostFilterDetailsModel postFilterModel) async=>await mOrderMasterNetProvider.getOrderMasterDetails(postFilterModel);

}