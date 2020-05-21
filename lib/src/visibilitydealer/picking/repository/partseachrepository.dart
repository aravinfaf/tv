import 'package:tvs_visibility/src/visibilitydealer/picking/model/partnumberdetailsmodel/partnumberdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/netprovider/partsearchapiprovider.dart';

class PartSearchRepository {
  PartSearchApiProvider mApiProvider;

  PartSearchRepository(this.mApiProvider);

  Future<List<PartNumberDetailsModel>> onPartSearchResponse(String partNumber,int pageNumber,int pageSize) async =>
      await mApiProvider.getPartNumberSearchDetails(partNumber,pageNumber,pageSize);
}
