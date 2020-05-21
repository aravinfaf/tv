import 'package:tvs_visibility/src/visibilitydealer/picking/model/partserialnumberdetailsmodel/partserialnumberdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/postpartmasterdetailsmodel/postpartmasterdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/netprovider/partnoapiprovider.dart';

class PartNoRepository {
  PartLocationApiProvider mApiProvider;

  PartNoRepository(this.mApiProvider);

  Future<List<PostPartMasterDetailsModel>> getPartAvailableBin(List<PostPartMasterDetailsModel> model) async => mApiProvider.onPartAvailableBin(model);

  Future<PartSerialNumberDetailsModel> validateSerialNumberDetails(String serialNumber,int quantity) async=> mApiProvider.onValidateSerialNumber(serialNumber, quantity);

}
