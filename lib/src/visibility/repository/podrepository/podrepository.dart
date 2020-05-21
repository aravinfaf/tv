import 'package:tvs_visibility/src/visibility/model/podmodel/checkpodkeymodel.dart';
import 'package:tvs_visibility/src/visibility/model/podmodel/postfiltermodel.dart';
import 'package:tvs_visibility/src/visibility/networkprovider/podprovider/podnetprovider.dart';

class PodRepository {
  PodNetProvider mProvider;

  PodRepository(this.mProvider);

  Future<PostFilterModel> getPodList(PostFilterModel model)async {
   return await mProvider.onPodLists(model);
  }


  Future<List<CheckPodKeyModel>> getActiveTaskByVehicleInOutId(String vehicleInOutId) async{
    return await mProvider.onActiveTaskByVehicleInOutId(vehicleInOutId);
  }
}
