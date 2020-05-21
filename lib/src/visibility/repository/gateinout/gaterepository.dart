import 'package:tvs_visibility/src/visibility/model/gateinout/creategatein.dart';
import 'package:tvs_visibility/src/visibility/model/gateinout/creategateout.dart';
import 'package:tvs_visibility/src/visibility/model/podmodel/postfiltermodel.dart';
import 'package:tvs_visibility/src/visibility/networkprovider/gateinout/gatenetprovider.dart';

class GateRepository {
  GateNetProvider mGateNetProvider;

  GateRepository(this.mGateNetProvider);

  Future<PostFilterModel> getGateLists(PostFilterModel model) async {
    return await mGateNetProvider.onGateLists(model);
  }

  Future<bool> gateOutVehicle(CreateGateOutModel createGateOutModel) async{
    return await mGateNetProvider.onGateOut(createGateOutModel);
  }

  Future<int> onGateIn (CreateGateInModel model) async {
    return await mGateNetProvider.onGateIn(model);
  }

}

